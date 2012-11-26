//
//  FLFacebookLoginViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookLoginViewController.h"
#import "FLFacebookMgr.h"
#import "NSString+URL.h"
#import "FLFloatingViewController.h"

@implementation FLFacebookLoginViewController
	
- (id) initWithButtonMode:(FLWebViewControllerButtonMode)buttonMode
{
    if((self = [super initWithButtonMode:buttonMode]))
    {
        self.autoSetTitle = NO;
        self.title = NSLocalizedString(@"Facebook", nil);
        
//        self.openHttpLinksInSafari = YES;
    }
    
    return self;
}

- (id<FLFacebookLoginViewControllerDelegate>) facebookLoginViewControllerDelegate
{
    return (id<FLFacebookLoginViewControllerDelegate>) [super webViewDelegate];
}

- (void) setFacebookLoginViewControllerDelegate:(id<FLFacebookLoginViewControllerDelegate>) delegate
{
    [super setWebViewDelegate:delegate];
}

- (BOOL) shouldNavigateToLink:(NSURL *)url
{
    static NSArray* s_strings = nil;
    if(!s_strings)
    {
        s_strings = [[NSMutableArray alloc] initWithObjects:
            @"www.facebook.com/dialog/oauth",
            @"www.facebook.com/dialog/permissions.request",
            @"m.facebook.com/login.php",
//            @"m.facebook.com/a/language.php",
            nil];
    }

    NSString* urlStr = url.absoluteString;
    FLLog(@"check url: %@", urlStr);
        
    for(NSString* partialUrl in s_strings)
    {
        if([urlStr rangeOfString:partialUrl].length)
        {
            return YES;
        }
    }
    [self openURLInSafari:url];
            
    return NO;
}

- (void) _didFinish:(UIWebView *)webView error:(NSError *)error
{
    mrc_autorelease_(retain_(self));

	if(!error)
	{
		FLFacebookAuthenticationResponse* response = 
			[FLFacebookMgr authenticationResponseFromURL:webView.request.URL outError:&error];			
	
		if(!error && response.session)
		{
            [self.facebookLoginViewControllerDelegate facebookLoginViewControllerDelegate:self didAuthenticate:response.session];
		}
	}
	
	if(error)
	{
		if([webView.request.URL.absoluteString rangeOfString:@"login.php"].length == 0)
		{
            [self.facebookLoginViewControllerDelegate facebookLoginViewControllerDelegate:self didFail:error];
		}
	}
}

- (void) beginLoadingURL:(NSURL*) url delegate:(id<FLFacebookLoginViewControllerDelegate>) delegate
{
    self.facebookLoginViewControllerDelegate = delegate;
	[super beginLoadingURL:url];
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

- (void) beginLoadingURL:(NSURL*) url
{
	[FLWebViewController clearCookiesForDomain:@"facebook"];
	[super beginLoadingURL:url];
}

@end
