//
//  FLDataStoreWithCacheService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDataStoreWithCacheService.h"

@implementation FLDataStoreWithCacheService
@synthesize cache = _cache;

#if FL_MRC
- (void) dealloc {
    [_cache release];
    [super dealloc];
}
#endif

- (void) openService:(id) opener {
    FLAssertNotNil_(self.cache);
    [super openService:opener];
}

- (void) closeService:(id) closer {
    [super closeService:closer];
    self.cache = nil;
}
@end
