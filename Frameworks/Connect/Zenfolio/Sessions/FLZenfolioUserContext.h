//
//  FLZenfolioUserContext.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioWebApi.h"
#import "FLHttpUserContext.h"
#import "FLZenfolioHttpRequestAuthenticator.h"
#import "FLZenfolioHttpRequest.h"
#import "FLZenfolioCache.h"
#import "FLImageCache.h"

@interface FLZenfolioUserContext : FLHttpUserContext {
@private
    FLZenfolioGroup* _rootGroup;
    FLZenfolioCache* _objectCache;
}
@property (readwrite, strong) FLZenfolioGroup* rootGroup;

@property (readonly, strong) FLZenfolioCache* objectCache;
@end

//@protocol FLZenfolioUserContextObserver <NSObject>
//- (void) userContext:(FLZenfolioUserContext*) userContext authenticationFinishedWithError:(NSError*) error;
//- (void) userContextUserDidLogout:(FLZenfolioUserContext*) userContext;
//@end


