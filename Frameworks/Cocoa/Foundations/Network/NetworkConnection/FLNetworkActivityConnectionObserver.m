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

+ (id) networkActivityConnectionObserver {
    return FLAutorelease([[[self class] alloc] init]);
}

//- (void) observerWasAddedToNetworkConnection:(FLNetworkConnection*) connection {
//    [[FLGlobalNetworkActivityIndicator instance] showNetworkActivityIndicator:self];
//}
//
//- (void) observerWasRemovedFromNetworkConnection:(FLNetworkConnection*) connection {
//    [[FLGlobalNetworkActivityIndicator instance] hideNetworkActivityIndicator:self];
//}
//
//+ (FLNetworkActivityConnectionObserver*) networkActivityConnectionObserver {
//    return FLAutorelease([[[self class] alloc] init]);
//}

@end
