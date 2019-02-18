---
layout: post
title: "How Browserify improves Client-side Development"
date: 2015-07-16 14:41
comments: true
published: true
categories: Software Javascript, Browserify, Node.js
---

#### For a more modular, maintainable Frontend

As Single Page Applications gain in popularity, the size of front end codebases keeps growing rapidly. For keeping these codebases maintainable, modularity becomes a priority. The easier it is to modularize code, the more incentives developers will have for doing so. With the ease of modularity with CommonJS, npm has seen explosive growth of packages published which has helped the Node ecosystem greatly. Browserify brings that ease to client side development leveraging the CommonJS module system. When used with build tools such as Grunt or Gulp, you can write modular client side code just like you would write your server side Node code, and Browserify takes care of the bundling for you. There is much less excuse these days to make everything global and attach to the window object!

#### Leveraging npm modules

{% img left /images/Modulecounts.jpg 800 670 'Package Manager Traction' 'Package Manager Traction' %}

Looking at the graph above is a big selling point when trying to evaluate the value Browserify can bring to your client side workflow. The graph is a comparison of the rate at which packages are getting published in different package managers Bower, PyPI, RubyGems. npm leads the pack easily. Recently, jQuery registry stopped accepting new plugins, with [new packages being published on npm](http://blog.npmjs.org/post/111475741445/publishing-your-jquery-plugin-to-npm-the-quick). Cordova recently announced the same change, moving plugins to npm. npm is now hosting much broader range of modules than only server-side Node.js modules and Browserify can help you leverage these modules on the front-end. The flipside of this as a module publisher is that publishing modules on npm now gives you access to a much broader audience since people might use the module on the browser, custom hardware etc.

#### How it works

In the CommonJS syntax, the "exports" object is the public API of a module and "require" can be used to include a module in your javascript file. Since browsers do not have require available, Browserify traverses the [dependency trees](https://github.com/substack/browserify-handbook#how-browserify-works) of all the required modules, and bundles the dependencies into one self contained file that you can just include with a script tag on the browser. Browserify is aware of package.json and the order in which node_modules are resolved. Moreover, it supports built in Node modules e.g. path and gloabls e.g. Buffer so you have access of those in the client side as well. 

#### Transforms

Core Browserify only bundles modules written in the CommonJS syntax, adhering to the single responsibility principle. However, there are other ways of modularizing client side code, AMD and Global Variables being the two usual ones. Instead of handling every possibly of modules, Browserify exposes a Transforms API so that a plugin can be built which can preprocess a file into Javascript in CommonJS syntax which Browserify can then consume. This means that you can write modular code just like your node codebases regardless of what module system your dependencies may adhere to. There are also lot of people writing in languages that compile into Javascript, such as CoffeeScript or TypeScript. To handle this, there are transforms available for AMD (deamdify), Bower modules (debowerify), globals (deglobalify), coffeescript(coffeeify), harmony (es6ify) etc. A simple search of Browserify on Github or npm brings up thousands of modules and attests to the [ecosystem around Browserify](https://github.com/substack/node-browserify/wiki/list-of-transforms). Delegating to transforms helps to keep the footprint of Browserify smaller, while makes it more extensible.

<!-- more -->

#### Using with Build Tools

Software is great when it just works and you do not have tinker with it all the time. Grunt/Gulp are great for this kind of configure once, build whenever workflow. Browserify is available as a command line tool primarily, but has Grunt and Gulp plugins which can be used to easily integrate Browserify into your build. There is also watchify, which can reduce build time by monitoring source files and incrementally rebuilding the front end bundle on the fly. For large projects, this is really useful to keep the build times small.

#### Alternatives

There are always alternatives available in the JavaScript world, and Webpack, RequireJS and Component being some of the major ones. RequireJS has been around for longer and primarily supports the AMD specification, but has support for CommonJS too. Webpack tends to do better with static assets that your client side requires and tries to cover a broader issue of bundling all static assets. With picking any tool, it's good to be aware of the alternatives, the problem they were designed to solve, and benefits and drawbacks of each. It makes for [quite interesting debate](https://gist.github.com/substack/68f8d502be42d5cd4942) at times as well.

#### Resources

Browserify has really good documentation and the [browserify handbook](https://github.com/substack/browserify-handbook) is a great resource for an extensive runthrough. For getting started, the nodeschool module called [browserify-adventure](https://github.com/substack/browserify-adventure) is very handy.

#### Conclusion

The browser community is unlikely to adopt a module system anytime soon. Harmony/ES6 includes a module definition but it will take time before it gets adopted by all the browsers. Moreover, there have been [resistance from some notable developers](https://esdiscuss.org/topic/es6-modules-sorry).

Browserify offers a great way to abstract away that issue. With access to a vast amount of modules, there is much less of a need for reinventing the wheel on the client side, and fewer script tags thrown around everywhere. Client side software development is evolving fast, and Browserify has made significant progress to minimize some of that complexity.

If you are using browserify/webpack in production, I would love to know the tradeoffs/issues you have ran into. Comments/feedback here or [contact](mailto:avi@aviadas.com).

