\newpage

© 2022 Rendered Text. All rights reserved.

This work is licensed under Creative Commons
Attribution-NonCommercial-NoDerivatives 4.0 International.
To view a copy of this license, visit
<https://creativecommons.org/licenses/by-nc-nd/4.0>

This book is open source:
<https://github.com/semaphoreci/book-microservices>

Published on the Semaphore website:
[https://semaphoreci.com/resources/microservices](https://semaphoreci.com/resources/microservices?utm_medium=social&utm_source=pdf&utm_campaign=microserviceshandbook)

$MONTHYEAR: First edition v1.0 (revision $REVISION)

\newpage

Share this book:

> _I’ve just started reading “Transitioning from Monolith to Microservices Handbook” a free ebook by @semaphoreci: https://bit.ly/3eWMTA0 ([Tweet this!](https://ctt.ac/fywdO))_

\newpage

## Preface

Microservices are the most scalable way of developing software. As projects grow in size and complexity, one of the possible ways forward is to break the system into autonomous microservices and hand them out to different teams. 

Given the advantages, one would be forgiven for thinking that microservices are the superior architecture. But there are some caveats that, if ignored, can lead to development hell. This book aims to help you decide when migrating your monolith to the microservice architecture is a good idea, if so, navigate the choppy waters ahead.

## Who Is This Book for, and What Does It Cover?

This book is intended for software engineers at every level and tech leaders who are either exploring microservice architecture or are faced with serious scalability problems in their monolith applications.

- In chapter 1 we define microservices and weight this architecture model against the alternatives. If you're unsure if microservices is right for your project, be sure to not skip this chapter.
- Chapter 2 talks about the cultural transformation a company must undergo to be effective at microservice design and operations.
- Chapter 3 covers design techniques for microservice application. We take a deep dive into Domain-Driven Design and how it applies to microservices.
- Chapter 4 goes to the core of breaking up the monolith. We lay a plan for the migration, discuss the steps required to prepare the monolith before the transition, and explore techniques for testing microservice applications.
- Chapter 5 covers the operational side of running a microservice application, including deployment and release management.

## Additional recommended reading

You won't learn absolutely everything you need to design and run microservices in this book. Instead, the focus is to break up a monolith since this is the most common (and even recommended) path to microservices. As supplementary material, we recommend the following free ebooks also published by Semaphore:

- [CI/CD with Docker and Kubernetes](https://semaphoreci.com/resources/cicd-docker-kubernetes): it's common practice to run microservices with containers and orchestrate them with Kubernetes. This book will introduce both concepts and show step-by-step how to work with them.
- [CI/CD for Monorepos](https://semaphoreci.com/resources/monorepo-cicd): monorepos are a popular way of organizing and developing microservice codebases. This book will show you the best ways of working with monorepos.

## How to Contact Us

We would very much love to hear your feedback after reading this book. What did you like and learn? What could be improved? Is there something we could explain further?

A benefit of publishing an ebook is that we can continuously improve it. And that’s exactly what we intend to do based on your feedback.

You can send us feedback by sending an email to <learn@semaphoreci.com>.

Find us on Twitter: <https://twitter.com/semaphoreci>

Find us on Facebook: <https://facebook.com/SemaphoreCI>

Find us on LinkedIn: <https://www.linkedin.com/company/rendered-text>

## About the Authors

**Pablo Tomas Fernandez Zavalia** is an electronic engineer and writer. He started out developing for the City Hall of Buenos Aires  (buenosaires.gob.ar). After graduating, he joined British Telecom as head of the Web Services department in Argentina. He then worked for IBM as a database administrator, where he also did tutoring, DevOps, and cloud migrations. In his free time, he enjoys writing, sailing, and board games. Follow Tomas on Twitter at [\@tomfernblog](https://twitter.com/tomfernblog).

**Lee Atchison** is a software architect, published author, and frequent public speaker on the topics of cloud computing and application modernization. Follow Lee at [\@leeatchison](https://twitter.com/leeatchison).

## About the Editor

**Marko Anastasov** is a software engineer, author, and entrepreneur. Marko co-founded Rendered Text, the software company behind the Semaphore CI/CD service. He worked on building and scaling Semaphore from an idea to a cloud-based platform used by some of the world’s best engineering teams. Follow Marko on Twitter at [\@markoa](https://twitter.com/markoa).

## About the Reviewer

**Dan Ackerson** picked up most of his soft and hardware troubleshooting skills in the US Army. A decade of Java development drove home to operations, scaling infrastructure to cope with the thundering herd. Engineering coach and CTO of Teleclinic.

