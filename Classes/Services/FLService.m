//
//  FLService.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLSession.h"

@interface FLService()
@property (readwrite, assign) id session;
@end

@implementation FLService

synthesize_(session)
synthesize_(isServiceOpen)

- (void) wasAddedToSession:(FLSession*) session {
    FLAssert_v([self.session isSessionOpen] == NO, @"adding service to open session");
    self.session = session;
}

+ (id) serviceID {
    FLAssertFailed_v(@"use register_service_ to set serviceID");
    return nil;
}

- (void) openService {
    FLAssertNotNil_v(self.session, @"service not in a session");
    FLAssert_v([self.session isSessionOpen], @"opening a service in a closed session");
    _isServiceOpen = YES;
}

- (void) closeService {
    FLAssertNotNil_v(self.session, @"service not in a session");
    _isServiceOpen = NO;
}


@end

