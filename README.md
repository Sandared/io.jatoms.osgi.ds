# OSGi Declarative Services

This repository is just a showcase on how simple it is to get your first OSGi component working within 5 minutes... depending on how fast Maven is able to download the internet ;)

![Gitpod in Action](https://github.com/Sandared/io.jatoms.osgi.ds/blob/master/Gitpod.PNG)

## Get started
* [![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io#https://github.com/Sandared/io.jatoms.osgi.ds)
* Wait for Maven to download the internet
* See the OSGi component in action, greeting you the most awesome way ever: The declarative service way ;)

## Things to do
* Play around with the code
* Debug the component via `debug app/target/app.jar` (More information on [how to debug in GitPod](https://github.com/Sandared/io.jatoms.osgi.base/blob/master/README.md#how-to-debug-an-application-without-a-main-method))

## Contribute
* Any suggestions/comments/additional awesomeness? open an Issue :)
* Anything else? Write me on [Twitter](https://twitter.com/SanfteSchorle)

## How to reproduce
1) [![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io#https://github.com/Sandared/io.jatoms.osgi.base)
1) Within the terminal at the bottom type `project` and fill out *groupId* and *artifactId* as you wish
1) Within your newly created project go into the `impl` submodule and there go into the class `ComponentImpl`
1) Add a method `void activate()` and annotate it with `@Activate` (there is a known bug that breaks autocompletion for annotations, but just type it anyway and then use the quickfix to import the annotation)
1) Within your newly created method add a superfancy `System.out.println("Hello World!")` statement 
1) Back in the terminal we switch to the project root directory by `cd <your project name>` and type `resolve app` 
1) After maven has finished downloading the internet you can finally start your app by typing `run app/target/app.jar`
1) Now you can see how your first component prints your awesome greetings to the world ;)

## What's going on behind the curtains?
This section is for those who want to understand what is going on in the background so that this example works.
First things first: OSGi is a very mature framework. The upside of this is you get a battle-tested framework. The downside is you often have stuff that's more complicated than it would have been in a greenfield solution due to backwards compatibility.
This is also somehow true when it comes to Declarative Services (DS). 

### What are services/components?
(Annotation driven) DSs are the newest and in my opinion the best way to develop OSGi applications. In older days you would have instead used constructs like BundleActivators, ServiceListeners, Service- and BundleTrackers and stuff like that (Google them if you want to know more about them, but only use them if you really, really have to... In most cases you don't ;) ). After those there was the hype around XML-configured dependency injection, which can be seen in the way how DSs are described, i.e., in XML. Since nowadays nobody would use XML anymore to describe services and their dependencies, annotations were introduced to simplify the work with DSs. These annotations, i.e., @Component/@Activate and so on, are the ones we used in this example.

But what are services and components conceptually?
Well, for this we first need to have a look at how an OSGi application differs from a normal Java application:

![OSGi vs Java](https://github.com/Sandared/io.jatoms.osgi.ds/blob/master/img-osgi-vs-java.png)

In a normal Java application you somewhere have your `main` method that is called by the JVM to start your program. From there on you can do what you want as a programmer and have no restrictions whatsoever. This ca be good if you are an experienced programmer and have a clean architecture in mind for your yet to program application, but this also can lead to so called spaghetti code, where each addition means tremendous changes for the existing code.

OSGi in contrast has no `main` method for you. The `main` method is buried deep inside the framework portion of OSGi that can be seen in the picture above. Instead OSGi offers you concepts like bundles and services/components, where bundles can have multiple services. A bundle in java is just a jar with more Metadata than a usual jar and a service/component is just a usual Java class with a `@Component` annotation (and maybe an interface it implements/class it extends).
So how, do you ask yourself, do I know if and when my class is instantiated and how can I participate in the application's workflow if there is no `main` method?
Good question! A clever Padawan you are!

To still your thirst for wisdom let's have a look at a rare picture of the mythical service lifecycle:

![Service lifecycle](https://github.com/Sandared/io.jatoms.osgi.ds/blob/master/img-osgi-service-lifecycles.png)

OSGi offers you two lifecycles to choose from, an immediate (left) and a delayed (right) one. 
Your component is immediate if it is annotated with `@Component` and does not implement/extend anything ooor you declared your service/component to be immediate explicitly by adding `immediate=true` to your `@Component` annotation, like this: `@Component(immediate=true)`


### Components vs. Services in OSGi

But what do they do in the background?
There are several components involved to get your component to work:

### bnd 
(or any other build tool that can translate your DS annotations)




