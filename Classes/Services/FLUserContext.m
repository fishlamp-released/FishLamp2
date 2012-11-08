//
//  FLUserContext.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserContext.h"

@implementation FLUserContext

synthesize_(userLogin)

dealloc_(
    [_userLogin release];
)
- (void) loadPassword:(FLUserLogin*) password {
}

@end
