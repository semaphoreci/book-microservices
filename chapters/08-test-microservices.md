
## 4.5 Techniques for testing microservices

How do we test a microservice application? How do we test when third party services are involved and  network disruptions are a possibility? The microservice architecture is a paradigm shift so profound that we must reconsider conventional testing techniques. Microservices differ  from the classic monolithic structure in many ways:

-   **Distributed**: microservices are deployed across  multiple servers, potentially across geographical locations, adding  latency and exposing the application to network disruptions. Tests that  rely on the network can fail due to no fault of the code, interrupting  the [CI/CD pipelines](https://semaphoreci.com/blog/cicd-pipeline) and blocking development.
-   **Autonomous**: as long as they don’t break API compatibility, development teams are free to deploy their microservices at any time.
-   **Increased test area**: since each microservice exposes at least a few API endpoints, there are many more testable surfaces to cover.
-   **Polyglot**: development teams can choose the best language for their microservice.  In a big system, it’s unlikely that we’ll find a single test framework  that works for all components.
-   **Production is a moving target**: because microservices are independently-deployable and built by  autonomous teams, extra checks and boundaries are required to assure  they will all still function correctly together when deployed.

All these characteristics force us to think of new testing strategies.

## 4.6 The testing pyramid for microservices

The testing pyramid is a planning tool for [automated software testing](https://semaphoreci.com/blog/test-automation). In its traditional form, the pyramid uses three types of tests:

-   [Unit tests](https://semaphoreci.com/blog/unit-testing)
-   [Integration tests](https://semaphoreci.com/blog/integration-tests)
-   [End-to-end tests](https://semaphoreci.com/blog/e2e-testing).

The microservice pyramid adds two new types: **component** and **contract** tests.

![One version of the microservice testing pyramid.](figures/test-pyramid.jpg){ width=40% }

Let’s see how each pyramid layer works in further detail.

### 4.6.1 Unit tests for microservices

Unit tests are one of the most fine-grained — and numerous — forms of testing. A unit consists of a class, method, or function that can be  tested in isolation. Unit testing is an inseparable part of development  practices like [Test-Driven Development](https://semaphoreci.com/blog/test-driven-development) or [Behavior-Driven Development](https://semaphoreci.com/community/tutorials/behavior-driven-development).

Compared to a monolith, a unit in a microservice has a much higher  chance of requiring a network call to fulfill its function. When this  happens, we can either let the code access the external service —  accepting some latency and uncertainty — or replace the call with a [test double](https://semaphoreci.com/community/tutorials/mocking-with-rspec-doubles-and-expectations#h-doubles), giving us two ways of dealing with microservice dependencies:

-   **Solitary unit tests**: this should be used when  we need the test result to always be deterministic. We use mocking or  stubbing to isolate the code under test from external dependencies.
-   **Sociable unit tests**: sociable tests are allowed to call other services. In this mode, we  push the complexity of the test into the test or staging environment.  Sociable tests are not deterministic, but we can be more confident in  their results when they pass.

![We can run unit tests in isolation using test doubles. Alternatively, we can allow tested code to call other microservices, in which case we’re talking about sociable tests.](figures/doubles-vs-sociable-1056x419.jpg){ width=100% }

As you’ll see, balancing confidence vs. stability will be a running theme throughout the entire chapter. Mocking makes things faster and  reduces uncertainty, but the more you mock, the less you can trust the  results. Sociable tests, despite their downsides, are more realistic.  So, you’ll likely need to strike a good balance of both types.

If you want to check examples of solitary vs sociable tests, [check out this nice post from Dylan Watson at dev.to](https://dev.to/dylanwatsonsoftware/socialise-your-unit-tests-5da0).

### 4.6.2 Contract testing

A contract is formed whenever two services couple via an interface.  The contract specifies all the possible inputs and outputs with their  data structures and side effects. The consumer and producer of the  service must follow the rules stated in the contract for communication  to be possible.

Contract tests ensure that microservices adhere to their contract.  They do not thoroughly test a service’s behavior; they only ensure that  the inputs and outputs have the expected characteristics and that the  service performs within acceptable time and performance limits.

Depending on the [relationship between the services](https://semaphoreci.com/blog/domain-driven-design-microservices#relationship-types), contract tests can be run by the producer, the consumer, or both.

-   **Consumer-side contract tests** are written and  executed by the downstream team. During the test, the microservice  connects to a fake or mocked version of the producer service to check if it can consume its API.
-   **Producer-side contract tests** are run in the upstream service. This type of test emulates the various API requests clients can make, verifying that the producer matches the  contract. Producer-side tests let the developers know when they are  about to break compatibility for their consumers.

![Contract tests can run on the upstream or downstream. Producer tests check that  the service doesn’t implement changes that would break depending  services. Consumer tests run the consumer-side component against a  mocked version of the upstream producer (not the real producer service)  to verify that the consumer can make requests and consume the expected  responses from the producer. We can use tools such as Wiremock to reproduce HTTP requests.](figures/consumer-vs-producer-contracts-1056x531.jpg){ width=100% }

If both sides of the contract tests pass, the producers and consumers are compatible and should be able to communicate. Contract tests should always run in [continuous integration](https://semaphoreci.com/cicd) to detect incompatibilities before deployment.

You can play with contract testing online in the [Pact 5-minute getting started guide](https://docs.pact.io/5-minute-getting-started-guide). Pact is a HTTP-based testing tool to write and run consumer- and producer-based contract tests.

### 4.6.3 Integration tests

Integration tests on microservices work slightly differently than in  other architectures. The goal is to identify interface defects by making microservices interact. Unlike contract tests, where one side is always mocked, integration tests use real services.

Integration tests are not interested in evaluating behavior or  business logic of a service. Instead we want to make sure that the  microservices can communicate with one another and their own databases.  We’re looking for things like missing HTTP headers and mismatched  request/response pairings. And, as a result, integration tests are  typically implemented at the interface level.

![Using integration tests to check that the microservices can communicate with  other services, databases, and third party endpoints.](figures/integration-tests-1056x498.jpg){ width=100% }

Check out [Vitaly Baum’s post on stubbing microservices](https://articles.microservices.com/practical-microservices-integration-tests-and-stub-services-80749ce01050) to see integration code tests in action.

### 4.6.4 Component tests for microservices

A component is a microservice or set of microservices that accomplishes a role within the larger system.

Component testing is a type of [acceptance testing](https://semaphoreci.com/blog/the-benefits-of-acceptance-testing) in which we examine the component’s behavior in isolation by substituting services with simulated resources or mocking.

Component tests are more thorough than integration tests because they travel happy and unhappy paths — for instance, how the component  responds to simulated network outages or malformed requests. We want to  know if the component meets the needs of its consumer, much like we do  in acceptance or end-to-end testing.

![Component testing performs end-to-end testing to a group of microservices.  Services outside the scope of the component are mocked.](figures/component.jpg){ width=90% }

There are two ways of performing component testing: in-process and out-of-process.

### 4.6.5 In-process component testing

In this subclass of component testing, the test runner exists in the  same thread or process as the microservice. We start the microservice in an “offline test mode”, where all its dependencies are mocked, allowing us to run the test without the network.

![Component test running in the same process as the microservice. The test injects a mocked service in the adapter to simulate interactions with other  components.](figures/in-process.jpg){ width=90% }

In-process testing only works when the component is a single  microservice. On a first glance, component tests look very similar to  end-to-end or acceptance tests. The only difference is that component  tests pick one part of the system (the component) and isolate it from  the rest. The component is thoroughly tested to verify that it performs  the functions its users or consumers need.

![Component and end-to-end testing may look similar. But the difference is that end-to-end tests the complete system (all the microservices) in a production-like environment, whereas a component does it on an isolated  piece of the whole system. Both types of tests check the behavior of the system from the user (or consumer) perspective, following the journeys a user would perform.](figures/e2e-vs-component-2-1056x348.jpg){ width=100% }

We can write component tests with any language or framework, but the most popular ones are probably [Cucumber](https://semaphoreci.com/community/tutorials/introduction-to-writing-acceptance-tests-with-cucumber) and [Capybara](http://teamcapybara.github.io/capybara/).

### 4.6.6 Out-of-process component testing

Out-of-process tests are appropriate for components of any size,  including those made up of many microservices. In this type of testing,  the component is deployed — unaltered — in a test environment where all  external dependencies are mocked or stubbed out.

![In this type of component tests the complexity is pushed out into the test environment, which should replicate the rest of the system.](figures/out-of-process.jpg){ width=90% }

To round out the concept of contract testing you may [explore example code for contract testing on Java Spring](https://dzone.com/articles/component-tests-for-spring-cloud-microservices). Also, if you are a Java developer, [this post has code samples for testing Java microservices at every level](https://phoenixnap.com/blog/microservices-continuous-testing).

### 4.6.7 End-to-end testing in microservices

So far, we have tested the system piecemeal. Unit tests were used to  test parts of a microservice, contract tests covered API compatibility,  integration tests checked network calls, and component tests were used  to verify a subsystem’s behavior. Only at the very top of the automated  testing pyramid do we test the entire system.

End-to-end (E2E) testing ensures that the system meets users needs  and achieves their business objectives. The E2E suite should cover all  the microservices in the application using the same interfaces that  users would–often with a combination of UI and API tests.

The application should run in an environment as close as possible to  production. Ideally, the test environment would include all the  third-party services that the application usually needs, but sometimes,  these can be mocked to cut costs or prevent abuse.

![End-to-end are automated tests that simulate user interaction. Only external third-party services might be mocked.](figures/e2e.jpg){ width=90% }

As depicted by the testing pyramid, E2E tests are the least numerous, which is good because they are usually the hardest to run and maintain. As long as we focus on the user’s journeys and their needs, we can  extract a lot of value with only a few E2E tests.

## 4.7 Changing the testing paradigm

A different paradigm calls for a change in strategies. Testing in a  microservice architecture is more important than ever, but we need to  adjust our techniques to fit the new development model. The system is no longer managed by a single team. Instead, every microservice owner must do their part to ensure that the application works as a whole.

Some organizations might decide that unit, contract, and component  tests are enough. Others, not content without end-to-end and integration testing, may choose to establish a QA team to facilitate cross-team  test coverage.