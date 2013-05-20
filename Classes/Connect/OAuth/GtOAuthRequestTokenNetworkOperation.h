//
//  GtOAuthRequestTokenNetworkOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"
#import "GtOAuth.h"
#import "GtOAuthApp.h"

@interface GtOAuthRequestTokenNetworkOperation : GtHttpOperation {
@private 
	GtOAuthApp* m_app;
}

@property (readonly, retain, nonatomic) GtOAuthApp* OAuthApp;

- (id) initWithOAuthApp:(GtOAuthApp*) app;
+ (GtOAuthRequestTokenNetworkOperation*) OAuthRequestTokenNetworkOperation:(GtOAuthApp*) app;

@end
