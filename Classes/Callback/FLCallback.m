//
//	FLCallback.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/17/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCallback.h"

const FLCallback FLCallbackZero = {0, 0};

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

BOOL FLCallbackInvoke(FLCallback callback, id sender) {
	if(callback.target && callback.action) {
        [(__fl_bridge id)callback.target performSelector:callback.action withObject:sender];
		return YES;
	}
	
	return NO;
}

id FLCallbackPerformWithObject(FLCallback callback, id withObject) {
	if(callback.target && callback.action) {
		return [((__fl_bridge id)callback.target) performSelector:callback.action withObject:withObject];
	}

    return nil;
}

id FLCallbackPerformWithObjects(FLCallback callback, id withObject1, id withObject2) {
	if(callback.target && callback.action) {
		return [ ((__fl_bridge id)callback.target) performSelector:callback.action withObject:withObject1 withObject:withObject2];
	}

    return nil;
}

#pragma clang diagnostic pop


