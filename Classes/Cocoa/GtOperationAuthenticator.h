//
//	GtOperationAuthenticator.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtOperation;

@protocol GtOperationAuthenticator <NSObject>

- (void) configureDefaultSecurityForOperation:(GtOperation*) operation;
- (NSError*) authenthicateOperation:(GtOperation*) operation;

@end

@interface GtOperationAuthenticator : NSObject<GtOperationAuthenticator> {
}

// override these
- (NSError*) doAuthenticateOperation:(GtOperation*) operation;
- (BOOL) shouldAuthenticateOperation:(GtOperation*) operation;
- (void) prepareAuthenticatedOperation:(GtOperation*) operation;

@end
