//
//  GtFacebookAuthenticator.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtFacebookMgr.h"
#import "GtViewController.h"
#import "GtFacebookLoginViewController.h"

@protocol GtFacebookAuthenticatorDelegate;

@interface GtFacebookAuthenticator : NSObject<GtFacebookLoginViewControllerDelegate> {
@private
    id<GtFacebookAuthenticatorDelegate> m_delegate;
    GtViewController* m_viewController;
}

@property (readonly, retain, nonatomic) GtViewController* viewController;

+ (GtFacebookAuthenticator*) facebookAuthenticator;

- (void) beginAuthenticatingInViewController:(GtViewController*) viewController  delegate:(id<GtFacebookAuthenticatorDelegate>) delegate;

@end

@protocol GtFacebookAuthenticatorDelegate <NSObject>
- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator authenticationDidComplete:(GtFacebookNetworkSession*) session;
- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator authenticationDidFail:(NSError*) error;
- (void) facebookAuthenticatorWasCancelled:(GtFacebookAuthenticator*) authenticator;

- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator 
    presentAuthenticationViewController:(GtFacebookLoginViewController*) viewController;
- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator 
    dismissAuthenticationViewController:(GtFacebookLoginViewController*) viewController;

@end

