//
//  FLZenfolioUserService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioWebApi.h"
#import "FLHttpUserService.h"
#import "FLZenfolioAuthenticationService.h"
#import "FLZenfolioHttpRequest.h"
#import "FLZenfolioCacheService.h"
#import "FLImageStoreService.h"

@interface FLZenfolioUserService : FLHttpUserService {
@private
    FLZenfolioGroup* _rootGroup;
    FLZenfolioCacheService* _cache;
}
@property (readwrite, strong) FLZenfolioGroup* rootGroup;

@property (readonly, strong) FLZenfolioCacheService* cache;
@end

//@protocol FLZenfolioUserContextObserver <NSObject>
//- (void) userContext:(FLZenfolioUserService*) userContext authenticationFinishedWithError:(NSError*) error;
//- (void) userContextUserDidLogout:(FLZenfolioUserService*) userContext;
//@end


