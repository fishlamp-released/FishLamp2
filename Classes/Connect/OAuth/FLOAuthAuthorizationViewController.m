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

@synthesize app = _app;

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
	return autorelease_([[[self class] alloc] init]);
}

- (void) dealloc
{
	release_(_authData);
	release_(_app);
	super_dealloc_();
}

- (void) _didCompleteAction:(FLAction*) action
{
	if(action.didSucceed)
	{
		_authData = retain_([[action lastOperation] operationOutput]);
		
		NSString* authorizeUrl = [NSString stringWithFormat:@"%@?oauth_token=%@",
			_app.authorizeUrl,
			_authData.oauth_token];
			
		[self beginLoadingURL:[NSURL URLWithString:authorizeUrl]];
	}
}

- (void) beginAuthorizingApp:(FLOAuthApp*) app delegate:(id<FLOAuthAuthorizationViewControllerDelegate>) delegate
{
    self.OAuthAuthorizationViewControllerDelegate = delegate;
	self.openLinksInNewViewController = YES;

	FLRetainObject_(_app, app);

	FLAction* action = [FLAction action];
    [action addOperation:[FLOAuthRequestTokenNetworkOperation OAuthRequestTokenNetworkOperation:app]];
    action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                            presentationBehavior:[FLModalPresentationBehavior instance]];
    action.actionDescription.actionType = FLActionDescriptionTypeAuthenticate;
	[self startAction:action completion: ^(FLResult result) {
        [self _didCompleteAction:action];
        }];
}

- (void) _didFinishAuthenticating:(FLAction*) action
{
	if(action.didSucceed)
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
	if([urlString rangeOfString:_app.callback].length > 0)
	{
        if([urlString rangeOfString:@"denied"].length > 0)
        {
            NSError* error = [NSError errorWithDomain:FLOAuthErrorDomain code:FLOAuthErrorCodePermissionDenied userInfo:nil];
            [self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self authenticationDidFail:error];
            return NO;
        }
    
		@try {
            [FLUrlParameterParser parseString:[request.URL query] intoObject:_authData strict:YES 
                requiredKeys:[NSArray arrayWithObjects:@"oauth_token", @"oauth_verifier", nil]];
        }
        @catch(NSException* ex) {
            [self.OAuthAuthorizationViewControllerDelegate OAuthAuthorizationViewController:self authenticationDidFail:ex.error];
            return NO;
        }

		FLAction* action = [FLAction action];
        [action addOperation:[FLOAuthRequestAccessTokenNetworkOperation OAuthRequestAccessTokenNetworkOperation:_app authData:_authData]];
        
        action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                                presentationBehavior:[FLModalPresentationBehavior instance]];
        action.actionDescription.actionType = FLActionDescriptionTypeAuthenticate;

		[self  startAction:action completion: ^(FLResult result) {
            [self _didFinishAuthenticating:action]; 
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
