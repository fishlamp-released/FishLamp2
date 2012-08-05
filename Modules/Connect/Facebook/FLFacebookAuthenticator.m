//
//  FLFacebookAuthenticator.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/10/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookAuthenticator.h"
#import "FLAction.h"
#import "FLFacebookLoginViewController.h"
#import "FLNavigationControllerViewController.h"
#import "FLFacebookLoadUserOperation.h"
#import "FLFacebookBeginAuthorizationOperation.h"
#import "FLFloatingViewController.h"
#import "FLOperationCacheHandler.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#import "FLUserSession.h"

@implementation FLFacebookAuthenticator

@synthesize viewController = m_viewController;

+ (FLFacebookAuthenticator*) facebookAuthenticator
{
    return FLReturnAutoreleased([[FLFacebookAuthenticator alloc] init]);
}

- (void) cleanup
{
   FLAutorelease(m_viewController);
    m_viewController = nil;
    
    FLAutorelease(m_delegate);
    m_delegate = nil;
}

- (void) dealloc
{
    [self cleanup];
    FLSuperDealloc();
}

- (void) _beginLoadingUser
{
    FLAction* action = [FLAction actionWithActionType:FLActionDescriptionTypeAuthenticate] ;

    action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                            presentationBehavior:[FLModalPresentationBehavior instance]];

    FLFacebookLoadUserOperation* operation = [FLFacebookLoadUserOperation facebookOperation];
    [operation setUserId:@"me"];

    FLOperationCacheHandler* cacheHandler = 
        [FLOperationCacheHandler operationCacheHandler:[FLUserSession instance].cacheDatabase 
                                              behavior:FLHttpOperationCacheBehaviorAll];
    
    [cacheHandler setOnSaveToCache:^(FLOperationCacheHandler* theHandler, id theOperation){
            [theHandler saveOperationOutputToCache:theOperation];
            FLFacebookUser* user = [theOperation operationOutput];
            FLFacebookNetworkSession* session = [FLFacebookMgr instance].session;
            session.userId = user.id;
            [FLFacebookMgr instance].session = session;
        }];
              
    [operation addObserver:cacheHandler];
    
    [action queueOperation:operation];

    [action setOnFinished:^(id theAction) {
    
        if([theAction didFinishWithoutError])
        {
            [m_delegate facebookAuthenticator:self authenticationDidComplete:[FLFacebookMgr instance].session];
        }
        else
        {
        
            [m_delegate facebookAuthenticator:self authenticationDidFail:[theAction error]];
        }
        
        [self cleanup];
        FLAutorelease(self);
    }];    
    
	[self.viewController.actionContext beginAction:action];
}

- (void) facebookLoginViewControllerDelegate:(FLFacebookLoginViewController*) controller didAuthenticate:(FLFacebookNetworkSession*) session
{
	[m_delegate facebookAuthenticator:self dismissAuthenticationViewController:controller];

    [FLFacebookMgr instance].session = session;
    [self _beginLoadingUser];
}

- (void) facebookLoginViewControllerDelegate:(FLFacebookLoginViewController*) controller didFail:(NSError*) error
{
	[m_delegate facebookAuthenticator:self dismissAuthenticationViewController:controller];
    [m_delegate facebookAuthenticator:self authenticationDidFail:error];

    [self cleanup];
    FLAutorelease(self);
}

- (void) webViewControllerUserDidCancel:(FLWebViewController*) controller
{
	[m_delegate facebookAuthenticator:self dismissAuthenticationViewController:(FLFacebookLoginViewController*) controller];
    [m_delegate facebookAuthenticatorWasCancelled:self];

    [self cleanup];
    FLAutorelease(self);
}

- (void) _didCompleteFacebookAction:(FLAction*) action 
{
	if(action.didFinishWithoutError)
	{
		FLFacebookAuthenticationResponse* response = [[action lastOperation] operationOutput];
		if(response.session)
		{
			[FLFacebookMgr instance].session = response.session;
			[m_delegate facebookAuthenticator:self authenticationDidComplete:response.session]; 
            [self cleanup];
            FLAutorelease(self);
		}
		else if(response.redirectURL)
		{
			FLFacebookLoginViewController* controller = [FLFacebookLoginViewController webViewController:FLWebViewControllerButtonModeCanCancel | 
                (DeviceIsPad() ? FLWebViewControllerButtonModeNavigationButtonsOnTop : FLWebViewControllerButtonModeNavigationButtonsOnBottom) ];

			[m_delegate facebookAuthenticator:self presentAuthenticationViewController:controller];
            
            [controller beginLoadingURL:[FLFacebookMgr buildOAuthUrl:[FLFacebookMgr instance].permissions forAppId:[FLFacebookMgr instance].appId] delegate:self];
        }
		
	}
	else
	{
        [m_delegate facebookAuthenticator:self authenticationDidFail:action.error];
	    [self cleanup];
        FLAutorelease(self);
    }
}

- (void) beginAuthenticatingInViewController:(FLViewController*) viewController  delegate:(id<FLFacebookAuthenticatorDelegate>) delegate
{
    FLAssignObject(m_delegate, delegate);
    FLAssignObject(m_viewController, viewController);
    
	if([[FLFacebookMgr instance] appNeedsAuthorizationForPermissions:[FLFacebookMgr instance].permissions])
	{
        FLRetain(self);
        FLAction* action = [FLAction action];
        [action queueOperation:[FLFacebookBeginAuthorizationOperation facebookBeginAuthorizationOperation:[FLFacebookMgr instance].permissions]];
        [action setProgressController:[FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                                  presentationBehavior:[FLModalPresentationBehavior instance]]];

        [action actionDescription].actionType = FLActionDescriptionTypeAuthenticate;
        [action setOnFinished: ^(id theAction) { 
            [self _didCompleteFacebookAction:theAction]; 
            }];
    
		[viewController.actionContext beginAction:action];
    }
	else
	{
        [delegate facebookAuthenticator:self authenticationDidComplete:[FLFacebookMgr instance].session];
	}
}


@end
