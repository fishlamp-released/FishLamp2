//
//	GtCallback.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/17/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"

typedef struct {
    void* target;
	SEL action;
} GtCallback;

extern const GtCallback GtCallbackZero;

NS_INLINE
GtCallback GtCallbackMake(id target, SEL action)
{
    GtCallback cb = { target, action };
	return cb;
}

NS_INLINE
BOOL GtCallbackIsNotNil(GtCallback cb)
{
	return cb.target && cb.action;
}

NS_INLINE
BOOL GtCallbackIsNil(GtCallback cb)
{
	return !cb.target || !cb.action;
}

extern
BOOL GtCallbackInvoke(GtCallback callback, id sender);

// compatibility
#define GtInvokeCallback GtCallbackInvoke

extern
id GtCallbackPerformWithObject(GtCallback callback, id withObject);

extern
id GtCallbackPerformWithObjects(GtCallback callback, id withObject1, id withObject2);

