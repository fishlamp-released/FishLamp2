
//
//  FLOAuthRequestTokenHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"
#import "FLHttpRequestBehavior.h"

@class FLOAuthApp;

@interface FLOAuthRequestTokenHttpRequest : NSObject<FLHttpRequestBehavior> {
@private 
	FLOAuthApp* _app;
    NSURL* _url;
}

- (id) initWithOAuthApp:(FLOAuthApp*) app;
+ (id) OAuthRequestTokenNetworkOperation:(FLOAuthApp*) app;

@end
