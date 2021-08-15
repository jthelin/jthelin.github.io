---
name: Orleans - Virtual Actors
start_date: 2010-10-14
home: https://www.microsoft.com/en-us/research/project/orleans-virtual-actors/
---

# {{ page.name }}

Established: {{ page.start_date }}

Home page: <{{ page.home }}>

## Overview

_Project Orleans_ invented the **Virtual Actor abstraction**, which provides a straightforward approach to building distributed interactive applications, without the need to learn complex programming patterns for handling concurrency, fault tolerance, and resource management.
Orleans applications scale-up automatically and are meant to be deployed in the cloud.
It has been used heavily by a number of high-scale cloud services at Microsoft, starting with cloud services for the Halo franchise running in production in Microsoft Azure since 2011.

The core Orleans technology was transferred to [343 Industries](https://www.halowaypoint.com/)
and made available as open source in January 2015.

The main research paper that describes Orleans Virtual Actors is here: [Orleans: Distributed Virtual Actors for Programmability and Scalability](https://www.microsoft.com/en-us/research/publication/orleans-distributed-virtual-actors-for-programmability-and-scalability/)

## Virtual Actor Implementations

The open-sourced **C#** code for _Project Orleans_ is available under an MIT license on GitHub -- <https://github.com/dotnet/orleans>

Microsoft Azure has released an SDK for [Reliable Actors](http://azure.microsoft.com/en-us/documentation/articles/service-fabric-reliable-actors-get-started/), a virtual actor programming model based heavily on the Orleans API.
It runs on [Service Fabric](http://azure.microsoft.com/en-us/campaigns/service-fabric/), an Azure runtime for the rapid development and updating of microservice-based applications.

The BioWare division of Electronic Arts created _Project Orbit_ which is a **Java** implementation of virtual actors that was heavily inspired by the Orleans project.
Their code is available under a BSD license on GitHub  -- <https://github.com/electronicarts/orbit>

## Some Places to Learn More

- Orleans GitHub site: <https://github.com/dotnet/orleans>
- Orleans documentation web site: <http://dotnet.github.io/orleans>
- Various research reports, presentations and videos about Orleans are also listed on the page below.

## Orleans Slide Presentations

- [28th International Symposium on Distributed Computing (DISC 2014)](https://www.microsoft.com/en-us/research/uploads/prod/2016/02/philbe-disckeyotephilbefinal.pdf)
- [15th International Workshop on High Performance Transaction Systems (HPTS 2013)](http://www.hpts.ws/papers/2013/Bykov.pdf)

## Orleans Overview - A Framework for Cloud Computing

Building interactive services that are scalable and reliable is hard.
Interactivity imposes strict constraints on availability and latency, as that directly impacts end-user experience.
To support a large number of concurrent user sessions, high throughput is essential.

The traditional three-tier architecture with stateless front-ends, stateless middle tier and a storage layer has limited scalability due to latency and throughput limits of the storage layer, which has to be consulted for every request.
A caching layer is often added between the middle tier and storage to improve performance.
However, a cache loses most of the concurrency and semantic guarantees of the underlying storage layer.
To prevent inconsistencies caused by concurrent updates to a cached item, the application or cache manager has to implement a concurrency control protocol.
With or without a cache, a stateless middle tier does not provide data locality because it uses the _data shipping paradigm_: for every request, data is sent from storage or cache to the middle tier server that is processing the request.
The advent of social graphs where a single request may touch many entities connected dynamically with multi-hop relationships makes it even more challenging to satisfy required application-level semantics and consistency on a cache with fast response for interactive access.

The actor model offers an appealing solution to these challenges by relying on the _function shipping paradigm_.
Actors allow building a stateful middle tier that has the performance benefits of a cache with the data locality and semantic and consistency benefits of encapsulated entities via application-specific operations. In addition, actors make it easy to implement horizontal, “social”, relations between entities in the middle tier.

Another view of distributed systems programmability is through the lens of the object-oriented programming (OOP) paradigm.
While OOP is an intuitive way to model complex systems, it has been marginalized by the popular service-oriented architecture (SOA).
One can still benefit from OOP when implementing service components.
However, at the system level, developers have to think in terms of loosely-coupled partitioned services, which often do not match the application’s conceptual objects.
This has contributed to the difficulty of building distributed systems by mainstream developers.
The actor model brings OOP back to the system level with actors appearing to developers very much like the familiar model of interacting objects.

Actor platforms such as Erlang and Akka are a step forward in simplifying distributed system programming.
However, they still burden developers with many distributed system complexities because of the relatively low level of provided abstractions and system services.
The key challenges are developing application code for managing the lifecycle of actors, dealing with distributed races, handling failures and recovery of actors, placing actors, and thus managing distributed resources.
To build a correct solution to such problems in the application, the developer must be a distributed systems expert.

To avoid these complexities, we built the Orleans programming model and runtime, which raises the level of the actor abstraction.
Orleans targets developers who are not distributed system experts, although our expert customers have found it attractive too.
It is actor-based, but differs from existing actor-based platforms by treating actors as virtual entities, not as physical ones. First, an Orleans actor always exists, virtually.
It cannot be explicitly created or destroyed. Its existence transcends the lifetime of any of its in-memory instantiations, and thus transcends the lifetime of any particular server.
Second, Orleans actors are automatically instantiated: if there is no in-memory instance of an actor, a message sent to the actor causes a new instance to be created on an available server.
An unused actor instance is automatically reclaimed as part of runtime resource management.
An actor never fails: if a server crashes, the next message sent to an actor that was running on the failed server causes Orleans to automatically re-instantiate the actor on another server, eliminating the need for applications to supervise and explicitly re-create failed actors.
Third, the location of the actor instance is transparent to the application code, which greatly simplifies programming.
And fourth, Orleans can automatically create multiple instances of the same stateless actor, seamlessly scaling out hot actors.

Overall, Orleans gives developers a virtual “actor space” that, analogous to virtual memory, allows them to invoke any actor in the system, whether or not it is present in memory.
Virtualization relies on indirection that maps from virtual actors to their physical instantiations that are currently running.
This level of indirection provides the runtime with the opportunity to solve many hard distributed systems problems that must otherwise be addressed by the developer, such as actor placement and load balancing, deactivation of unused actors, and actor recovery after server failures, which are notoriously difficult for them to get right.
Thus, the virtual actor approach significantly simplifies the programming model while allowing the runtime to balance load and recover from failures transparently.

The runtime supports indirection via a distributed directory that maps from actor identity to its current physical location. Orleans minimizes the runtime cost of indirection by using local caches of that map.
This strategy has proven to be very efficient. We typically see cache hit rates of well over 90% in our production services.

Orleans has been used to build multiple production services currently running on the Microsoft Windows Azure cloud, including the back-end services for some popular games.
This enabled us to validate the scalability and reliability of production applications written using Orleans, and adjust its model and implementation based on this feedback.
It also enabled us to verify, at least anecdotally, that the Orleans programming model leads to significantly increased programmer productivity.

![Orleans overview diagram](images/orleans-square-summary.jpg)

## People

### Microsoft Research Team Members

- [Phil Bernstein](https://www.microsoft.com/en-us/research/people/philbe/)
- Sergey Bykov
- [Sebastian Burckhardt](https://www.microsoft.com/en-us/research/people/sburckha/)
- [Alan Geller](https://www.microsoft.com/en-us/research/people/ageller/)
- Gabi Kliot
- Jim Larus
- [Ravi Pandya](https://www.microsoft.com/en-us/research/people/ravip/)
- Michael Lowell Roberts
- [Jorgen Thelin](https://www.microsoft.com/en-us/research/people/jthelin/)
- CJ Williams

### Interns

- 2016: Tim Coppieters, Mohammad Dashti, Tim Kiefer
- 2015: Natacha Crooks, [Alok Kumbhare](https://www.microsoft.com/en-us/research/people/alok-kumbhare/), Vivek Shah, Adriana Szekeres
- 2014: Jose Faleiro, Shrainik Jain, Andrew Newell, Gerd Zellweger
- 2013: Soramichi Akiyama, Manjula Peiris, Muntasir Raihan Rahman
- 2012: Aaron Elmore, Alex Kogan, Orr Tamir
- 2011: Jeffrey Jestes
- 2010: Fabbiano Lucchese
- 2009: Andrew Gu

## Publications

[Orleans: A Framework for Cloud Computing](https://www.microsoft.com/en-us/research/publication/orleans-a-framework-for-cloud-computing/)
Sergey Bykov, Alan Geller, Gabriel Kliot, Jim Larus, Ravi Pandya, Jorgen Thelin
MSR-TR-2010-159 | November 2010
Superseded by SOCC '12 publication. Please read and cite that publication.
[Publication](https://www.microsoft.com/en-us/research/wp-content/uploads/2010/11/pldi-11-submission-public.pdf) | [Video](https://www.microsoft.com/en-us/research/video/orleans-a-framework-for-scalable-clientcloud-computing/)

[Orleans: Cloud Computing for Everyone](https://www.microsoft.com/en-us/research/publication/orleans-cloud-computing-for-everyone/)
Sergey Bykov, Alan Geller, Gabriel Kliot, Jim Larus, Ravi Pandya, Jorgen Thelin
ACM Symposium on Cloud Computing (SOCC 2011) | October 2011
Published by ACM
[View Publication](https://www.microsoft.com/en-us/research/wp-content/uploads/2011/10/socc125-print.pdf)

[Orleans: Distributed Virtual Actors for Programmability and Scalability](https://www.microsoft.com/en-us/research/publication/orleans-distributed-virtual-actors-for-programmability-and-scalability/)
Phil Bernstein, Sergey Bykov, Alan Geller, Gabriel Kliot, Jorgen Thelin
MSR-TR-2014-41 | March 2014
[View Publication](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/Orleans-MSR-TR-2014-41.pdf)

[Orleans Best Practices](https://www.microsoft.com/en-us/research/publication/orleans-best-practices/)
Sergey Bykov, Gabriel Kliot, Jorgen Thelin, Justine Stephenson
May 2014
[View Publication](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/Orleans20Best20Practices.pdf)

[PAD: Performance Anomaly Detection in Multi-Server Distributed Systems](https://www.microsoft.com/en-us/research/publication/pad-performance-anomaly-detection-in-multi-server-distributed-systems/)
Manjula Peiris, James H. Hill, Jorgen Thelin, Sergey Bykov, Gabriel Kliot, Arnd Christian König
7th IEEE International Conference on Cloud Computing (IEEE Cloud 2014) | June 2014
Published by IEEE – Institute of Electrical and Electronics Engineers
Ref: CLOUD2014-2097
[View Publication](https://www.microsoft.com/en-us/research/uploads/prod/2014/06/PAD-Performance-Anomaly-Detection-in-Multi-Server-Distributed-Systems.pdf) | [View Publication](https://ieeexplore.ieee.org/document/6973813/) | [View Publication](https://dx.doi.org/10.1109/CLOUD.2014.107)

[Optimizing Distributed Actor Systems for Dynamic Interactive Services](https://www.microsoft.com/en-us/research/publication/optimizing-distributed-actor-systems-for-dynamic-interactive-services/)
Andrew Newell, Gabriel Kliot, Ishai Menache, Aditya Gopalan, Soramichi Akiyama, Mark Silberstein
EuroSys 2016 | April 2016
Published by ACM - Association for Computing Machinery
[View Publication](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/06/eurosys16loca_camera_ready-1.pdf)

[Indexing in an Actor-Oriented Database](https://www.microsoft.com/en-us/research/publication/indexing-in-an-actor-oriented-database/)
Phil Bernstein, Mohammad Dashti, Tim Kiefer, David Maier
Conference on Innovative Database Research (CIDR) | January 2017
[View Publication](http://cidrdb.org/cidr2017/papers/p29-bernstein-cidr17.pdf)

[Geo-Distribution of Actor-Based Services (Preliminary TechReport)](https://www.microsoft.com/en-us/research/publication/geo-distribution-actor-based-services/)
Phil Bernstein, Sebastian Burckhardt, Sergey Bykov, Natacha Crooks, Jose Faleiro, Gabriel Kliot, Alok Kumbhare, Muntasir Raihan Rahman, Vivek Shah, Adriana Szekeres, Jorgen Thelin
MSR-TR-2017-3 | January 2017
[View Publication](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/01/Geo-Orleans-TR-012717.pdf)

[Geo-Distribution of Actor-Based Services](https://www.microsoft.com/en-us/research/publication/geo-distribution-of-actor-based-services/)
Phil Bernstein, Sebastian Burckhardt, Sergey Bykov, Natacha Crooks, Jose M. Faleiro, Gabriel Kliot, Alok Kumbhare, Muntasir Raihan Rahman, Vivek Shah, Adriana Szekeres, Jorgen Thelin
Proc. ACM Program. Lang. | October 2017
Published by ACM
[View Publication](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/10/Geo-Orleans-OOPSLA17.pdf) | [View Publication](https://dx.doi.org/10.1145/3133931)

[Actor-Oriented Database Systems](https://www.microsoft.com/en-us/research/publication/actor-oriented-database-systems/)
Phil Bernstein
Proceedings of the 2018 IEEE 34th International Conference on Data Engineering | April 2018
Published by IEEE Computer Society
[View Publication](https://www.microsoft.com/en-us/research/uploads/prod/2018/04/ICDE2018keynote.pdf) | [View Publication](https://icde2018.org/index.php/program/keynote-talks/#keynote-5)

[Reactive Caching for Composed Services](https://www.microsoft.com/en-us/research/publication/reactive-caching-for-composed-services/)
Sebastian Burckhardt, Tim Coppieters
OOPSLA | November 2018
Published by ACM | Organized by Microsoft Research
[View Publication](https://www.microsoft.com/en-us/research/uploads/prod/2018/10/Burckhardt-Coppieters-OOPSLA2018-with-appendices.pdf) | [Related File](https://www.microsoft.com/en-us/research/uploads/prod/2018/10/Burckhardt-Coppieters-OOPSLA2018-with-appendices.pdf)

## Related Projects

- [Horton - Querying Large Distributed Graphs](https://www.microsoft.com/en-us/research/project/horton-querying-large-distributed-graphs/)
