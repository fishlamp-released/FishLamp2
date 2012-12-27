//
//  FLHttpSession.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpSession.h"
#import "FLRequestContext.h"

@implementation FLHttpSession

@synthesize httpService = _httpService;

- (id) init {
    self = [super init];
    if(self) {
        [self registerService:@selector(httpService)];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_httpService release];
    [super dealloc];
}
#endif


@end
