//
//  FLTwitter.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "FLCocoaRequired.h"

#import "FLOauthApp.h"
#import "FLOAuthSession.h"
#import "FLService.h"
#import "FLObjectStorage.h"


#define FLTwitterDefaultUserID [NSString zeroGuidString]

@interface FLTwitterService : FLService {
@private
    FLOAuthApp* _oauthInfo;
	FLOAuthSession* _oauthSession;
}

+ (FLTwitterService*) twitterService;

@property (readonly, strong) FLOAuthApp* oauthInfo;
@property (readonly, strong) FLOAuthSession* oauthSession;

+ (void) clearTwitterCookies;
@end

@protocol FLTwitterServiceOpener <NSObject>
- (void) openTwitterService:(FLTwitterService*) service;
- (void) closeTwitterService:(FLTwitterService*) service;
@end

#endif