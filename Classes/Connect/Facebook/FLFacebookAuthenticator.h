//
//  FLFacebookAuthenticator.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFacebookMgr.h"
#import "FLViewController.h"
#import "FLFacebookLoginViewController.h"

@protocol FLFacebookAuthenticatorDelegate;

@interface FLFacebookAuthenticator : NSObject<FLFacebookLoginViewControllerDelegate> {
@private
    id<FLFacebookAuthenticatorDelegate> _delegate;
    FLViewController* _viewController;
}

@property (readonly, retain, nonatomic) FLViewController* viewController;

+ (FLFacebookAuthenticator*) facebookAuthenticator;

- (void) beginAuthenticatingInViewController:(FLViewController*) viewController  delegate:(id<FLFacebookAuthenticatorDelegate>) delegate;

@end

@protocol FLFacebookAuthenticatorDelegate <NSObject>
- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator authenticationDidComplete:(FLFacebookNetworkSession*) session;
- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator authenticationDidFail:(NSError*) error;
- (void) facebookAuthenticatorWasCancelled:(FLFacebookAuthenticator*) authenticator;

- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator 
    presentAuthenticationViewController:(FLFacebookLoginViewController*) viewController;
- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator 
    dismissAuthenticationViewController:(FLFacebookLoginViewController*) viewController;

@end

