//
//  FLOAuthAuthorizationViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	FLOAuthApp* _app;
	FLOAuthAuthencationData* _authData;
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