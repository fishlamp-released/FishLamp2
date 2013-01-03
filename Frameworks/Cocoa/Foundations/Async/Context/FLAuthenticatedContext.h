//
//  FLAuthenticatedContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchableContext.h"
#import "FLObjectAuthenticator.h"

@interface FLAuthenticatedContext : FLDispatchableContext {
@private
    id _authenticationCredentials;
}

@property (readonly, assign, getter=isAuthenticated) BOOL isAuthenticated;

@property (readwrite, strong) id authenticationCredentials;

@end



