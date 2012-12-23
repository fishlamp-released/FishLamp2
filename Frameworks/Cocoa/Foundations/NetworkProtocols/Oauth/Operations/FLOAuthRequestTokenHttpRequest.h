
//
//  FLOAuthRequestTokenHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLHttpRequest.h"
#import "FLOAuth.h"
#import "FLOAuthApp.h"

@interface FLOAuthRequestTokenHttpRequest : FLHttpRequest {
@private 
	FLOAuthApp* _app;
    NSURL* _url;
}

- (id) initWithOAuthApp:(FLOAuthApp*) app;
+ (FLOAuthRequestTokenHttpRequest*) OAuthRequestTokenNetworkOperation:(FLOAuthApp*) app;

@end
