//
//  FLTwitterAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTwitterAuthenticator.h"
#import "FLTwitterLoginWebViewController.h"
#import "FLNavigationControllerViewController.h"

@implementation FLTwitterAuthenticator

@synthesize viewController = m_viewController;

+ (FLTwitterAuthenticator*) twitterAuthenticator
{
    return FLReturnAutoreleased([[FLTwitterAuthenticator alloc] init]);
}

- (void) cleanup
{
    FLAutorelease(m_delegate);
    m_delegate = nil;
    
    FLAutorelease(m_viewController);
    m_viewController = nil;
    
    FLReleaseWithNil(m_userGuid);
}

- (void) dealloc
{
    [self cleanup];
    FLSuperDealloc();
}

- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller didAuthenticate:(FLOAuthSession*) session
{
    [[FLTwitterMgr instance] didAuthenticateForUserGuid:m_userGuid session:session ];

    [m_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [m_delegate twitterAuthenticator:self didAuthenticateUser:m_userGuid];

    [self cleanup];
    FLAutorelease(self);
}

- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller authenticationDidFail:(NSError*) error
{
// TODO: display error???
    [m_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [m_delegate twitterAuthenticator:self didFail:error];

    [self cleanup];
    FLAutorelease(self);
}

- (void) webViewControllerUserDidCancel:(FLWebViewController*) controller
{
    [m_delegate twitterAuthenticator:self dismissAuthenticationViewController:(FLOAuthAuthorizationViewController*) controller];
    [m_delegate twitterAuthenticatorWasCancelled:self];

    [self cleanup];
    FLAutorelease(self);
}

- (void) beginAuthenticatingInViewController:(FLViewController*) viewController 
                                    userGuid:(NSString*) userGuid 
                                    delegate:(id<FLTwitterAuthenticatorDelegate>) delegate
{
    FLAssignObject(m_delegate, delegate);
    FLAssignObject(m_userGuid, userGuid);
    FLAssignObject(m_viewController, viewController);
    
	if([[FLTwitterMgr instance] needsAuthorizationForUserGuid:userGuid])
	{
        FLRetain(self);
        
        [[FLTwitterMgr instance] clearTwitterCookies];
        
        FLTwitterLoginWebViewController* controller = [FLTwitterLoginWebViewController webViewController:FLWebViewControllerButtonModeCanCancel | 
            (DeviceIsPad() ? FLWebViewControllerButtonModeNavigationButtonsOnTop : FLWebViewControllerButtonModeNavigationButtonsOnBottom)];
		
        [delegate twitterAuthenticator:self presentAuthenticationViewController:controller];
		
		[controller beginAuthorizingApp:[FLTwitterMgr instance] delegate:self];
	}
	else
	{
        [delegate twitterAuthenticator:self didAuthenticateUser:m_userGuid];
    }


}

@end
