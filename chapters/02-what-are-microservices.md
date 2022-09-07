\newpage

# Chapter 1 — What Are Microservices?

Beloved by tech giants like Netflix and Amazon, microservices have  become the darlings in modern software development. But, despite the benefits, this is a paradigm that is easy to get wrong. So, let’s explore what microservices are and, more importantly, what they are not.

## 1.1 What is microservice architecture?

The microservice architecture is a software design approach that decomposes an application into small independent services. These services communicate over well-defined APIs, which means that services can be developed and maintained by autonomous teams, making it the most scalable method for software development.

## 1.2 Microservice vs. monolith architectures

Microservice design is the polar opposite of monolith development. A  monolith is one big codebase (“the kitchen sink”) that implements all  functionalities. Everything is in one place, and no single component can work in isolation.

On the plus side, monoliths are easy to get up and running. Airbnb, to give an example, started with The Monorail, a Ruby on Rails application. While the company was still small, developers could iterate fast. Making broad changes was easy as the relationships  between the different parts of the monolith were transparent.

As a company grows and teams increase in size, however, monolith  development becomes troublesome. Soon, the system can no longer fit  in a single head — there are just too many moving parts, so things slow  down.

![Monolith vs microservice architecture](figures/micro-vs-monolith-1056x599.jpg){ width=90% }

## 1.3 Benefits of microservices

Microservices allow companies to keep teams small and agile. The idea is to decompose the application into small services that can be  autonomously developed and deployed by tightly-knitted teams.

### 1.3.1 Scalability

The main reason that companies adopt microservices is **scalability**. Services can be developed and released independently without arranging  large-scale coordination efforts within the organization.

### 1.3.2 Fault isolation

A benefit of having a distributed system is the ability to avoid  single failure points. You can deploy microservices in different  availability zones with cloud-enabled technologies, ensuring that your  users never experience an outage.

### 1.3.3 Smaller teams

With microservices, the development team can stay small and cohesive. The smaller the group, the less communication overhead and the better  the collaboration.

Amazon, as an example, takes team size to the extreme with their [two pizza teams](https://docs.aws.amazon.com/whitepapers/latest/introduction-devops-aws/two-pizza-teams.html). Meaning that a team should be small enough to be fed by two pizzas.

### 1.3.4 The freedom to choose the tech stack

With a monolith, language and tech stack options are pretty much set in stone from the beginning. New developers must adapt to whatever choices were  made in the past.

In contrast, each microservice can use the tech stack that is most  appropriate for solving the task at hand. Thus, the team can pick the  best tool for the job and based on their skills. For example, you can implement a high-performing service in Go or C and a high-tolerance microservice with Elixir.

### 1.3.5 More frequent releases

The development and testing cycle is shorter as small teams iterate quick. And, because they can also deploy their updates at any time,  microservices can be updated much more frequently than a monolith.
