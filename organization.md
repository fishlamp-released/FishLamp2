---
layout: default
title: FishLamp Repository Topology
---

###Files at the Root:

- .fishlamp-root:   
This is an invisible file that the build scripts use to locate the framework.

- .gitmodules:   
List of submodules used by the framework, like cocos2d

- LICENSE:   
The MIT license file

- README.MD:   
Like, read me. Like. Totally.

- Version.plist:   
This is a plist that has the current version of the framework in it. This will be in sync with tagged releases of the framework in the master branch. All of the tools will be set to the same version, this way if you're working with v3.0.125, PackMule will be the same version.


###Classes

This is where all the source code lives. See the organization for this folder [here](pages/code/topology.html).

###Experimental

This is where a bunch of random stuff is. Soon to be moved into it's own repo.

###Graveyard

This is dead stuff. Also soon to be removed.

###Resources

Images and nib files. These need a better place to live. 

###Tools

Source code for the tools and scripts. See the tools section [here](/pages/tools/overview.html).

###XcodeSupport

Stuff for Xcode. Lots of scripts, config files, and projects. For more information go [here](/pages/tools/xcode.html).

###Submodules

We need to put our submodule dependencies somewhere. Instead of confusing things by putting them at the root of the repo, we'll put them here for clarity.

