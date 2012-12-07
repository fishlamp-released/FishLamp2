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

@synthesize viewController = _viewController;

+ (FLTwitterAuthenticator*) twitterAuthenticator
{
    return FLAutorelease([[FLTwitterAuthenticator alloc] init]);
}

- (void) cleanup
{
    mrc_autorelease_(_delegate);
    _delegate = nil;
    
    mrc_autorelease_(_viewController);
    _viewController = nil;
    
    FLReleaseWithNil_(_userGuid);
}

- (void) dealloc
{
    [self cleanup];
    super_dealloc_();
}

- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller didAuthenticate:(FLOAuthSession*) session
{
    [[FLTwitterMgr instance] didAuthenticateForUserGuid:_userGuid session:session ];

    [_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [_delegate twitterAuthenticator:self didAuthenticateUser:_userGuid];

    [self cleanup];
    mrc_autorelease_(self);
}

- (void) OAuthAuthorizationViewController:(FLOAuthAuthorizationViewController*) controller authenticationDidFail:(NSError*) error
{
// TODO: display error???
    [_delegate twitterAuthenticator:self dismissAuthenticationViewController:controller];
    [_delegate twitterAuthenticator:self didFail:error];

    [self cleanup];
    mrc_autorelease_(self);
}

- (void) webViewControllerUserDidCancel:(FLWebViewController*) controller
{
    [_delegate twitterAuthenticator:self dismissAuthenticationViewController:(FLOAuthAuthorizationViewController*) controller];
    [_delegate twitterAuthenticatorWasCancelled:self];

    [self cleanup];
    mrc_autorelease_(self);
}

- (void) beginAuthenticatingInViewController:(FLViewController*) viewController 
                                    userGuid:(NSString*) userGuid 
                                    delegate:(id<FLTwitterAuthenticatorDelegate>) delegate
{
    FLRetainObject_(_delegate, delegate);
    FLRetainObject_(_userGuid, userGuid);
    FLRetainObject_(_viewController, viewController);
    
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
