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
Your component is immediate if it is annotated with `@Component` and does not implement/extend anything or if you declared your service/component to be immediate explicitly by adding `immediate=true` to your `@Component` annotation, like this: `@Component(immediate=true)`. Any other `@cComponent` annotated class will be considered delayed. But what does that mean for you?

In the example shown in this repository we decided to write our hello world class like this:

```java
@Component
public class HelloOSGi {
  @Activate
  void activate () {
    System.out.println("Hello OSGi!");
  }
}
```

This is obviously an implicit immediate service/component as it does not implement or extend anything and is annotated with @Component. An immediate service/component is started as soon as the bundle it belongs to is activated and all references it declares (in this case none) are satisfied. When all those preconditions are met, then the component/service is started, i.e., its `@Activate` method is called. If our class would have implemented any interface or explicitly stated to be not immediate then your service/component would not have been started, i.e., the `@Activate` annotated method would not have been called. 

The simple answer to your question is therefore: Use `@Activate`. But life is never easy, so that's not the whole picture.
As you might have guessed already, there's more than just an `@Acitvate`, as the lifecycles also have more states than just ACTIVE ;)

Services/Components in OSGi have a full lifecycle, that means they can start, they can stop and also be updated without stopping and starting again. Therefore, corresponding annotations exist to support such a lifecycle, i.e., `@Activate`, `@Deactivate` and `@Modified`.
Just write some additional methods (that have `void` as return type) and annotate those with these annotations to fully participate in the lifecycle of a service/component. However to see this behavior in action, we need to learn some additional things that are not covered by this example/explanation. (Just watch my repositories for an advanced ds example/explanation or go to [the official OSGi specifications](https://osgi.org/specification/osgi.core/7.0.0/) (rather tough stuff) or read all of [Dirk Fauth's great tutorials](http://blog.vogella.com/author/fipro/)).

What about delayed services/components you might ask? A clever bunch you are ;)
Delayed services/components look like this:

```java
@Component
public class MyImpl implements MyInterface {
  @Activate
  void activate() {
    System.out.println("Hello delayed OSGi");
  }
}
```
This one is implicitly delayed, as it provides a service, i.e., an interface it implements. Another possiblity would have been to declare the former service/component to explicitly be delayed by setting its immediate property to false, like this `@Component(immediate=false)`. If you do this in the example application of this repository then you will not see any output printed on the console.
Why? Because OSGi does not start this component, therefore never calls its `@Activate` annotated method. 
Why? Because it is not referenced from any other immediate service/component.
Service/Components that implement an interface are considered as Services by OSGi. Services offer some fonctionality encapsulated through an interface/abstract class that is needed by other services/components. As long as there is no other (immediate) service/component that references our service/component then OSGi does not start it, i.e., delays it until it is actually needed.

How do you declare such a dependency you might ask. Nothing easier than that:
```java
@Component 
public class MyImmediateComponent {

  @Reference
  MyInterface impl;
  
  @Activate
  void activate() {
    System.out.println("Hello Reference!");
  }
```

This way both  services/components would start. You always reference the service of a component (What that means is explained below).


### Components vs. Services
As attentive reader you may have noticed my strange use of service/component. This is because in literature/tutorial/posts those are often used synonymously, although strictly speaking they are different concepts in OSGi.

A component is anything that has a `@Component` annotation annotated. A service on the other hand is usually the interface/class that this component implements/extends (implicit) or any class that is stated to be the service under which a component is registered by explicitly defining it (explicit).
```java
// service = Servlet.class implicitly
@Component
public class MyServlet implements Servlet {...}

// service = Servlet.class explicitly
@Component(service=Servlet.class)
public class MyServlet extends HttpServlet {...}
```

It sometimes gets a little bit complicated when you do not use annotations to create components, but register your service programmatically (yes that's possible too, see below). 

```java
@Component
public class FancyComp {
  @Activate
  void activate(BundleContext context) {
    context.registerService(Servlet.class, new MyServlet, null);
  }
}
```

Now you didn't use an annotation (and well the thing you registerd is also not really a component, but can be found by real components through @Reference) but a service. I'm not really sure how you call that and therefore my confusion about service/components, but for the sake of simplicity I will just call those things "components" too and only the interface/class they are registered under "services".

(IF ANYBODY KNOWS MORE ABOUT THIS ISSUE PLEASE OPEN AN ISSUE/PR ;) )


## Behind the curtain

Now that we know (at least mostly) what components are (classes you don't instantiate yourself, that have a lifecycle and you can wire them together via references) and how services play into this (sort of interface every component is registered under) we will now have a look at what is happening behind the curtains to make this work. Classes don't just instantiate themselves just because you put a fancy annotation on them, don't they? 

Well no. The don't. There are several components involved to get your component to work:

### bnd 
(or any other build tool that can translate your DS annotations)

You've put this fancy `@Component` annotation on your class. This by itself does nothing, but in combination with a build tool that understands those annotations (e.g., bnd) this will produce some cool XML. XML? Yes! This is where the **old** part comes into play I mentioned at the beginning. You remember? Old means in the background we are still using XML, although it's not a super hip technology as YAML, TOML or (beware) JSON (No JSON is not a good format for writing human readable configurations! Sorry I'm digressing. Back to the produced XML.)

The  XML produced by bnd describes your component in a format that is machine (and also a little bit human) readable. For example the above mentioned class `MyImmediateComponent` that has a reference on `MyInterface` would produce an XML file similar to this:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<scr:component xmlns:scr="http://www.osgi.org/xmlns/scr/v1.3.0" name="io.jatoms.osgi.ds.MyImmediateComponent" activate="activate">
  <reference name="impl" interface="io.jatoms.osgi.ds.MyInterface" field="impl"/>
</scr:component>
```

This XML file then is stored as additional meta data in your bundle in a predefined place, i.e., "bundle/OSG-INF/your.xml". 
What bnd also does (when it finds at least one class annotated with `@Component`) is to create additional information within your MANIFEST.MF file. 

The MANIFEST.MF file is something a regular Java developer rarly touches. In non-OSGi jars this file usually conatins something like this 
```
Manifest-Version: 1.0
Built-By: root
Created-By: 1.8.0_152 (Oracle Corporation)
Build-Jdk: 1.8.0_152
```

Nothing special here. As soon as you are using tools like bnd and are developing an OSGi bundle (You remember? A jar with additional meta data?) then there's more information contained in this file, e.g., like this:

```
Manifest-Version: 1.0
Bundle-SymbolicName: io.jatoms.flow.osgi.integration
Built-By: root

Bundle-ManifestVersion: 2
Require-Capability: osgi.extender;filter:="(&(osgi.extender=osgi.component)(version>=1.4.0)(!(version>=2.0.0)))"
Service-Component: OSGI-INF/your.xml
Provide-Capability: osgi.service;objectClass:List<String>="io.jatoms.osgi.ds.MyInterface"
Bundle-Name: io.jatoms.osgi.ds
Bundle-Version: 0.0.1.201902081546
Private-Package: io.jatoms.osgi.ds

Created-By: 1.8.0_152 (Oracle Corporation)
Build-Jdk: 1.8.0_152
```
You see some stuff stays the same, e.g., Manifest-Version, but other stuff is added. The important part for us right now (in order to understand why the component is instantiated and working) is the Service-Component header (that's how these entries are called). This one is used at runtime (the time when your code actually runs in an osgi container) to detect this bundle and, more important, the components wihtin. It is used to gather the information necessary to instantiate your components and wiring them up if they have some references. This is done for example by Aache Felix' Service Component Runtime (SCR).

### Apache Felix SCR
This component is the place where OSGi magic is happening. It uses a so called Extender Pattern (widely used in the OSGi space) to detect bundles that have a Service-Component header defined.
Whenever it finds such a bundle it loads the configuration for the components defined within them, in this case this configuration is the file /OSGI-INF/your.xml. It takes this configuration that states anything it needs to load the respective class (MyImmediateComponent), find its references (all fields annotated with `@Reference`), instantiate the references and the component itself via reflection, inject the references and then call the method annotated with `@Activate`.
This all (and much, much ... MUCH more) is done for you if you use the DS annotations.


## Conclusion
If you are confused right now: that's ok. OSGi is, although easier than a decade ago, not the easiest technoloy on earth. This is largely due to the goals it pursues: truly modular applications that are runtime reconfigurable. Not an easy goal to achieve.
I just can recommend you not to give up too early on OSGi. It takes quite some time until the paradigm shift in thinking abaout how to design appliactions settles in your mind, but when it does you're just asking yourself why the hell you didn't use OSGi all the time before ;)

This example/explanation is hopefully just the first in a row, so watch my repositories for others (usually they start with io.jatoms.osgi.<topic>).
