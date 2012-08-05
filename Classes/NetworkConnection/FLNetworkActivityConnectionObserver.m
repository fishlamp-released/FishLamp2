//
//  FLNetworkActivityConnectionObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLNetworkActivityConnectionObserver.h"

#import "FLGlobalNetworkActivityIndicator.h"

@implementation FLNetworkActivityConnectionObserver

FLSynthesizeSingleton(FLNetworkActivityConnectionObserver);

- (id) init {
    self = [super init];
    if(self) {
        [self observeEvent:FLNetworkEventWillStartObserving target:self];
        [self observeEvent:FLNetworkEventDidStopObserving target:self];
    }
    
    return self;
}

- (void) networkConnectionWillStartObserving:(FLNetworkConnection*) connection {
    [[FLGlobalNetworkActivityIndicator instance] showNetworkActivityIndicator:self];
}

- (void) networkConnectionDidStopObserving:(FLNetworkConnection*) connection {
    [[FLGlobalNetworkActivityIndicator instance] hideNetworkActivityIndicator:self];
}

+ (FLNetworkActivityConnectionObserver*) networkActivityConnectionObserver {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

@end
