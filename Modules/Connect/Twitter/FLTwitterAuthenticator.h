//
//  FLTwitterAuthenticator.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTwitterMgr.h"
#import "FLViewController.h"
#import "FLOAuthAuthorizationViewController.h"
#import "FLViewController.h"

@protocol FLTwitterAuthenticatorDelegate;

@interface FLTwitterAuthenticator : NSObject<FLOAuthAuthorizationViewControllerDelegate> {
@private
    id<FLTwitterAuthenticatorDelegate> m_delegate;
    FLViewController* m_viewController;
    NSString* m_userGuid;
}

@property (readonly, retain, nonatomic) FLViewController* viewController;

+ (FLTwitterAuthenticator*) twitterAuthenticator;

- (void) beginAuthenticatingInViewController:(FLViewController*) viewController 
	userGuid:(NSString*) userGuid 
	delegate:(id<FLTwitterAuthenticatorDelegate>) delegate;

@end

@protocol FLTwitterAuthenticatorDelegate <NSObject>
- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator didAuthenticateUser:(NSString*) userGuid;
- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator didFail:(NSError*) error;
- (void) twitterAuthenticatorWasCancelled:(FLTwitterAuthenticator*) authenticator;

- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator 
    presentAuthenticationViewController:(FLOAuthAuthorizationViewController*) viewController;
- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator 
    dismissAuthenticationViewController:(FLOAuthAuthorizationViewController*) viewController;
@end
