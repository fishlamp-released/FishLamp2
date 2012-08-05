//
//	FLCallback.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/17/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

typedef struct {
    void* target;
	SEL action;
} FLCallback;

extern const FLCallback FLCallbackZero;

NS_INLINE
FLCallback FLCallbackMake(id target, SEL action)
{
   FLCallback cb = { (__fl_bridge void*) target, action };
   return cb;
}

NS_INLINE
BOOL FLCallbackIsNotNil(FLCallback cb)
{
	return cb.target && cb.action;
}

NS_INLINE
BOOL FLCallbackIsNil(FLCallback cb)
{
	return !cb.target || !cb.action;
}

extern
BOOL FLCallbackInvoke(FLCallback callback, id sender);

// compatibility
#define FLInvokeCallback FLCallbackInvoke

extern
id FLCallbackPerformWithObject(FLCallback callback, id withObject);

extern
id FLCallbackPerformWithObjects(FLCallback callback, id withObject1, id withObject2);

