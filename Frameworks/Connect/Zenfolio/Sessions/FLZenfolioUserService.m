//
//  FLZenfolioUserService.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioUserService.h"
#import "FLZenfolioSoapHttpRequestFactory.h"
#import "FLGcdDispatcher.h"
#import "FLOperation.h"

@implementation FLZenfolioUserService

@synthesize rootGroup = _rootGroup;

FLSynthesizeServiceProperty(cache, setCache, FLZenfolioCacheService*, _cache);

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

#if FL_MRC
- (void) dealloc {  
    [_rootGroup release];
    [super dealloc];
}
#endif

- (void) logoutUser {
//    [self closeContext];
    self.rootGroup = nil;
//    [self postObservation:@selector(userContextUserDidLogout:)];
}

@end
