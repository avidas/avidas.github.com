---
layout: post
title: "Scipy 2014: Python as expression to push boundaries in science"
date: 2014-07-13 20:22
comments: true
categories: Python, SciPy
---

It's not everyday that the person sitting next to you interacts with Mars Rovers everyday or is trying to build a data pipeline to handle petabyte-scale genomics data. But that was perhaps the key takeway from my first [Python conference](https://conference.scipy.org/scipy2014/): a large number of people pushing the boundaries in scientific disciplines and using Python as their means of expression.

I have been using Python for a while now, both at work and for hobby projects but until of late have mostly been in the peripheries in contributions to open source projects. When I learned about Scientific Python conference right near to me in Austin, I was immediately interested. If you buy that there is such a thing as language wars, scientific computing has been one of Python's key wins. With libraries such as NumPy, Matplotlib and Pandas (and of course IPython), Python have dominated the Scientific Python landscape alongside R and Julia. 

When such a strong ecosystem is matched by a very welcoming community, there is a recipe for a conference worth being at. Well, If you can get past the imposter syndrome of being at a place with the highest density of phds of any place I have ever been at. 

### Takeaways

1. **Python catching up in areas where it lacked**: 
Performance, distribution, scalibility and reproducability were some of main themes at the conference. This addresses some of the historic lackings of the language. Sometimes this is via adoption of new tools such as docker for containerizing work enviroments for remote co-working researchers. Dependency on other languages has been one of the major pain points in working with the scientific Python libraries, so it is great to see Conda and HashDist (which I just discovered) to take that head on. Interoperability and scalability are two of the main problems Blaze is solving, and Bokeh and Plotly takes on the problems of publishing and sharing interactive visualizations in Python.

2. ** New tools for my workflow**:
There are many tools which deserve a space here, but I was primarily exited to discover pyspark, yt, plotly, sumatra/vistrails, hashdist and airspeed velocity. Version control and workflow control are familiar terratories for software engineers, but the idea of event control was new to me, something explored in a Birds of a feather discussion.

3. **Birds of a Feather talks are revealing**:
Birds of a feather discussions were sometimes my favorite, where there was candid sharing of painpoints and their solutions from the community members. It was also good to know what were the open problems in various areas are as they often indicate valuable areas to focus on.

<!-- more -->

4. **Contributions are needed**:
It was great to see a lot of egoless collaboration during the conference. Maintainers of projects were willing to deprecate their hard work in favor of a better accepted tool in the community. At the same time, lot of the development of very instrumental tools seem to be done by a small group of people, highlighting the need for more collaborators in this space.

5. **Sprints are like speed dating for open source projects**:
SciPy sprints were very different environment from hackathons. With the removal of prize as a factor, what remains is people who enjoy their work and often are highly productive. With the large number of projects available and the acceptance by the core developers, I had the opportunity to work on the charting library Bokeh, serialization library Dill, hack on datasets with yt developers (because random access over a 32 TB file served by apache to generate a graph on Ipython fully client side is seriously impressive) and dig into dockerizing web apps and databases with the reproducable workflow group. All in two days work.

As someone who is primarily an app developer, this conference was challenging as I have diverged from the path of scientific research a while back. Despite that, I have came away with a strong appreciation for the scientific python community and ecosystem and must thank PayPal for letting me attend the confrence.

To finish, the keynote on the third day by Greg Wilson was quite fantastic and you should check it out if you haven't already:

{% youtube 1e26rp6qPbA %}