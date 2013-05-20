//
//  GtGlobalNetworkActivityIndicator.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGlobalNetworkActivityIndicator.h"

static id<GtGlobalNetworkActivityIndicator> s_globalIndicator = nil;

@implementation GtGlobalNetworkActivityIndicator

+ (void) setGlobalNetworkActivityIndicator:(id<GtGlobalNetworkActivityIndicator>) indicator
{
    GtAssignObject(s_globalIndicator, indicator);
}

+ (id<GtGlobalNetworkActivityIndicator>) globalNetworkActivityIndicator
{
    return s_globalIndicator;
}

@end