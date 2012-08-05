//
//	FLOperationAuthenticator.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@class FLOperation;

@protocol FLOperationAuthenticator <NSObject>

- (void) configureDefaultSecurityForOperation:(FLOperation*) operation;
- (NSError*) authenthicateOperation:(FLOperation*) operation;

@end

@interface FLOperationAuthenticator : NSObject<FLOperationAuthenticator> {
}

// override these
- (NSError*) doAuthenticateOperation:(FLOperation*) operation;
- (BOOL) shouldAuthenticateOperation:(FLOperation*) operation;
- (void) prepareAuthenticatedOperation:(FLOperation*) operation;

@end
