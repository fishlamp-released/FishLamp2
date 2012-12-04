//
//  FLOAuthRequestAccessTokenNetworkOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLOAuthAuthencationData.h"
#import "FLOAuthApp.h"

@interface FLOAuthRequestAccessTokenNetworkOperation : FLHttpOperation {
@private
	FLOAuthAuthencationData* _authData;
	FLOAuthApp* _app;
    NSURL* _url;
}

- (id) initWithOAuthApp:(FLOAuthApp*) app authData:(FLOAuthAuthencationData*) data;
+ (FLOAuthRequestAccessTokenNetworkOperation*) OAuthRequestAccessTokenNetworkOperation:(FLOAuthApp*) app authData:(FLOAuthAuthencationData*) data;

@end
