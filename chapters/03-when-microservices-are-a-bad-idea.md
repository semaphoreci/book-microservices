## 1.4 The caveats of microservice design

At first glance microservices sound wonderful. They are modular, scalable,  and fault tolerant. A lot of companies have had great success using this model, so microservices might naturally seem to be the superior  architecture and the best way to start new applications.

However, most firms that have succeeded with microservices did not  begin with them. Consider the examples of Airbnb and Twitter, which went the microservice route after outgrowing their monoliths and are now [battling its complexities](https://thenewstack.io/how-airbnb-and-twitter-cut-back-on-microservice-complexities). Even successful companies that use microservices appear to still be  figuring out the best way to make them work. It is evident that  microservices come with their share of tradeoffs.

## 1.5 Microservice design challenges

Migrating from a monolith to microservices is also not a simple task, and creating an untested product as a new microservice is even more complicated. Microservices should only be seriously considered after evaluating the alternative paths. So, before embarking on a costly transition to microservices, we should talk about their shortcomings and limitations:

-   **Small**: applies both to the team size and the codebase. A microservice must be small enough to be entirely understood by one person. As a rule of thumb, a microservice is too big if it would take it more than one sprint to rewrite it from scratch.
-   **Focused on one thing**: a microservice must focus on one aspect of the problem or perform only one task.
-   **Autonomous**: each microservice has its own  database or persistence layer that is not shared with other services.
-   **Aligned with the bounded context**: in software, we create models to represent the problem we want to  solve. A bounded context represents the limits of a given model.  Contexts are natural boundaries for services, so finding them is the most difficult and crucial part of designing a good microservice architecture.
-   **Loosely-coupled**: while microservices can depend on other microservices, we must be  careful about how they communicate. Each time a bounded context is  crossed, some level of abstraction and translation is needed to prevent  behavior changes in one service from affecting too much the rest.
-   **Independently deployable**: being autonomous and loosely-coupled, a team can deploy their  microservice with little external coordination or integration testing.  Microservices should communicate over well-defined APIs and use  translation layers to prevent behavior changes in one service from  affecting the others.

![The key properties of microservice architecture](figures/micro-properties-1.jpg){ width=90% }

## 1.6 Reasons not to migrate to microservices

The caveats and strict limitations make microservices a bad fit for some types of workloads and applications. Let's see some common cases where microservices architecture is not recommended.

### 1.6.1 Microservices are only viable for mature products

On the topic of starting a new project with microservices, [Martin Fowler observed that](https://martinfowler.com/bliki/MonolithFirst.html):

>   1.   Almost all the successful microservice stories started with a monolith that got too big and was broken up.
>
>   2.   Almost all the cases where a system that was built as a microservice system from scratch, ended up in serious trouble.
>
>   This pattern has led many to argue that you shouldn’t start a new project  with microservices, even if you’re sure your application will be big  enough to make it worthwhile.

The crux of the matter is that the first design is rarely optimal. The first few iterations  of any new product are spent finding what users really need. Therefore,  success hinges on staying agile and being able to quickly improve,  redesign, and refactor. In this regard, microservices are manifestly  worse than a monolith. If you don’t nail the initial design, you’re in  for a rough start, as it’s much harder to refactor a microservice than a monolith.

### 1.6.2 Microservices are not a good fit for startups

As a startup, you already are running  against the clock, looking for a breakthrough before running out of capital. You don’t need the scalability at this point (and probably not for a few years yet), so why make things harder by using a complicated architecture model?

A similar argument can be made when working on greenfield projects,  which are unconstrained by earlier work and hence have nothing upon  which to base decisions. Sam Newman, author of [*Building Microservices*](https://semaphoreci.com/blog/books-every-senior-engineer-should-read#building-microservices-designing-fine-grained-systems-by-sam-newman)*: Designing Fine-Grained Systems*, stated that it is very difficult to [build a greenfield project with microservices](https://samnewman.io/blog/2015/04/07/microservices-for-greenfield/):

>   I remain convinced that it is much easier to partition an existing “brownfield” system than to do so  upfront with a new, greenfield system. You have more to work with. You  have code you can examine, you can speak to people who use and maintain  the system. You also know what ‘good’ looks like – you have a working  system to change, making it easier for you to know when you may have got something wrong or been too aggressive in your decision-making process.

### 1.6.3 Microservices aren’t the best for On-Premise installations

Microservice deployment needs robust automation because of all the moving parts involved. Under normal circumstances, we can rely on [continuous deployment pipelines](https://semaphoreci.com/blog/cicd-pipeline) for the job.

This won’t fly for on-premise environments, where developers publish a package and it’s up to the customer to manually deploy and configure  everything on their own. Microservices make all these tasks especially challenging, so this is a release model that  does not fit nicely with microservice architecture.

To be clear, developing an On-Premise microservice application is entirely viable. Semaphore is accomplishing just that with [Semaphore On-Premise](https://semaphoreci.com/enterprise/on-premise). However, as we realized along the way, there are several challenges to overcome. Consider the following before deciding to adopt microservices design for On-Premise installations:

-   Versioning rules for On-Premise microservices are more stringent. You must carefully track each individual microservice that participates in a release.
-   You must carry out thorough integration and end-to-end testing, as you can’t test in production.
-   Troubleshooting a microservice application is substantially more difficult without direct access to the production environment.

### 1.6.4 If it’s working, don’t fix it

If we measure productivity as the number of value-adding features  implemented over time, then it follows that switching architecture while productivity is strong makes little sense.

Teams working on monoliths tend to be more productive initially. Only after the monolith grows in complexity, microservices appear as a viable alternative. So, it's best to stick with monoliths until the point where productivity decreases.

![Microservices are initially the less productive architecture due to maintenance  overhead. As the monolith grows, it gets more complex, and it’s harder  to add new features. Microservice only pays off after the lines cross.](figures/productivity.jpg){ width=90% }

### 1.6.5 Brooke’s Law and developer productivity

In [*The Mythical Man Month*](https://semaphoreci.com/blog/books-every-senior-engineer-should-read#month) (1975), Fred Brook Jr. stated that “adding manpower to a late software project only makes things worse”. This happens because new developers must be  mentored before they can work on a complex codebase. Also, as the team  grows, the communication overhead increases. It’s harder to get  organized and make decisions.

![Brook’s law applied to complex software development states that adding more  developers to a late software project only makes it take longer.](figures/brooke.jpg){ width=80% }

Microservices are one method of reducing the impact of Brooke’s Law. You get smaller, more agile and communicative teams. Before deciding on using microservices, however, you must determine if  Brooke’s Law is affecting your team. Switching to microservices too  soon would not be a wise investment.

### 1.6.6 You may not be prepared for the transition

Some conditions must be met before you can begin working with microservices. Along with preparing your monolith, you’ll need to:

-   Set up [continuous integration and continuous delivery](https://semaphoreci.com/cicd) for automatic deployment.
-   Implement quick provisioning to build infrastructure on demand.
-   Learn about cloud-native tech stacks, including containers, Kubernetes, and serverless.
-   Get acquainted with Domain-Driven Design, [Test-Driven Development](https://semaphoreci.com/blog/test-driven-development), and [Behavior-Driven Development](https://semaphoreci.com/community/tutorials/behavior-driven-development).
-   Reorganize the teams to be [cross-functional](https://kanbanize.com/blog/cross-functional-teams/), removing silos and flattening hierarchies to allow for innovation.
-   Foster a DevOps culture in which the lines between developer and operations jobs are blurred.

Changing the culture of an organization can take years. Learning all that there is to know will take months. Without preparation,  transitioning to microservices is unlikely to succeed. 

We'll talk more about restructuring organizations in the next chapter.

## 1.7 Is it the right time for the switch?

Microservices are the most scalable way we have to develop software, no doubt about that.  But they are not free lunches. They come with some risks that are easy  to run afoul of if you’re not cautious. They are great when the team is  growing and you need to stay fast and agile. But you need to have a good understanding of the problem to solve, or you can end up with a  distributed monolith.

We can summarize this whole discussion about transitioning to  microservices in one sentence: don’t do it unless you have a good  reason. Companies that embark on the journey to microservices unprepared and without a solid design will have a very tough time. You need  to achieve a critical mass of engineering culture and scaling know-how  before microservices should be considered as an option.

## 1.8 Revitalizing monoliths

You've downloaded this book because you're interested in microservices. Presumably, because you are not satisfied with your monolith. As an alternative to microservices, let's discuss a few ways in which you can revitalize your monolith and squeeze a few more good years out of it.

There are two moments in the lifetime of a project in which microservices might seem the only way forward:

- **Tangled codebase**: it’s hard to make changes and add features without breaking other functionality.
- **Performance**: you’re having trouble scaling the monolith.

There are ways to address both problems.

## 1.9 The modular monolith as an alternative to microservices

A common reason developers want to avoid monoliths is their  proclivity to deteriorate into a tangle of code (the "big ball of mud"). It’s challenging to add new features when we get to this point since everything is interconnected.

But a monolith does not have to be a mess. Take the example of  Shopify: with over 3 million lines of code, theirs is one of the largest Rails monoliths in the world. At one point, the system grew so large it [caused much grief to developers](https://shopify.engineering/deconstructing-monolith-designing-software-maximizes-developer-productivity):

>   The application was extremely  fragile with new code having unexpected repercussions. Making a  seemingly innocuous change could trigger a cascade of unrelated test  failures. For example, if the code that calculates our shipping rate is  called into the code that calculates tax rates, then making changes to  how we calculate tax rates could affect the outcome of shipping rate  calculations, but it might not be obvious why. This was a result of high coupling and a lack of boundaries, which also resulted in tests that  were difficult to write, and very slow to run on CI.

Instead of rewriting their entire monolith as microservices, [Shopify chose modularization](https://shopify.engineering/shopify-monolith) as the solution.

![Modularization helps design better monoliths and microservices. Without carefully  defined modules, we either fall into the traditional layered monolith  (the big ball of mud) or, even worse, as a distributed monolith, which  combines the worst features of monoliths and microservices.](figures/module-vs-units.jpg){ width=85% }

Modularization is a lot of work, that’s true. But it also adds a ton  of value because it makes development more straightforward. New  developers do not have to know the whole application before they can  start making changes. They only need to be familiar with one module at a time. Modularity makes a large monolith feel small.

Modularization is a required step before transitioning to  microservices, and for some, it may be a better solution than microservices. The  modular monolith, like in microservices, solves the tangled codebase  problem by splitting the code into independent modules. Unlike with  microservices, where communication happens over a network, the modules  in the monolith communicate over internal API calls.

![Layered vs modular monoliths. Modularized monoliths share many of the  characteristics of microservice architecture sans the most difficult challenges.](figures/layered-vs-modular-1-1056x723.jpg){ width=90% }

## 1.10 Scalable monoliths

Another misconception about monoliths is that they can’t scale. If  you’re experiencing performance issues and think that microservices are  the only way out, think again. Shopify has shown us that sound  engineering can make a monolith [work on a mind-boggling scale](https://twitter.com/ShopifyEng/status/1465806691543531525).

![Shopify bragging about their Black Friday stats](figures/tweet-shopify.jpg){ width=80% }

The architecture and technology stack will determine how the monolith can be optimized; a process that almost invariably will start with  modularization and can leverage cloud technologies for scaling:

-   Deploying multiple instances of the monolith and using load balancing to distribute the traffic.
-   Distributing static assets and frontend code using CDNs.
-   Using caching to reduce the load on the database.
-   Implementing high-demand features with edge computing or serverless functions.
