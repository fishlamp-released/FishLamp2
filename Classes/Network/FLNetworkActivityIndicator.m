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
	FLRelease(_objects);
	FLSuperDealloc();
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
        FLAssertIsNotNil(startedBy);
        if(_objects.count == 0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    
        [_objects addObject:[NSValue valueWithNonretainedObject:startedBy]];
    }];
}

//- (BOOL) didShowNetworkActivityIndicator:(id) startedBy {
//    FLAssertIsNotNil(startedBy);
//    BOOL didStart = NO;    
//	@synchronized(self) {
//        didStart = [_objects containsObject:[NSValue valueWithNonretainedObject:startedBy]];
//    }
//    
//    return didStart;
//}

- (BOOL) isVisible {
    return [UIApplication sharedApplication].networkActivityIndicatorVisible;
}

- (void) hideNetworkActivityIndicator:(id) stoppedBy {
        
	[self performBlockOnMainThread: ^{
        
        FLAssertIsNotNil(stoppedBy);
        NSValue* value = [NSValue valueWithNonretainedObject:stoppedBy];

        FLAssert([_objects containsObject:value], @"must stop network activity with object you started it with");
    
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
