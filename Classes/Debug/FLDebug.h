//
//	FLDebug.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/19/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <execinfo.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#define DO_PRAGMA(x) _Pragma (#x)
#define TODO(x) DO_PRAGMA(message ("TODO: " #x))
#define FIXME(x) DO_PRAGMA(message ("FIXME: " #x))

// NOTE: declaring this inline prevents FLLogStackTrace from showing up as top of stack.
NS_INLINE
NSString* FLStackTraceString() {
     NSMutableString* stack = [NSMutableString string];
	 void* callstack[128];
	 int i, frames = backtrace(callstack, 128);
	 char** strs = backtrace_symbols(callstack, frames);
	 for (i = 0; i < frames; ++i) {
        [stack appendFormat:@"%s\n", strs[i]];
	 }
	 free(strs);
     return stack;
}


//#if __clang__
//#undef ALLOCATION_HOOKS
//#define ALLOCATION_HOOKS 0
//#endif
//
//#ifndef ALLOCATION_HOOKS
//#define ALLOCATION_HOOKS DEBUG
//#endif


//@class FLStringBuilder;
//	
//#if ALLOCATION_HOOKS 
//@protocol FLAllocationHookProtocol <NSObject>
//
//- (id) allocationHookAlloc:(id) object;
//- (id) allocationHookRelease:(id) object;
//@end
//	
//@interface NSObject (FLDebug)
//+ (id<FLAllocationHookProtocol>) setAllocHook:(id<FLAllocationHookProtocol>) hook;
//+ (id<FLAllocationHookProtocol>) allocationHook;
//@end
//#endif
//


//@protocol NSObjectDescriber <NSObject>
//@optional
//- (void) describeToStringBuilder:(FLStringBuilder*) builder;
//@end

/*
#if 0

typedef struct {
    BOOL did_dealloc;
    NSInteger retainCount;
    NSMutableArray* history;
} FLDebugTrackerState;

#define FLDebugTrackerMember() FLDebugTrackerState _trackerState

extern void debug_retain(id object, FLDebugTrackerState* state);
extern void debug_release(id object, FLDebugTrackerState* state);
extern void debug_autorelease(id object, FLDebugTrackerState* state);
extern void debug_print_history(id object, FLDebugTrackerState* state);

#define FLSynthesizeDebugTracker() \
- (id)retain { debug_retain(self, &_trackerState); return self; } \
- (oneway void)release { debug_release(self, &_trackerState); } \
- (id)autorelease { debug_autorelease(self, &_trackerState); return FLAutorelease(super); } \
- (void) logHistory { debug_print_history(self, &_trackerState); }

#else
#define FLDebugTrackerMember()
#define FLSynthesizeDebugTracker()
#endif
*/