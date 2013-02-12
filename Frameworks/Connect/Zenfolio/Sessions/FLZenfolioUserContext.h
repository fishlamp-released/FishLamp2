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
#import "FLZenfolioCacheService.h"

@interface FLZenfolioUserContext : FLHttpUserContext {
@private
    FLZenfolioGroup* _rootGroup;
}
@property (readwrite, strong) FLZenfolioGroup* rootGroup;
@end

//@protocol FLZenfolioUserContextObserver <NSObject>
//- (void) userContext:(FLZenfolioUserContext*) userContext authenticationFinishedWithError:(NSError*) error;
//- (void) userContextUserDidLogout:(FLZenfolioUserContext*) userContext;
//@end


