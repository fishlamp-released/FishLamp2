//
//  FLOAuthAuthorizationViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLOAuthAuthorizationViewController.h"
#import "FLOAuthRequestTokenNetworkOperation.h"
#import "FLOAuthRequestAccessTokenNetworkOperation.h"
#import "FLUrlParameterParser.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"

#import "FLAction.h"
#import "NSString+URL.h"

@implementation FLOAuthAuthorizationViewController

@synthesize app = m_app;

- (id<FLOAuthAuthorizationViewControllerDelegate>) OAuthAuthorizationViewControllerDelegate
{
    return (id<FLOAuthAuthorizationViewControllerDelegate>) [super webViewDelegate];
}

- (void) setOAuthAuthorizationViewControllerDelegate:(id<FLOAuthAuthorizationViewControllerDelegate>) delegate
{
    [super setWebViewDelegate:delegate];
}

+ (FLOAuthAuthorizationViewController*) OAuthAuthorizationViewController
{
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) dealloc
{
	FLRelease(m_authData);
	FLRelease(m_app);
	FLSuperDealloc();
}

- (void) _didCompleteAction:(FLAction*) action
{
	if(action.didFinishWithoutError)
	{
		m_authData = FLReturnRetained([[action lastOperation] operationOutput]);
		
		NSString* authorizeUrl = [NSString stringWithFormat:@"%@?oauth_token=%@",
			m_app.authorizeUrl,
			m_authData.oauth_token];
			
		[self beginLoadingURL:[NSURL URLWithString:authorizeUrl]];
	}
}

- (void) beginAuthorizingApp:(FLOAuthApp*) app delegate:(id<FLOAuthAuthorizationViewControllerDelegate>) delegate
{
    self.OAuthAuthorizationViewControllerDelegate = delegate;
	self.openLinksInNewViewController = YES;

	FLAssignObject(m_app, app);

	FLAction* action = [FLAction action];
    [action queueOperation:[FLOAuthRequestTokenNetworkOperation OAuthRequestTokenNetworkOperation:app]];
    action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                            presentationBehavior:[FLModalPresentationBehavior instance]];
    action.actionDescription.actionType = FLActionDescriptionTypeAuthenticate;
    action.onFinished = ^(id theAction){ 
        [self _didCompleteAction:theAction]; 
        };
	[self.actionContext beginAction:action];
}

- (void) _didFinishAuthenticating:(FLAction*) action
{
	if(action.didFinishWithoutError)
	{
		FLOAuthSession* session = [[action lastOperation] operationOutput];
		[self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self didAuthenticate:session];
	}
	else
	{
		[self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self authenticationDidFail:action.error];
	}
}

- (void) _didFinish:(UIWebView *)webView error:(NSError *)error
{
}

- (BOOL)webView:(UIWebView *)webView 
	shouldStartLoadWithRequest:(NSURLRequest *)request 
				navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* urlString = request.URL.absoluteString;
	if([urlString rangeOfString:m_app.callback].length > 0)
	{
        if([urlString rangeOfString:@"denied"].length > 0)
        {
            NSError* error = [NSError errorWithDomain:FLOAuthErrorDomain code:FLOAuthErrorCodePermissionDenied userInfo:nil];
            [self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self authenticationDidFail:error];
            return NO;
        }
    
		@try {
            [FLUrlParameterParser parseString:[request.URL query] intoObject:m_authData strict:YES 
                requiredKeys:[NSArray arrayWithObjects:@"oauth_token", @"oauth_verifier", nil]];
        }
        @catch(NSException* ex) {
            [self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self authenticationDidFail:ex.error];
            return NO;
        }

		FLAction* action = [FLAction action];
        [action queueOperation:[FLOAuthRequestAccessTokenNetworkOperation OAuthRequestAccessTokenNetworkOperation:m_app authData:m_authData]];
        
        action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                                presentationBehavior:[FLModalPresentationBehavior instance]];

        action.actionDescription.actionType = FLActionDescriptionTypeAuthenticate;
        action.onFinished = ^(id theAction) { 
            [self _didFinishAuthenticating:theAction]; 
            };
		[self.actionContext beginAction:action];

		return NO;
	}
    
    if(navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        return [self shouldNavigateToLink:request.URL];
    }
	
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[super webView:webView didFailLoadWithError:error];
	[self _didFinish:webView error:error];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[super webViewDidFinishLoad:webView];
	[self _didFinish:webView error:nil];
}

@end
