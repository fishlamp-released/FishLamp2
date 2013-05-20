//
//  GtOAuthAuthorizationViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOAuthAuthorizationViewController.h"
#import "GtOAuthRequestTokenNetworkOperation.h"
#import "GtOAuthRequestAccessTokenNetworkOperation.h"
#import "GtUrlParameterParser.h"

#import "GtAction.h"
#import "NSString+URL.h"

@implementation GtOAuthAuthorizationViewController

@synthesize app = m_app;

- (id<GtOAuthAuthorizationViewControllerDelegate>) OAuthAuthorizationViewControllerDelegate
{
    return (id<GtOAuthAuthorizationViewControllerDelegate>) [super webViewDelegate];
}

- (void) setOAuthAuthorizationViewControllerDelegate:(id<GtOAuthAuthorizationViewControllerDelegate>) delegate
{
    [super setWebViewDelegate:delegate];
}

+ (GtOAuthAuthorizationViewController*) OAuthAuthorizationViewController
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

- (void) dealloc
{
	GtRelease(m_authData);
	GtRelease(m_app);
	GtSuperDealloc();
}

- (void) _didCompleteAction:(GtAction*) action
{
	if(action.didFinishWithoutError)
	{
		m_authData = GtRetain([[action lastOperation] operationOutput]);
		
		NSString* authorizeUrl = [NSString stringWithFormat:@"%@?oauth_token=%@",
			m_app.authorizeUrl,
			m_authData.oauth_token];
			
		[self beginLoadingURL:[NSURL URLWithString:authorizeUrl]];
	}
}

- (void) beginAuthorizingApp:(GtOAuthApp*) app delegate:(id<GtOAuthAuthorizationViewControllerDelegate>) delegate
{
    self.OAuthAuthorizationViewControllerDelegate = delegate;
	self.openLinksInNewViewController = YES;

	GtAssignObject(m_app, app);

	GtAction* action = [GtAction action];
	[self.actionContext beginAction:action configureAction:^(id inAction) {
		[action queueOperation:[GtOAuthRequestTokenNetworkOperation OAuthRequestTokenNetworkOperation:app]];
		action.progressView = [GtProgressViewController progressViewController:[GtOldProgressView defaultModalProgressView]];
		action.actionDescription.actionType = GtActionDescriptionTypeAuthenticate;
		action.didCompleteCallback = ^{ 
            [self _didCompleteAction:action]; 
            };
		}];
}

- (void) _didFinishAuthenticating:(GtAction*) action
{
	if(action.didFinishWithoutError)
	{
		GtOAuthSession* session = [[action lastOperation] operationOutput];
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
            NSError* error = [NSError errorWithDomain:GtOAuthErrorDomain code:GtOAuthErrorCodePermissionDenied userInfo:nil];
            [self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self authenticationDidFail:error];
            return NO;
        }
    
		@try {
            [GtUrlParameterParser parseString:[request.URL query] intoObject:m_authData strict:YES 
                requiredKeys:[NSArray arrayWithObjects:@"oauth_token", @"oauth_verifier", nil]];
        }
        @catch(NSException* ex) {
            [self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self authenticationDidFail:ex.error];
            return NO;
        }

		GtAction* action = [GtAction action];
		[self.actionContext beginAction:action configureAction:^(id inAction) {
			[action queueOperation:[GtOAuthRequestAccessTokenNetworkOperation OAuthRequestAccessTokenNetworkOperation:m_app authData:m_authData]];
			action.progressView = [GtProgressViewController progressViewController:[GtOldProgressView defaultModalProgressView]];
			action.actionDescription.actionType = GtActionDescriptionTypeAuthenticate;
			action.didCompleteCallback = ^{ [self _didFinishAuthenticating:action]; };
			}];

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
