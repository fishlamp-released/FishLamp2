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

@synthesize viewController = _viewController;

+ (FLFacebookAuthenticator*) facebookAuthenticator
{
    return FLReturnAutoreleased([[FLFacebookAuthenticator alloc] init]);
}

- (void) cleanup
{
   FLAutorelease(_viewController);
    _viewController = nil;
    
    FLAutorelease(_delegate);
    _delegate = nil;
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
    
    [action addOperation:operation];

	[self.viewController startAction:action completion:^(id<FLAsyncResult> result){
        if([action didSucceed]) {
            [_delegate facebookAuthenticator:self authenticationDidComplete:[FLFacebookMgr instance].session];
        }
        else {
            [_delegate facebookAuthenticator:self authenticationDidFail:[action error]];
        }
        
        [self cleanup];
        FLAutorelease(self);
    }];
}

- (void) facebookLoginViewControllerDelegate:(FLFacebookLoginViewController*) controller didAuthenticate:(FLFacebookNetworkSession*) session
{
	[_delegate facebookAuthenticator:self dismissAuthenticationViewController:controller];

    [FLFacebookMgr instance].session = session;
    [self _beginLoadingUser];
}

- (void) facebookLoginViewControllerDelegate:(FLFacebookLoginViewController*) controller didFail:(NSError*) error
{
	[_delegate facebookAuthenticator:self dismissAuthenticationViewController:controller];
    [_delegate facebookAuthenticator:self authenticationDidFail:error];

    [self cleanup];
    FLAutorelease(self);
}

- (void) webViewControllerUserDidCancel:(FLWebViewController*) controller
{
	[_delegate facebookAuthenticator:self dismissAuthenticationViewController:(FLFacebookLoginViewController*) controller];
    [_delegate facebookAuthenticatorWasCancelled:self];

    [self cleanup];
    FLAutorelease(self);
}

- (void) _didCompleteFacebookAction:(FLAction*) action 
{
	if(action.didSucceed)
	{
		FLFacebookAuthenticationResponse* response = [[action lastOperation] operationOutput];
		if(response.session)
		{
			[FLFacebookMgr instance].session = response.session;
			[_delegate facebookAuthenticator:self authenticationDidComplete:response.session]; 
            [self cleanup];
            FLAutorelease(self);
		}
		else if(response.redirectURL)
		{
			FLFacebookLoginViewController* controller = [FLFacebookLoginViewController webViewController:FLWebViewControllerButtonModeCanCancel | 
                (DeviceIsPad() ? FLWebViewControllerButtonModeNavigationButtonsOnTop : FLWebViewControllerButtonModeNavigationButtonsOnBottom) ];

			[_delegate facebookAuthenticator:self presentAuthenticationViewController:controller];
            
            [controller beginLoadingURL:[FLFacebookMgr buildOAuthUrl:[FLFacebookMgr instance].permissions forAppId:[FLFacebookMgr instance].appId] delegate:self];
        }
		
	}
	else
	{
        [_delegate facebookAuthenticator:self authenticationDidFail:action.error];
	    [self cleanup];
        FLAutorelease(self);
    }
}

- (void) beginAuthenticatingInViewController:(FLViewController*) viewController  delegate:(id<FLFacebookAuthenticatorDelegate>) delegate
{
    FLAssignObject(_delegate, delegate);
    FLAssignObject(_viewController, viewController);
    
	if([[FLFacebookMgr instance] appNeedsAuthorizationForPermissions:[FLFacebookMgr instance].permissions])
	{
        FLRetain(self);
        FLAction* action = [FLAction action];
        [action addOperation:[FLFacebookBeginAuthorizationOperation facebookBeginAuthorizationOperation:[FLFacebookMgr instance].permissions]];
        [action setProgressController:[FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                                  presentationBehavior:[FLModalPresentationBehavior instance]]];

        [action actionDescription].actionType = FLActionDescriptionTypeAuthenticate;
		[viewController startAction:action completion: ^(id<FLAsyncResult> result) {
            [self _didCompleteFacebookAction:action];
            }];
    }
	else
	{
        [delegate facebookAuthenticator:self authenticationDidComplete:[FLFacebookMgr instance].session];
	}
}


@end
