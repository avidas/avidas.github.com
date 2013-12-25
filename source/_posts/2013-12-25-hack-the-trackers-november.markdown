---
layout: post
title: "Hack the Trackers"
date: 2013-12-25 15:49
comments: true
sharing: true
categories: Hackathon, Security, Tracking, Python
---

Online tracking has been a peak topic of debate this year and by the look of things will continue to be. NSA programs, Snowden and the reactions from top tech companies brought in more attention to tracking than ever before. It was hence very timely for Evidon/Ghostery to organize hack the trackers in early November.

[Ghostery](https://www.ghostery.com/) is a chrome extension that displays trackers on a particular webpage. Not only that, they allow features to block particular trackers and include detailed information about the trackers. The emphasis seems to make web users aware of tracking and let them make the choice.

We built Falcon, which we thought would complement Ghostery's offering quite well. Falcon is a chrome extension where we displayed the overall lost time due to the trackers and which trackers were the most resource intensive. Our hypothesis was that to increase awareness of online tracking, we needed to provide tangible ways in which tracking affects online browsing experience. Ghostery provided us with a data set with a lot of interesting information, among which average load time for trackers was a key indicator. Even with caching, users could lose time which would take to load the trackers, if trackers are loaded synchronously. This could particularly matter for mobile and locations with poor wi-fi as poorly created trackers would slow down the browsing experience.

{% img right /images/falcon.png 500 900 'Falcon Demo' 'Falcon Demo' %}

Building a chrome extension for a first time was not too complicated as it is very similar to building a web page and chrome is as reliable as platforms get. We ended up being one of the two semi finalists, the other being a cool way to link the trackers with their public figures as a fun way to raise attention to tracking.

This hackathon was particularly a great learning experience. Companies are taking highly innovative routes to glean more information about the users. Cookies have always existed, but two other forms of tracking I learnt was autocomplete fields tracking and [browser fingerprinting](http://en.wikipedia.org/wiki/Device_fingerprint). Browser fingerprinting tries to get information from user-agent, the OS, extensions installed and other configurations to bind a particular browser to an user and this can happen completely on the server side. I have only learnt fairly recently about the bidding platforms for display advertisement and it was pretty interesting to see dictionary.com revealing on their console the bids as they happened in real time.

Computer security is a dynamic and fast changing field and this hackathon was an interesting mix of people in different niches of the industry. Tracking will continue to be an issue and it was good to see Ghostery taking the initiative to search for innovations in this space.
