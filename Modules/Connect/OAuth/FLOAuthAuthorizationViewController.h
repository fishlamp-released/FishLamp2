//
//  FLOAuthAuthorizationViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOAuthApp.h"
#import "FLViewController.h"
#import "FLWebViewController.h"
#import "FLOAuthAuthencationData.h"
#import "FLOAuthSession.h"

@class FLOAuthAuthorizationViewController;

@protocol FLOAuthAuthorizationViewControllerDelegate;

@interface FLOAuthAuthorizationViewController : FLWebViewController {
@private
	FLOAuthApp* m_app;
	FLOAuthAuthencationData* m_authData;
}

@property (readwrite, assign, nonatomic) id<FLOAuthAuthorizationViewControllerDelegate> OAuthAuthorizationViewControllerDelegate;
@property (readonly, retain, nonatomic) FLOAuthApp* app;

+ (FLOAuthAuthorizationViewController*) OAuthAuthorizationViewController;

- (void) beginAuthorizingApp:(FLOAuthApp*) app delegate:(id<FLOAuthAuthorizationViewControllerDelegate>) delegate;

@end

@protocol FLOAuthAuthorizationViewControllerDelegate <FLWebViewControllerDelegate>

- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller didAuthenticate:(FLOAuthSession*) authenticate;
- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller authenticationDidFail:(NSError*) authenticate;

@end