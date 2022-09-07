## 4.3 Preparing your monolith for transitioning to microservices

A rewrite is never an easy journey, but by moving from monolith to  microservices, you are changing more than the way you code; you are  changing the company’s operating model. As we've already mentioned, not only do you have to learn a new, more complex tech stack but management will also need to adjust the work culture and reorganize your teams.

## 4.4 A migration plan 

It takes a lot of preparation to tear down a monolith, especially when the old system must remain operational while the transition is made.

The migration steps can be tracked with tickets and worked towards in each sprint like any other task. This not only helps in gaining momentum (to actually someday achieve the migration), but gives  transparency to the business owners regarding how the team is planning  on implementing such a large change.

During planning, you have to:

-   Disentangle dependencies within the monolith.
-   Identify the microservices needed.
-   Design data models for the microservices.
-   Develop a method to migrate and sync data between monolith and microservices databases.
-   Design APIs and plan for backward compatibility.
-   Capture the baseline performance of the monolith.
-   Set up goals for the availability and performance of the new system.

Let's examine a few practices that will help you successfully make the transition.

### 4.4.1 Put everything in a monorepo

As you break apart the monolith, a lot of code will be moved away from it and into new microservices. A [monorepo](https://semaphoreci.com/blog/what-is-monorepo) helps you keep track of these kinds of changes. In addition, having  everything in one place can help you recover from failures more quickly.

In all likelihood, your monolith is already contained in one  repository. So, it’s just a matter of creating new folders for the  microservices.

![A monorepo is a shared repository containing the monolith and the new microservices.](figures/monorepo.jpg){ width=90% }

### 4.4.2 Use a shared CI pipeline

During development, you’ll not only be constantly shipping out new  microservices but also re-deploying the monolith. The faster and more  painless this process is, the more rapidly you can progress. Set up [continuous integration and delivery](https://semaphoreci.com/cicd) (CI/CD) to test and deploy code automatically.

If you are using a monorepo for development, you’ll have to keep a few things in mind:

-   Keep pipelines fast by enabling [change-based execution](https://docs.semaphoreci.com/essentials/building-monorepo-projects/) or using a monorepo-aware build tool such as [Bazel](https://semaphoreci.com/blog/bazel-build-tutorial-examples) or [Pants](https://semaphoreci.com/blog/building-python-projects-with-pants). This will make your [pipeline](https://semaphoreci.com/blog/cicd-pipeline) more efficient by only running changes on the updated code.
-   Configure multiple [promotions](https://docs.semaphoreci.com/guided-tour/deploying-with-promotions/), one for each microservice and one more for the monolith. Use these promotions for continuous deployment.
- Configure [test reports](https://semaphoreci.com/product/test-reports) to quickly spot and troubleshoot failures.

### 4.4.3 Ensure you have enough testing

Refactoring is much more satisfying and effective when we are sure that the code has no regressions. [Automated tests](https://semaphoreci.com/blog/test-automation) give the confidence to continuously ship out monolith updates.

An excellent place to start is the [testing pyramid](https://semaphoreci.com/blog/testing-pyramid). You will need a good amount of [unit tests](https://semaphoreci.com/blog/unit-testing), some [integration tests](https://semaphoreci.com/blog/integration-tests), and a few [acceptance tests](https://semaphoreci.com/blog/the-benefits-of-acceptance-testing).

![The testing pyramid.](figures/pyramid1.jpg){ width=30% }

Aim to run the tests as often on your local development machine as you do in your [continuous integration pipeline](https://semaphoreci.com/blog/cicd-pipeline).

### 4.4.4 Install an API Gateway or HTTP Reverse Proxy

As microservices are deployed, you have to segregate incoming  traffic. Migrated features are provided by the new services, while the  not-yet-ready functionality is served by the monolith.

There are a couple of ways of routing requests, depending on their nature:

-   An API gateway lets you forward API calls based on conditions  such as authenticated users, cookies, feature flags, or URI patterns.
-   An HTTP reverse proxy does the same but for HTTP requests. In most cases,  the monolith implements the UI, so most traffic will go there, at least  at first.

![Use API gateways and HTTP reverse proxies to route requests to the  appropriate endpoint. You can toggle between the monolith and  microservices on a very fine-grained level.](figures/gateway-and-proxy.jpg){ width=60% }

Once the migration is complete, the gateways and proxies will remain – they are a standard component of any microservice application since  they offer forwarding and load balancing. They can also function as [circuit breakers](https://martinfowler.com/bliki/CircuitBreaker.html) if a service goes down.

### 4.4.5 Consider the monolith-in-a-box pattern

OK, this one only applies if you plan to use containers or Kubernetes for the microservices. In that case, containerization can help you  homogenize your infrastructure. The monolith-in-a-box pattern consists  of running the monolith inside a container such as Docker.

If you’ve never worked with containers before, this is a good  opportunity to get familiar with the tech. That way, you’ll be one step  closer to learning about Kubernetes down the road. It’s a lot to learn,  so plan for a steep learning curve:

1.  Learn about Docker and containers.
2.  Run your monolith in a container.
3.  Develop and run your microservices in a container.
4.  Once the migration is done and you’ve mastered containers, learn about Kubernetes.
5.  As the work progresses, you can scale up the microservices and gradually move traffic to them.

![Containerizing your monolith is a way of standardizing deployment, and it is an excellent first step in learning Kubernetes.](figures/source-to-k8s.jpg){ width=80% }

### 4.4.6 Warm up to changes

It takes time to get used to microservices, so it’s best to start  small and warm up to the new paradigm. Leave enough time for everyone to get in the proper mindset, upskill, and learn from mistakes without the pressure of a deadline.

During these first tentative steps you’ll learn a lot about  distributed computing. You’ll have to deal with cloud SLA, set up SLAs  for your own services, implement monitoring and alerts, define channels  for cross-team communication, and decide on a deployment strategy.

Pick something easy to start with, like edge services that have  little overlap with the rest of the monolith. You could, for instance,  build an authentication microservice and route login requests as a first step.

![Pick something easy to start, like a simple edge service.](figures/warm-up-1056x390.jpg){ width=100% }

### 4.4.7 Use feature flags

[Feature flags](https://semaphoreci.com/blog/feature-flags) are a software technique for changing the functionality of a system  without having to re-deploy it. You can use feature flags to turn on and off portions of the monolith as they are migrated, experiment with  alternative configurations, or run A/B testing.

An typical workflow for a feature-flag-enabled migration is:

1.  Identify a piece of the monolith’s functionality to migrate to a microservice.
2.  Wrap the functionality with a feature flag. Re-deploy the monolith.
3.  Build and deploy the microservice.
4.  Test the microservice.
5.  Once satisfied, disable the feature on the monolith by switching the feature off.
6.  Repeat until the migration is complete.

Because feature flags allow us to deploy inactive code to production  and toggle it at any time, we can decouple feature releases from actual  deployment. This gives developers an enormous degree of flexibility and  control.

### 4.4.8 Modularize the monolith

If your monolith is a tangle of code, you may very well end up with a tangle of *distributed* code once the migration is done. Like tidying up a house before a total renovation, modularizing the monolith is a necessary preparation step.

The modular monolith is a software development pattern consisting of  vertically-stacked modules which are independent and interchangeable.  The opposite of a modular monolith is the classic N-tier, or layered,  monolith.

![Layered vs. modular monolith architectures.](figures/layered-vs-modular-1056x723.jpg){ width=90% }

Layered monoliths are hard to disentangle – code tends to have too  many dependencies (sometimes circular), making changes difficult to  implement.

A modular monolith is the next best thing to microservices and a  stepping stone towards them. The rule is that modules can only  communicate over public APIs and everything is private by default. As a  result, the code is less intertwined, relationships are easy to  identify, and dependencies are clear-cut.

![This Java monolith has been split into independent modules.](figures/modular-monolith-project-tree.jpg){ width=30% }

Two patterns can help you refactor a monolith: the Strangler Fig and the Anticorruption Layer.

### 4.4.9 The strangler fig pattern

In the [Strangler Fig](https://martinfowler.com/bliki/StranglerFigApplication.html) pattern, we refactor the monolith from the edge to the center. We chew  at the edges, progressively rewriting isolated functionality until the  monolith is entirely redone.

Calls between modules are routed through the “strangler façade,”  which emulates and interprets the legacy code’s inputs and outputs. Bit  by bit, modules are created and slowly replace the old monolith.

![The monolith is modularized one piece at a time. Eventually, the old monolith is gone and is replaced by a new one.](figures/strangler-pattern.jpg){ width=90% }

### 4.4.10 The anticorruption layer pattern

You will find that, in some cases, changes in one module propagate  into others as you refactor the monolith. To combat this, you can create a translation layer between rapidly-changing modules. This  anticorruption layer prevents changes in one module from impacting the  rest.

![The anticorruption layer prevents changes from propagating by translating calls between modules and the monolith.](figures/anticorruption-layer.jpg){ width=90% }

### 4.4.11 Decouple the data

The superpower microservices give you is the ability to deploy any  microservice at any time with little or no coordination with other  microservices. This is why data coupling must be avoided at all costs,  as it creates dependencies between services. Each microservice must have a private and independent database.

It can be shocking to realize that you have to denormalize the  monolith’s shared database into (often redundant) smaller databases. But data locality is what will ultimately let microservices work  autonomously.

![Decoupling data into separate and independent databases.](figures/module-db.jpg){ width=60% }

After decoupling, you’ll have to install mechanisms to keep the old  and new data in sync while the transition is in progress. You can, for  example, set up a data-mirroring service or change the code, so  transactions are written to both sets of databases.

![Use data duplication to keep tables in sync during development.](figures/microservice-db.jpg){ width=60% }

### 4.4.12 Add observability

The new system must be faster, more performant, and more scalable than the old one. Otherwise, why bother with microservices?

You need a baseline to compare the old with the new. Before starting  the migration, ensure you have good metrics and logs available. It may  be a good idea to install some centralized logging and monitoring  service, since it’s a key component for the [observability](https://semaphoreci.com/blog/honeycomb-ceo-on-sharing-customer-pain) of any microservice application.

![Metrics are used to compare the performance.](figures/logging.jpg){ width=80% }