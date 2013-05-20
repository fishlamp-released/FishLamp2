//
//  GtOAuthAuthorizationViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOAuthApp.h"
#import "GtViewController.h"
#import "GtWebViewController.h"
#import "GtOAuthAuthencationData.h"
#import "GtOAuthSession.h"

@class GtOAuthAuthorizationViewController;

@protocol GtOAuthAuthorizationViewControllerDelegate;

@interface GtOAuthAuthorizationViewController : GtWebViewController {
@private
	GtOAuthApp* m_app;
	GtOAuthAuthencationData* m_authData;
}

@property (readwrite, assign, nonatomic) id<GtOAuthAuthorizationViewControllerDelegate> OAuthAuthorizationViewControllerDelegate;
@property (readonly, retain, nonatomic) GtOAuthApp* app;

+ (GtOAuthAuthorizationViewController*) OAuthAuthorizationViewController;

- (void) beginAuthorizingApp:(GtOAuthApp*) app delegate:(id<GtOAuthAuthorizationViewControllerDelegate>) delegate;

@end

@protocol GtOAuthAuthorizationViewControllerDelegate <GtWebViewControllerDelegate>

- (void) OAuthAuthorizationViewController:(GtOAuthAuthorizationViewController*) controller didAuthenticate:(GtOAuthSession*) authenticate;
- (void) OAuthAuthorizationViewController:(GtOAuthAuthorizationViewController*) controller authenticationDidFail:(NSError*) authenticate;

@end