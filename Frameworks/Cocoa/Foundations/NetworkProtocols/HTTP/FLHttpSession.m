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

- (id) init {
    self = [super init];
    if(self) {
        self.httpRequestService = [FLRequestContext requestContext];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif


@end
