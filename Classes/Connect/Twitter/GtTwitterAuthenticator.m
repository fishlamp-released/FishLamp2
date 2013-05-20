//
//  GtTwitterAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterAuthenticator.h"
#import "GtTwitterLoginWebViewController.h"
#import "GtNavigationControllerViewController.h"

@implementation GtTwitterAuthenticator

@synthesize viewController = m_viewController;

+ (GtTwitterAuthenticator*) twitterAuthenticator
{
    return GtReturnAutoreleased([[GtTwitterAuthenticator alloc] init]);
}

- (void) cleanup
{
    GtAutorelease(m_delegate);
    m_delegate = nil;
    
    GtAutorelease(m_viewController);
    m_viewController = nil;
    
    GtReleaseWithNil(m_userGuid);
}

- (void) dealloc
{
    [self cleanup];
    GtSuperDealloc();
}

- (void) OAuthAuthorizationViewController:(GtOAuthAuthorizationViewController*) controller didAuthenticate:(GtOAuthSession*) session
{
    [[GtTwitterMgr instance] didAuthenticateForUserGuid:m_userGuid session:session ];

    [m_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [m_delegate twitterAuthenticator:self didAuthenticateUser:m_userGuid];

    [self cleanup];
    GtAutorelease(self);
}

- (void) OAuthAuthorizationViewController:(GtOAuthAuthorizationViewController*) controller authenticationDidFail:(NSError*) error
{
// TODO: display error???
    [m_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [m_delegate twitterAuthenticator:self didFail:error];

    [self cleanup];
    GtAutorelease(self);
}

- (void) webViewControllerUserDidCancel:(GtWebViewController*) controller
{
    [m_delegate twitterAuthenticator:self dismissAuthenticationViewController:(GtOAuthAuthorizationViewController*) controller];
    [m_delegate twitterAuthenticatorWasCancelled:self];

    [self cleanup];
    GtAutorelease(self);
}

- (void) beginAuthenticatingInViewController:(GtViewController*) viewController 
                                    userGuid:(NSString*) userGuid 
                                    delegate:(id<GtTwitterAuthenticatorDelegate>) delegate
{
    GtAssignObject(m_delegate, delegate);
    GtAssignObject(m_userGuid, userGuid);
    GtAssignObject(m_viewController, viewController);
    
	if([[GtTwitterMgr instance] needsAuthorizationForUserGuid:userGuid])
	{
        GtRetain(self);
        
        [[GtTwitterMgr instance] clearTwitterCookies];
        
        GtTwitterLoginWebViewController* controller = [GtTwitterLoginWebViewController webViewController:GtWebViewControllerButtonModeCanCancel | 
            (DeviceIsPad() ? GtWebViewControllerButtonModeNavigationButtonsOnTop : GtWebViewControllerButtonModeNavigationButtonsOnBottom)];
		
        [delegate twitterAuthenticator:self presentAuthenticationViewController:controller];
		
		[controller beginAuthorizingApp:[GtTwitterMgr instance] delegate:self];
	}
	else
	{
        [delegate twitterAuthenticator:self didAuthenticateUser:m_userGuid];
    }


}

@end
