//
//  FLOAuthRequestAccessTokenHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLHttpRequest.h"
#import "FLOAuthAuthencationData.h"
#import "FLOAuthApp.h"

@interface FLOAuthRequestAccessTokenHttpRequest : FLHttpRequest {
@private
	FLOAuthAuthencationData* _authData;
	FLOAuthApp* _app;
    NSURL* _url;
}

- (id) initWithOAuthApp:(FLOAuthApp*) app authData:(FLOAuthAuthencationData*) data;
+ (FLOAuthRequestAccessTokenHttpRequest*) OAuthRequestAccessTokenNetworkOperation:(FLOAuthApp*) app authData:(FLOAuthAuthencationData*) data;

@end
