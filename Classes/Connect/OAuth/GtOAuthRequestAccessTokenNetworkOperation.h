//
//  GtOAuthRequestAccessTokenNetworkOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"
#import "GtOAuthAuthencationData.h"
#import "GtOAuthApp.h"

@interface GtOAuthRequestAccessTokenNetworkOperation : GtHttpOperation {

@private
	GtOAuthAuthencationData* m_authData;
	GtOAuthApp* m_app;
}

- (id) initWithOAuthApp:(GtOAuthApp*) app authData:(GtOAuthAuthencationData*) data;
+ (GtOAuthRequestAccessTokenNetworkOperation*) OAuthRequestAccessTokenNetworkOperation:(GtOAuthApp*) app authData:(GtOAuthAuthencationData*) data;

@end
