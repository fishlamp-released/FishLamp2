
//
//  FLOAuthRequestTokenHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
