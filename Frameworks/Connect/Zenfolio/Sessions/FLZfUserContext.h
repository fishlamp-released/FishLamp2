//
//  FLZfUserContext.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpUserContext.h"
#import "FLZfHttpRequestAuthenticator.h"
#import "FLZfHttpRequest.h"
#import "FLZfCacheService.h"

@interface FLZfUserContext : FLHttpUserContext {
@private
    FLZfGroup* _rootGroup;
}
@property (readwrite, strong) FLZfGroup* rootGroup;
@end

//@protocol FLZfUserContextObserver <NSObject>
//- (void) userContext:(FLZfUserContext*) userContext authenticationFinishedWithError:(NSError*) error;
//- (void) userContextUserDidLogout:(FLZfUserContext*) userContext;
//@end


