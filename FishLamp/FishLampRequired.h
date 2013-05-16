//
//  FishLamp.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#import "FishLampCoreRequired.h"

// supporting < 3.0 is optional

#ifndef FISHLAMP_IPHONE_2_SDK
#define FISHLAMP_IPHONE_2_SDK 0
#endif

// if this is enabled, add this to optional compiler warning parameter:
// -O -Wno-deprecated-declarations
// there is also checkbox in project

// pass in Apple's macros like __IPHONE_3_0
extern BOOL IsAtLeaskSdkVersion(int minVersion); // this lives in GtUtilities.m

#if FISHLAMP_IPHONE_2_SDK

#if __IPHONE_3_0
	#define IsAtLeaskSdkVersion3() IsAtLeaskSdkVersion(__IPHONE_3_0)
#else
	#define IsAtLeaskSdkVersion3() NO
#endif

	#define RunOnlyOnSdkVersion3 if(IsAtLeaskSdkVersion3())
	#define DontRunOnSdkVersion3 if(!IsAtLeaskSdkVersion3()) 
	#define RunOnlyOnSdkVersion2 if(!IsAtLeaskSdkVersion3())
#else
	#define IsAtLeaskSdkVersion3() YES
	#define RunOnlyOnSdkVersion3 
	#define DontRunOnSdkVersion3 ifdef_this_out_with_!FISHLAMP_IPHONE_2_SDK
	#define RunOnlyOnSdkVersion2 DontRunOnSdkVersion3
#endif

#ifndef FISHLAMP_IPHONE_2_SDK
#ifndef __IPHONE_3_0
#warning ERROR! FishLamp Requires iPhone SDK >= 3.0. See FishLampRequired.h for compatibility help.
#endif
#endif

#import "GtDebug.h"

#ifndef GT_UNIT_TESTS
#define GT_UNIT_TESTS DEBUG
#endif

#ifndef GT_MEMORY_MONITOR
#define GT_MEMORY_MONITOR DEBUG
#endif

#if GT_MEMORY_MONITOR
#if __clang__
#undef GT_MEMORY_MONITOR
#define GT_MEMORY_MONITOR 0
#endif
#endif

#if GT_MEMORY_MONITOR
#import "GtMemoryMonitor.h"
#endif

#define GtReleaseObjectsCachedInMemoryNotification @"CLEARMEM"

// DEBUGGING environment varaibles

#define GtTraceNetworkRequests          @"GtTraceNetworkRequests" // YES/NO
#define GtTraceActions                  @"GtTraceActions"
#define GtTraceActionContextChanges     @"GtTraceActionContextChanges"
#define GtTraceTextEditing              @"GtTraceTextEditing"

#define GtFakeNetworkTimeouts           @"GtFakeNetworkTimeouts" // YES/NO
#define GtFake3gUploadError             @"GtFake3gUploadError"

#define GtTimePhotoOperations			@"GtTimePhotoOperations"

#define GtTraceReachability             @"GtTraceReachability"
#define GtNetworkReachable              @"GtNetworkReachable"
#define GtNetworkNotReachable           @"GtNetworkNotReachable"


// VALUES
#define GtDelayActionsBy                @"GtDelayActionsBy" // in seconds, e.g. 5
#define GtDelayOperationsInSimulatorBy  @"GtDelayOperationsInSimulatorBy"
