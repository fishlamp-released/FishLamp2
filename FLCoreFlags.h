//
//	FLCoreFlags.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Availability.h>

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

/// this sets the IOS or the MAC define

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_2_0
	#define IOS 1
    #undef MAC
    
#else
	#undef IOS
    #define MAC 1
#endif

#if DEBUG
    #define FL_SHIP_ONLY_INLINE 
#else
    #define FL_SHIP_ONLY_INLINE NS_INLINE
#endif

#ifndef DEBUG
#define RELEASE 1
#endif

#ifndef TEST
#define TEST DEBUG
#endif

// HOW to turn off warnings per file in GCC
// http://gcc.gnu.org/onlinedocs/gcc/Diagnostic-Pragmas.html

// GCC Warning in case they need to be turned off per file
// http://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

#define DeviceIsPad()   NO
#define DeviceIsPhone() NO
#define DeviceIsPod()   NO
#define DeviceIsSimulator() NO
