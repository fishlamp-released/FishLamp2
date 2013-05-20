//
//  GtFacebookLoginViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookLoginViewController.h"
#import "GtFacebookMgr.h"
#import "NSString+URL.h"
#import "GtHoverViewController.h"

@implementation GtFacebookLoginViewController
	
- (id) initWithButtonMode:(GtWebViewControllerButtonMode)buttonMode
{
    if((self = [super initWithButtonMode:buttonMode]))
    {
        self.autoSetTitle = NO;
        self.title = NSLocalizedString(@"Facebook", nil);
        
//        self.openHttpLinksInSafari = YES;
    }
    
    return self;
}

- (id<GtFacebookLoginViewControllerDelegate>) facebookLoginViewControllerDelegate
{
    return (id<GtFacebookLoginViewControllerDelegate>) [super webViewDelegate];
}

- (void) setFacebookLoginViewControllerDelegate:(id<GtFacebookLoginViewControllerDelegate>) delegate
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
    GtLog(@"check url: %@", urlStr);
        
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
    GtReturnAutoreleased(GtRetain(self));

	if(!error)
	{
		GtFacebookAuthenticationResponse* response = 
			[GtFacebookMgr authenticationResponseFromURL:webView.request.URL outError:&error];			
	
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

- (void) beginLoadingURL:(NSURL*) url delegate:(id<GtFacebookLoginViewControllerDelegate>) delegate
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
	[GtWebViewController clearCookiesForDomain:@"facebook"];
	[super beginLoadingURL:url];
}

@end
