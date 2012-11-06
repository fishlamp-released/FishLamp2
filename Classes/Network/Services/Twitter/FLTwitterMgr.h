//
//  FLTwitter.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOauthApp.h"
#import "FLOAuthSession.h"
#import "FLService.h"

#define FLTwitterDefaultUserID [NSString zeroGuidString]

@interface FLTwitterMgr : FLService {
@private
    FLOAuthApp* _oauthInfo;
	FLOAuthSession* _oauthSession;
}

@property (readonly, strong) FLOAuthApp* oauthInfo;
@property (readonly, strong) FLOAuthSession* oauthSession;

+ (void) clearTwitterCookies;
@end

declare_service_(twitter, FLTwitterMgr);

