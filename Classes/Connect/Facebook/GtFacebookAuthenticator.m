//
//  GtFacebookAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookAuthenticator.h"
#import "GtAction.h"
#import "GtOldProgressView.h"
#import "GtFacebookLoginViewController.h"
#import "GtNavigationControllerViewController.h"
#import "GtFacebookLoadUserOperation.h"
#import "GtFacebookBeginAuthorizationOperation.h"
#import "GtHoverViewController.h"

@implementation GtFacebookAuthenticator

@synthesize viewController = m_viewController;

+ (GtFacebookAuthenticator*) facebookAuthenticator
{
    return GtReturnAutoreleased([[GtFacebookAuthenticator alloc] init]);
}

- (void) cleanup
{
   GtAutorelease(m_viewController);
    m_viewController = nil;
    
    GtAutorelease(m_delegate);
    m_delegate = nil;
}

- (void) dealloc
{
    [self cleanup];
    GtSuperDealloc();
}

- (void) _beginLoadingUser
{
	[self.viewController.actionContext beginAction:[GtAction actionWithActionType:GtActionDescriptionTypeAuthenticate] configureAction:^(id action) {
		[action setProgressView:[GtOldProgressView defaultModalProgressView]];
		[action queueOperation:[GtFacebookLoadUserOperation facebookOperation] configureOperation:^(id operation)
            {
                [operation setUserId:@"me"];
                
                [operation setSaveToCacheCallback:^{
                    [operation saveToCache];
                    GtFacebookUser* user = [operation operationOutput];
                    
                    GtFacebookNetworkSession* session = [GtFacebookMgr instance].session;
                    session.userId = user.id;
                    [GtFacebookMgr instance].session = session;
                }];
            
            }];

		[action setDidCompleteCallback:^{
        
            if([action didFinishWithoutError])
            {
                [m_delegate facebookAuthenticator:self authenticationDidComplete:[GtFacebookMgr instance].session];
            }
            else
            {
            
                [m_delegate facebookAuthenticator:self authenticationDidFail:[action error]];
            }
            
            [self cleanup];
            GtAutorelease(self);
        }];
	}];
}


- (void) facebookLoginViewControllerDelegate:(GtFacebookLoginViewController*) controller didAuthenticate:(GtFacebookNetworkSession*) session
{
	[m_delegate facebookAuthenticator:self dismissAuthenticationViewController:controller];

    [GtFacebookMgr instance].session = session;
    [self _beginLoadingUser];
}

- (void) facebookLoginViewControllerDelegate:(GtFacebookLoginViewController*) controller didFail:(NSError*) error
{
	[m_delegate facebookAuthenticator:self dismissAuthenticationViewController:controller];
    [m_delegate facebookAuthenticator:self authenticationDidFail:error];

    [self cleanup];
    GtAutorelease(self);
}

- (void) webViewControllerUserDidCancel:(GtWebViewController*) controller
{
	[m_delegate facebookAuthenticator:self dismissAuthenticationViewController:(GtFacebookLoginViewController*) controller];
    [m_delegate facebookAuthenticatorWasCancelled:self];

    [self cleanup];
    GtAutorelease(self);
}

- (void) _didCompleteFacebookAction:(GtAction*) action 
{
	if(action.didFinishWithoutError)
	{
		GtFacebookAuthenticationResponse* response = [[action lastOperation] operationOutput];
		if(response.session)
		{
			[GtFacebookMgr instance].session = response.session;
			[m_delegate facebookAuthenticator:self authenticationDidComplete:response.session]; 
            [self cleanup];
            GtAutorelease(self);
		}
		else if(response.redirectURL)
		{
			GtFacebookLoginViewController* controller = [GtFacebookLoginViewController webViewController:GtWebViewControllerButtonModeCanCancel | 
                (DeviceIsPad() ? GtWebViewControllerButtonModeNavigationButtonsOnTop : GtWebViewControllerButtonModeNavigationButtonsOnBottom) ];

			[m_delegate facebookAuthenticator:self presentAuthenticationViewController:controller];
            
            [controller beginLoadingURL:[GtFacebookMgr buildOAuthUrl:[GtFacebookMgr instance].permissions forAppId:[GtFacebookMgr instance].appId] delegate:self];
        }
		
	}
	else
	{
        [m_delegate facebookAuthenticator:self authenticationDidFail:action.error];
	    [self cleanup];
        GtAutorelease(self);
    }
}

- (void) beginAuthenticatingInViewController:(GtViewController*) viewController  delegate:(id<GtFacebookAuthenticatorDelegate>) delegate
{
    GtAssignObject(m_delegate, delegate);
    GtAssignObject(m_viewController, viewController);
    
	if([[GtFacebookMgr instance] appNeedsAuthorizationForPermissions:[GtFacebookMgr instance].permissions])
	{
        GtRetain(self);
    
		[viewController.actionContext beginAction:[GtAction action] configureAction:^(id action) {
			[action queueOperation:[GtFacebookBeginAuthorizationOperation facebookBeginAuthorizationOperation:[GtFacebookMgr instance].permissions]];
			[action setProgressView:[GtOldProgressView defaultModalProgressView]];
			[action actionDescription].actionType = GtActionDescriptionTypeAuthenticate;
			[action setDidCompleteCallback: ^{ 
				[self _didCompleteFacebookAction:action]; }];
			}];
	}
	else
	{
        [delegate facebookAuthenticator:self authenticationDidComplete:[GtFacebookMgr instance].session];
	}
}


@end
