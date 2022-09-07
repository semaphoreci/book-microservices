\newpage

# Chapter 3 — Design Principles for Microservices

How do you know if you’re doing proper microservice design? If your  team can deploy an update at any time without coordinating with other  teams, and if other teams can similarly deploy their changes without  affecting you, congratulations, you got the knack of microservices.

The surest way of losing the benefits microservices offer is by not  respecting the decoupling rule. If we look closely, we see that  microservices are all about autonomy. When this autonomy is lost, teams  must coordinate during development and deployment. Perfect integration  testing is required to make sure all microservices work together.

![Tight service dependencies create team dependencies and communication bottlenecks.](figures/micro-coupling-1056x559.jpg){ width=100% }

These are all problems that come with distributed computing. If  you’ve ever used a cloud service you’ll know that spreading services or  machines over many geographical locations is not the same as running  everything on the same site. A distributed system has a higher latency,  can have synchronization issues, and is a lot harder to manage and  debug. This highly-coupled service architecture is really, deep down, a *distributed monolith*, with the worst of both worlds and none of the benefits microservices should bring.

If you cannot deploy without coordinating with another team or relying on specific versions of other microservices to deploy yours, you’re only distributing your monolith.

Domain-Driven Development allows us to plan a microservice  architecture by decomposing the larger system into self-contained units, understanding the responsibilities of each, and identifying their relationships.

## 3.1 What is Domain-Driven Design?

Domain-Driven Design (DDD) is a software design method wherein  developers construct models to understand the business requirements of a domain. These models serve as the conceptual foundation for developing  software.

