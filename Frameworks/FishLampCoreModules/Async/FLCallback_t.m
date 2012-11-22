//
//	FLCallback_t.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/17/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCallback_t.h"

const FLCallback_t FLCallbackZero = { nil, nil };

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

BOOL FLCallbackInvoke(FLCallback_t callback, id sender) {
	if(callback.target && callback.action) {
        [callback.target performSelector:callback.action withObject:sender];
		return YES;
	}
	
	return NO;
}

id FLCallbackPerformWithObject(FLCallback_t callback, id withObject) {
	if(callback.target && callback.action) {
		return [callback.target performSelector:callback.action withObject:withObject];
	}

    return nil;
}

id FLCallbackPerformWithObjects(FLCallback_t callback, id withObject1, id withObject2) {
	if(callback.target && callback.action) {
		return [callback.target performSelector:callback.action withObject:withObject1 withObject:withObject2];
	}

    return nil;
}

#pragma clang diagnostic pop


