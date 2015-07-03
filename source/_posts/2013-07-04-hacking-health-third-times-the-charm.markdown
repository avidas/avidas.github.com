---
layout: post
title: "Hacking health - Third times the charm"
date: 2013-07-04 23:37
comments: true
sharing: true
categories: Hackathon, Flask, Coding
---

{% img left /images/PocketHealth_home.jpg 275 670 'PocketHealth home' 'PocketHealth home' %}

When I think of healthcare industry from a technical view, it seems like a story of regulations, walled gardens and aged systems. It remains a sector where tech really needs to deliver, and we are currently seeing a surge of start-ups such as Quantified Self taking on different issues. So when I stepped into the Northside Festival's "Hacking Health", I was not entirely sure what to expect. It was also an unusual hackathon in that the venues were different on two different days. All the pleasant surprise that we ended up winning the hackathon!

The project I ended up working on was definitely something I would want myself. I worked on PocketHealth, and the idea? Carry, check and transfer your medical information like you do a contact. The user can select care givers who can potentially have edit access to the history. But the kicker is in the UI. We worked on a facebook timeline like view for the history, and carrying and sharing your medical medication can be as easily as sharing a facebook profile. Although privacy would need to matter more than a facebook profile, specially with information that is by definition very personal.

<!-- more -->

I worked on the backend, working with the Shin-ny API, which provided sample client data. Even though, it did work out in the end, one suggestion to the API providers would be to move away from SOAP and provide a JSON API alongside XML. That is the direction in which the world is going in 2013, and precious moments can be saved by not having to parse through the vortex of XML. Moreover, want to have more developers using your API? Use the specifications with the widest and easiest use cases. 

The app was running on Flask, a micro web-framework written in Python. Python's philosophy of "what you see is what you get" seems to be followed by flask. Together with the fast setup, Flask really wins as a hackathon-friendly backend framework. It would be interesting to compare the hurdles of building a larger scale web app vs other web frameworks. However, setting up assets, routes and getting up and running was possible in a matter of minutes. This is hugely valuable in time crunching hackathons, freeing up time for third-party APIs, application logic and UI.

Judges came from the NYeC, Bing and the NorthSide Festival. It felt great since we only worked for around six hours and were racing on till the last minute for submission. The judges were appreciative of the different sides we managed to involve and deliver value to, and it was great to be validated. There were some other interesting projects as well, one in particular about gamifying medication reminders for diabetic patients. 

In the coming weeks, it would be fun to take it past a hackathon project. A centralized solution for accessing and sharing health information is rather difficult, as there are many players involved, hospitals, insurance, doctors and patients. Many aspects of it seems to call for experience. Healthcare has a lot of room for innovation, and we believe that our app would solve a very real problem. At any rate, it felt great as a newbie to have contributed in a small way to the changing tides of healthcare.

{% img left /images/Patient_forms.jpg 350 350 'Patient forms' 'Patient forms' %}
{% img right /images/Patient_status.jpg 350 350 'Patient status' 'Patient status' %}