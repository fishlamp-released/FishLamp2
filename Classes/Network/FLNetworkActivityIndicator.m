//
//	FLNetworkActivityMonitor.m
//	Snaplets
//
//	Created by Mike Fullerton on 11/4/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "FLNetworkActivityIndicator.h"

#define kHideDelay 0.3f

@implementation FLNetworkActivityIndicator

FLSynthesizeSingleton(FLNetworkActivityIndicator);

- (void) dealloc {
	release_(_objects);
	super_dealloc_();
}

- (id) init {
    self = [super init];
    if(self) {
        _objects = [[NSMutableSet alloc] init];
    }
    
    return self;
}

- (void) showNetworkActivityIndicator:(id) startedBy {
    
	[self performBlockOnMainThread: ^{
        FLAssertIsNotNil_(startedBy);
        if(_objects.count == 0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    
        [_objects addObject:[NSValue valueWithNonretainedObject:startedBy]];
    }];
}

//- (BOOL) didShowNetworkActivityIndicator:(id) startedBy {
//    FLAssertIsNotNil_(startedBy);
//    BOOL wasStarted = NO;    
//	@synchronized(self) {
//        wasStarted = [_objects containsObject:[NSValue valueWithNonretainedObject:startedBy]];
//    }
//    
//    return wasStarted;
//}

- (BOOL) isVisible {
    return [UIApplication sharedApplication].networkActivityIndicatorVisible;
}

- (void) hideNetworkActivityIndicator:(id) stoppedBy {
        
	[self performBlockOnMainThread: ^{
        
        FLAssertIsNotNil_(stoppedBy);
        NSValue* value = [NSValue valueWithNonretainedObject:stoppedBy];

        FLAssert_v([_objects containsObject:value], @"must stop network activity with object you started it with");
    
        [_objects removeObject:value];

        if(_objects.count == 0) {
            [self performBlockWithDelay:kHideDelay block:^{
                if(_objects.count == 0) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }
            }];
        };
	}];
}

@end
