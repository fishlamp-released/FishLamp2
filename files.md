---
layout: default
title: FishLamp Topology
---


##Classes Folder

Here's how the framework source code is arranged. All of the code is in the Classes folder at the root of the repository.

###Core

This is the required code all the framework needs.

###Cocoa

This is the code that works on iOS and OS X. All the core abstractions and implementations for stuff without any UI - like the async, persistence, and model object, abstractions.

###CocoaUI

Abstractions and implementations for UI related stuff that is either not specific to iOS or OS X, or abstracts something that has a concrete implementation in either the iOS or OSX frameworks.

###Connect

Individual libraries for individual webservices, like Twitter and Facebook

###External and Dependecies

Code brought in from elsewhere. These need to be combined into one. 

###OSX

Code only for running on OS X. Most UI, some other stuff like a NSTask abstraction.

###iOS 

Code only for running on iOS.

###XCodePlugin

An experiment for abstracting a easy interface for making Xcode plugins. 

###Animation

An experiment for add cocos2d support to view controllers for use in apps not totally built using cocos2d.

