# OSGi Declarative Services Starter

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
TODO




