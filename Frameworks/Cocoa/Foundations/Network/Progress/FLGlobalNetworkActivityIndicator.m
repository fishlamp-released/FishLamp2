//
//  FLGlobalNetworkActivityIndicator.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGlobalNetworkActivityIndicator.h"

static id<FLGlobalNetworkActivityIndicator> s_globalIndicator = nil;

@implementation FLGlobalNetworkActivityIndicator

+ (void) setInstance:(id<FLGlobalNetworkActivityIndicator>) indicator {
    FLSetObjectWithRetain(s_globalIndicator, indicator);
}

+ (id<FLGlobalNetworkActivityIndicator>) instance {
    return s_globalIndicator;
}

@end