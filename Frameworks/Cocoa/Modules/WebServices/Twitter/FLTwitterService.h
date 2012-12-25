//
//  FLTwitter.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLOauthApp.h"
#import "FLOAuthSession.h"
#import "FLService.h"

@class FLDatabase;

#define FLTwitterDefaultUserID [NSString zeroGuidString]

@interface FLTwitterService : FLService {
@private
    FLOAuthApp* _oauthInfo;
	FLOAuthSession* _oauthSession;
    FLDatabase* _database;
}

+ (FLTwitterService*) twitterService;

@property (readonly, strong) FLOAuthApp* oauthInfo;
@property (readonly, strong) FLOAuthSession* oauthSession;

+ (void) clearTwitterCookies;
@end

