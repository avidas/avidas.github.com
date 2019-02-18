---
layout: page
title: "dripper"
author: "Avi Das"
date: 2015-09-07 07:21
comments: true
sharing: true
footer: true
brief: "SaaS for Drip campaigns using Twitter direct messages"
---

## [Dripper](http://www.dripper.io/)
#### Status: Sunset

Build a SaaS for Drip campaigns using Twitter direct messages. I was the primary developer on the project and my co founder was split between coding and marketing. The tech stack was chosen primarily due to level of comfort with these tools and also being suitable for rapid prototyping and library availability.

Key challenges here was to comply with the twitter API, avoiding feature creep.

Ultmately the product was sunset due to insufficient traction.

### Tech stack
- Node.js, Express, Gulp, Feathers.js
- React, Bootstrap
- Mongo - Database for the user facing software.
- Python - Background jobs and utility scipts
- Redis - Used [Rq](http://python-rq.org/) as a simple task queue to process background jobs.

{% portfolio Dripper %}
