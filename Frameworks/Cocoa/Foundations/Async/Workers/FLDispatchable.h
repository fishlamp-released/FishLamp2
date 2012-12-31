//
//  FLDispatchable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLFinisher.h"
#import "FLResult.h"

typedef void (^FLFinishableBlock)(FLFinisher* finisher);

@protocol FLObjectAuthenticator;

@protocol FLDispatchable <NSObject>

- (void) startAsyncWithFinisher:(FLFinisher*) finisher;

@optional
- (void) didMoveToContext:(id) context;
- (id<FLObjectAuthenticator>) authenticator;
- (void) requestCancel;
@end

@interface NSObject (FLDispatchable) 
- (id) runSynchronously;
@end

@protocol FLObjectAuthenticator <NSObject>

// returns new credentials
- (id) authenticateObject:(id) object withCredentials:(id) credentials;
        
@end
