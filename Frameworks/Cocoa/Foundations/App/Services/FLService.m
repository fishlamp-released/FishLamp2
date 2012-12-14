//
//  FLService.m
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLContext.h"

@interface FLService()
@property (readwrite, assign) id context;
@end

@implementation FLService

@synthesize context = _context;
@synthesize isServiceOpen = _isServiceOpen;

- (void) wasAddedToContext:(FLContext*) context {
    FLAssert_v([self.context isContextOpen] == NO, @"adding service to open context");
    self.context = context;
}

+ (NSString*) serviceUTI {
    FLAssertFailed_v(@"need to define serviceUTI");
    return nil;
}

- (void) openService {
    FLAssertNotNil_v(self.context, @"service not in a context");
    FLAssert_v([self.context isContextOpen], @"opening a service in a closed context");
    _isServiceOpen = YES;
}

- (void) closeService {
    FLAssertNotNil_v(self.context, @"service not in a context");
    _isServiceOpen = NO;
}


@end

