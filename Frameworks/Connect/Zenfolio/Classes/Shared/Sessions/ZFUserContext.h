//
//  ZFUserContext.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpUserContext.h"
#import "ZFHttpRequestAuthenticator.h"
#import "ZFHttpRequest.h"
#import "ZFCacheService.h"

@interface ZFUserContext : FLHttpUserContext {
@private
    ZFGroup* _rootGroup;
}
@property (readwrite, strong) ZFGroup* rootGroup;
@end

//@protocol ZFUserContextObserver <NSObject>
//- (void) userContext:(ZFUserContext*) userContext authenticationFinishedWithError:(NSError*) error;
//- (void) userContextUserDidLogout:(ZFUserContext*) userContext;
//@end


