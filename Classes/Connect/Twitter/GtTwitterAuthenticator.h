//
//  GtTwitterAuthenticator.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTwitterMgr.h"
#import "GtViewController.h"
#import "GtOAuthAuthorizationViewController.h"
#import "GtViewController.h"

@protocol GtTwitterAuthenticatorDelegate;

@interface GtTwitterAuthenticator : NSObject<GtOAuthAuthorizationViewControllerDelegate> {
@private
    id<GtTwitterAuthenticatorDelegate> m_delegate;
    GtViewController* m_viewController;
    NSString* m_userGuid;
}

@property (readonly, retain, nonatomic) GtViewController* viewController;

+ (GtTwitterAuthenticator*) twitterAuthenticator;

- (void) beginAuthenticatingInViewController:(GtViewController*) viewController 
	userGuid:(NSString*) userGuid 
	delegate:(id<GtTwitterAuthenticatorDelegate>) delegate;

@end

@protocol GtTwitterAuthenticatorDelegate <NSObject>
- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator didAuthenticateUser:(NSString*) userGuid;
- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator didFail:(NSError*) error;
- (void) twitterAuthenticatorWasCancelled:(GtTwitterAuthenticator*) authenticator;

- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator 
    presentAuthenticationViewController:(GtOAuthAuthorizationViewController*) viewController;
- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator 
    dismissAuthenticationViewController:(GtOAuthAuthorizationViewController*) viewController;
@end
