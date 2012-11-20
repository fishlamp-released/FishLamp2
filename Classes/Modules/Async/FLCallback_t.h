//
//	FLCallback_t.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/17/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLObjc.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

typedef struct {
    __unsafe_unretained id target;
	SEL action;
} FLCallback_t;

extern const FLCallback_t FLCallbackZero;

NS_INLINE
FLCallback_t FLCallbackMake(id target, SEL action) {
   FLCallback_t cb = { target, action };
   return cb;
}

NS_INLINE
BOOL FLCallbackIsNotNil(FLCallback_t cb) {
	return cb.target && cb.action;
}

NS_INLINE
BOOL FLCallbackIsNil(FLCallback_t cb) {
	return !cb.target || !cb.action;
}

extern
BOOL FLCallbackInvoke(FLCallback_t callback, id sender);

// compatibility
#define FLInvokeCallback FLCallbackInvoke

extern
id FLCallbackPerformWithObject(FLCallback_t callback, id withObject);

extern
id FLCallbackPerformWithObjects(FLCallback_t callback, id withObject1, id withObject2);

