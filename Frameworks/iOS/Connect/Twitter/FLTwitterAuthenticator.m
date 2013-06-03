//
//  FLTwitterAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTwitterAuthenticator.h"
#import "FLTwitterLoginWebViewController.h"
#import "FLNavigationControllerViewController.h"

@implementation FLTwitterAuthenticator

@synthesize viewController = _viewController;

+ (FLTwitterAuthenticator*) twitterAuthenticator
{
    return FLAutorelease([[FLTwitterAuthenticator alloc] init]);
}

- (void) cleanup
{
    FLAutorelease(_delegate);
    _delegate = nil;
    
    FLAutorelease(_viewController);
    _viewController = nil;
    
    FLReleaseWithNil(_userGuid);
}

- (void) dealloc
{
    [self cleanup];
    FLSuperDealloc();
}

- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller didAuthenticate:(FLOAuthSession*) session
{
    [[FLTwitterMgr instance] didAuthenticateForUserGuid:_userGuid session:session ];

    [_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [_delegate twitterAuthenticator:self didAuthenticateUser:_userGuid];

    [self cleanup];
    FLAutorelease(self);
}

- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller authenticationDidFail:(NSError*) error
{
// TODO: display error???
    [_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [_delegate twitterAuthenticator:self didFail:error];

    [self cleanup];
    FLAutorelease(self);
}

- (void) webViewControllerUserDidCancel:(FLWebViewController*) controller
{
    [_delegate twitterAuthenticator:self dismissAuthenticationViewController:(FLOAuthAuthorizationViewController*) controller];
    [_delegate twitterAuthenticatorWasCancelled:self];

    [self cleanup];
    FLAutorelease(self);
}

- (void) beginAuthenticatingInViewController:(FLViewController*) viewController 
                                    userGuid:(NSString*) userGuid 
                                    delegate:(id<FLTwitterAuthenticatorDelegate>) delegate
{
    FLSetObjectWithRetain(_delegate, delegate);
    FLSetObjectWithRetain(_userGuid, userGuid);
    FLSetObjectWithRetain(_viewController, viewController);
    
	if([[FLTwitterMgr instance] needsAuthorizationForUserGuid:userGuid])
	{
        mrc_retain_(self);
        
        [[FLTwitterMgr instance] clearTwitterCookies];
        
        FLTwitterLoginWebViewController* controller = [FLTwitterLoginWebViewController webViewController:FLWebViewControllerButtonModeCanCancel | 
            (DeviceIsPad() ? FLWebViewControllerButtonModeNavigationButtonsOnTop : FLWebViewControllerButtonModeNavigationButtonsOnBottom)];
		
        [delegate twitterAuthenticator:self presentAuthenticationViewController:controller];
		
		[controller beginAuthorizingApp:[FLTwitterMgr instance].oauthInfo delegate:self];
	}
	else
	{
        [delegate twitterAuthenticator:self didAuthenticateUser:_userGuid];
    }


}

@end
