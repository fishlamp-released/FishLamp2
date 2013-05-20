//
//	GtCallback.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/17/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCallback.h"

const GtCallback GtCallbackZero = {0, 0};

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

BOOL GtCallbackInvoke(GtCallback callback, id sender) {
	if(callback.target && callback.action) {
        [(id)callback.target performSelector:callback.action withObject:sender];
		return YES;
	}
	
	return NO;
}

id GtCallbackPerformWithObject(GtCallback callback, id withObject) {
	if(callback.target && callback.action) {
		return [((id)callback.target) performSelector:callback.action withObject:withObject];
	}

    return nil;
}

id GtCallbackPerformWithObjects(GtCallback callback, id withObject1, id withObject2) {
	if(callback.target && callback.action) {
		return [ ((id)callback.target) performSelector:callback.action withObject:withObject1 withObject:withObject2];
	}

    return nil;
}

#pragma clang diagnostic pop