According to Eric Evans, author of [*Domain-Driven Design: Tackling Complexity in the Heart of Software*](https://www.amazon.com/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215), a domain is:

>   *A sphere of knowledge,  influence, or activity. The subject area to which the user applies a  program is the domain of the software.*

How well one can solve a problem is determined by one’s capacity to  understand the domain. Developers are smart, but they can’t be  specialists in all fields. They need to collaborate with domain experts  to guarantee that the code is aligned with business rules and client  needs.

![Developers and domain experts use a unified language to share knowledge, document, plan, and code.](figures/share-knowledge.jpg){ width=80% }

The two most important DDD concepts for microservice architecture are: *bounded contexts* and *context maps*.

### 3.1.1 Bounded Context (BC)

The setting in which a word appears determines its meaning. Depending on the context, “book” may refer to a written piece of work, or it may  mean “to reserve a room”. A *bounded context* (BC) is the space in which a term has a definite and unambiguous meaning.

Before DDD it was common practice to attempt to find a model that  spanned the complete domain. The problem is that the larger the domain,  the more difficult it is to find a consistent and unified model. DDD’s solution is to break down the domain into more manageable subdomains.

![The relevant properties of the “book” change from context to context.](figures/online-bookstore-domain-1.jpg){ width=90% }

In software, we need to be exact. That is why defining BCs is critical: it gives us a precise vocabulary, called *ubiquitous language*, that can be used in conversations between developers and domain  experts. The ubiquitous language is present throughout the design  process, project documentation, and code.

### 3.1.2 Context Map

The presence of a BC anticipates the need for communication channels. For instance, if we’re working in an e-commerce domain, the salesperson should check with inventory before selling a product. And once it’s  sold, it’s up to shipping to ensure delivery of the product to the  correct address. In DDD, these relationships are depicted in the form of a *context map*.

![Bounded context communication used to achieve a high-level task.](figures/context-maps-1.jpg){ width=90% }

## 3.2 Domain-Driven Design for microservices

DDD takes place in two phases:

1.  In the *strategic phase* we identify the BCs and map them out in a context map.
2.  In the *tactical phase* we model each BC according to the business rules of the subdomain.

Let’s see how each phase plays a role in microservice architecture design.

## 3.3 Strategic phase

During this phase, we invite developers, domain experts, product  owners, and business analysts to brainstorm, share knowledge and make an initial plan. With the aid of a facilitator, this can take the form of an Event Storming workshop session, where we build models and identify business requirements starting from significant events in the domain.

![An Event Storming session, domain events are used as the catalyst for sharing knowledge and identifying business requirements.](figures/eventstorming-1.jpg){ width=70% }

In strategic DDD, we take a high-level, top-to-bottom approach to  design. We begin by analyzing the domain in order to determine its  business rules. From this, we derive a list of BCs.

![Strategic Domain-Driven Design helps us identify the logical boundaries of individual microservices.](figures/strategic-ddd-process.jpg){ width=90% }

The boundaries act as natural barriers, protecting the models inside. As a result, every BC represents an opportunity to implement at least  one microservice.

![Bounded relationships](figures/bounded-contexts.jpg){ width=70% }

### 3.3.1 Types of relationships

Next, we must decide how BCs will communicate. Eric Evans lists seven types of relationships, while other authors list [six of them](https://www.oreilly.com/library/view/what-is-domain-driven/9781492057802/ch04.html). Regardless of how we count them, at least three (shared kernel,  customer/supplier, and conformist) imply tight coupling, which we do not want in a microservice design and can be ignored. That leaves us with  four types of relationships:

-   **Open Host Service** (OHS): the service provider  defines an open protocol for others to consume. This is an open-ended  relationship, as it is up to the consumers to conform to the protocol.
-   **Published Language** (PL): this relationship uses a well-known language such as XML, JSON,  GraphQL, or any other fit for the domain. This type of relationship can  be combined with OHS.
-   **Anticorruption Layer**  (ACL): this is a defensive mechanism for service consumers. The  anti-corruption layer is an abstraction and translation wrapping layer  implemented in front of a downstream service. When something changes  upstream, the consumer service only needs to update the ACL.
-   **Separate ways**: this happens when integration between two services is found, upon  further analysis, to be of little value. This is the opposite of a  relationship — it means that the BCs have no connection and do not need  to interact.

At the end of our strategic DDD analysis, we get a context map detailing the BCs and their relationships.

![ACL is implemented downstream to mitigate the impact of upstream changes.  OHS does the opposite. It’s implemented upstream to offer a stable  interface for services downstream.](figures/context-maps-with-services.jpg){ width=90% }

## 3.4 Tactical phase

Deep down, software development is a modeling exercise; we describe a real-life scenario as a model and then solve it with code. In the  previous stage, we identified BCs and mapped their relationships. In  this stage we zoom in on each context to construct a detailed model.

The models created with DDD are technology-agnostic — they do not say anything about the stack underneath. We focus, instead, on modeling the subdomain. The main building block of our models are:

-   **Entities**: entities are objects with an identity that persists over time. Entities must have a unique identifier (for  example, the account number for a customer). While entity identifiers  may be shared among context boundaries, the entities themselves don’t  need to be identical across every BC. Each context is allowed to have a  private version of a given entity.
-   **Value objects**: value objects are immutable values without identity. They represent the primitives of your model, such as dates, times, coordinates, or  currencies.
-   **Aggregates**: aggregates create  relationships between entities and value objects. They represent a group of objects that can be treated as a single unit and are always in a  consistent state. For example, customers place orders and own books, so  the entities customer, order, and book can be treated as an aggregate.  Aggregates must always be referenced by a main entity, called the *root entity*.
-   **Domain services**: these are stateless services that implement a piece of business logic  or functionality. A domain service can span multiple entities.
-   **Domain events**: essential for microservice design, domain events notify other services  when something happens. For instance, when a customer buys a book, a  payment is rejected, or that a user has logged in. Microservices can  simultaneously produce and consume events from the network.
-   **Repositories**: repositories are persistent containers for aggregates, typically taking the form of a database.
-   **Factories**: factories are responsible for creating new aggregates.

![The shipping aggregate consists of a package containing books shipped to an address.](figures/shipping-aggregate.jpg){ width=60% }

## 3.5 Domain-Driven Design is iterative

While it may appear that we must first write an exhaustive  description of the domain before we can begin working on the code, the  reality is that DDD, like all software design, is an iterative process.

On paper, bounded contexts and context maps may appear OK, but when  implemented, they may translate into services that are too big to be  rightly called microservices. Conversely, chatty microservices with  overlapping responsibilities may need to be merged into one.

As development progresses and you have a better understanding of the  domain, you’ll be able to make better judgments, enhance models, and  communicate more effectively.

## 3.6 Complementary design patterns

DDD is undoubtedly a theory-heavy design pattern. As a result, it is mostly used for designing complex systems.

Other methods such as [Test-Driven Development](https://semaphoreci.com/blog/test-driven-development) (TDD) or [Behavior-Driven Development](https://semaphoreci.com/community/tutorials/behavior-driven-development) (BDD) may be enough for smaller, simpler systems. TDD is the fastest to start with and works best when on single microservices or even on applications consisting of only a few services.

On a bigger scale, we can use BDD, which forces us to validate the  wholesale behavior with integration and acceptance tests. BDD may work  well if you work on low to medium-complexity designs.

You can also combine these three patterns, choosing the best one for each stage of development. For example:

1.  Identify microservices and their relationships with strategic DDD.
2.  Model each microservice with tactical DDD.
3.  Since each team is autonomous, they can choose to adopt BDD or TDD (or a mix  of both) for developing a microservice or a cluster of microservices.

DDD can feel daunting to learn and implement, but its value for  developing a microservice architecture is well worth the effort. If you're interested in learning more, we recommend picking up the relevant books by [Eric Evans](https://www.amazon.com/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215) and [Vaughn Vernon](https://kalele.io/books/).

