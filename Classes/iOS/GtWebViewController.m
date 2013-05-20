//
//	GtWebViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtWebViewController.h"
#import "GtUserNotificationView.h"
#import "UIView+GtViewAutoLayout.h"
#import "GtGradientButton.h"
#import "UIImage+GtColorize.h"

#if 0
#define TRACE DEBUG
#endif

@implementation GtWebViewController

@synthesize webView= m_webView;

GtSynthesizeStructProperty(openHttpLinksInSafari, setOpenHttpLinksInSafari, BOOL, m_webViewFlags);
GtSynthesizeStructProperty(openLinksInNewViewController, setOpenLinksInNewViewController, BOOL, m_webViewFlags);
GtSynthesizeStructProperty(buttonMode, setButtonMode, GtWebViewControllerButtonMode, m_webViewFlags);
GtSynthesizeStructProperty(autoSetTitle, setAutoSetTitle, BOOL, m_webViewFlags);

@synthesize actionButton = m_actionButton;
@synthesize bottomToolbar = m_bottomToolbar;
@synthesize startURL = m_startURL;
@synthesize webViewDelegate = m_delegate;

GtAssertDefaultInitNotCalled()

- (id) initWithButtonMode:(GtWebViewControllerButtonMode) buttonMode
{
	if((self = [super initWithNibName:nil bundle:nil]))
	{
        self.autoSetTitle = YES;
        m_webViewFlags.buttonMode = buttonMode;
		self.wantsFullScreenLayout = YES;

        [self createActionContext];
    }

	return self;
}

+ (id) webViewController:(GtWebViewControllerButtonMode) buttonMode
{
    return GtReturnAutoreleased([[[self class] alloc] initWithButtonMode:buttonMode]);
}

- (void) loadView
{
	if(GtStringIsNotEmpty(self.nibName))
	{
		[super loadView];
	}
	else
	{
		UIView* parentView = GtReturnAutoreleased([[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)]);
		parentView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		parentView.autoresizesSubviews = YES;
		parentView.backgroundColor = [UIColor whiteColor];
	
		m_webView = [[UIWebView alloc] initWithFrame:parentView.bounds];		
		m_webView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		m_webView.autoresizesSubviews = YES;
		m_webView.delegate = self;
		
		[parentView addSubview:m_webView];
	
		self.view = parentView;
	}
}

- (void) willBePushedOnNavigationController:(UINavigationController *)controller
{
    self.view.frame = controller.view.bounds;
    [super willBePushedOnNavigationController:controller];
}

- (void) updateButtonStates
{
    if(GtBitMaskTest(self.buttonMode, GtWebViewControllerButtonModeNavigationButtonsOnTop))
    {
        [self.buttonbar setViewEnabled:m_webView.canGoBack forKey:@"back"];
        [self.buttonbar setViewEnabled:m_webView.canGoForward forKey:@"forward"];
        [self.buttonbar setViewEnabled:!m_webView.loading forKey:@"reload"];
    }
    else if(GtBitMaskTest(self.buttonMode, GtWebViewControllerButtonModeNavigationButtonsOnBottom))
    {
        m_backButton.enabled = m_webView.canGoBack;
        m_forwardButton.enabled = m_webView.canGoForward;
        m_reloadButton.enabled = !m_webView.loading;
        m_actionButton.enabled = !m_webView.loading;
    }
}

- (GtViewContentsDescriptor) describeViewContents
{
	return GtViewContentsDescriptorMake(DeviceIsPad() ? 
		GtViewContentItemToolbar : GtViewContentItemToolbarAndStatusBar, GtViewContentItemToolbar);
}

- (void) cleanupWebViewController
{
	GtReleaseWithNil(m_bottomToolbar);
	GtReleaseWithNil(m_reloadButton);
	GtReleaseWithNil(m_backButton);
	GtReleaseWithNil(m_forwardButton);
    m_webView.delegate = nil;
	[m_webView stopLoading];
    GtReleaseWithNil(m_webView);
	GtReleaseWithNil(m_spinner);
	GtReleaseWithNil(m_actionButton);
}

- (void) removeActionButton
{
	NSMutableArray* items = GtReturnAutoreleased([[m_bottomToolbar items] mutableCopy]);
	[items removeObject:m_actionButton];
	m_bottomToolbar.items = items;
}

- (void) dealloc
{
	GtRelease(m_startURL);
    GtRelease(m_anchor);
	[self cleanupWebViewController];
	GtSuperDealloc();
}

- (BOOL) openURLInSafari:(NSURL*) url
{
    return [[UIApplication sharedApplication] openUrlInSafari:url errorMessage:
        NSLocalizedString(@"There may be a problem with the URL or access to Safari may be restricted", nil)];
}

- (BOOL) _openURLInSafariIfNeeded:(NSURL*) url
{
	if(self.openHttpLinksInSafari && [url.scheme rangeOfString:@"http"].length > 0)
	{
        return [self openURLInSafari:url];
	}
	
	return NO;
}

- (BOOL) shouldNavigateToLink:(NSURL*) url
{
    if([self _openURLInSafariIfNeeded:url])
    {
        return NO;
    }
	
    return YES;
}

- (BOOL)webView:(UIWebView *)webView 
	shouldStartLoadWithRequest:(NSURLRequest *)request 
	navigationType:(UIWebViewNavigationType)navigationType
{
#if TRACE
    GtLog(@"requesting load with URL: %@, nav type: %d", request.URL, navigationType);
#endif    

    BOOL outValue = YES;
	switch(navigationType)
	{
        case UIWebViewNavigationTypeFormSubmitted:
        case UIWebViewNavigationTypeFormResubmitted:
        case UIWebViewNavigationTypeReload:
        case UIWebViewNavigationTypeBackForward:
        case UIWebViewNavigationTypeOther:
            break;

		case UIWebViewNavigationTypeLinkClicked:
		{
			outValue = [self shouldNavigateToLink:request.URL];
            if(outValue && self.openLinksInNewViewController)
            {
                GtWebViewController* controller = GtReturnAutoreleased([[[self class] alloc] initWithButtonMode:self.buttonMode]);
                controller.openLinksInNewViewController = self.openLinksInNewViewController;
                controller.openHttpLinksInSafari = self.openHttpLinksInSafari;
                controller.autoSetTitle = YES; // TODO: no other way, maybe have delegate set this?
                
                [self.navigationController pushViewController:controller animated:YES];
                [controller beginLoadingURL:request.URL];
                outValue = NO;
            }
			break;
		}
	}
	
	[self updateButtonStates];
	return outValue;
}

- (void) stopSpinner
{
	if(m_spinner)
	{
		GtReleaseWithNil(m_spinner);
	}
}

- (void) startSpinner
{
	[self stopSpinner];
	
	m_spinner = [[GtProgressViewOwner alloc] initWithProgressView:[GtOldProgressView defaultProgressView]];
	[m_spinner.progressView setTitle:NSLocalizedString(@"Loading...", nil)];
#if VIEW_AUTOLAYOUT
	[m_spinner.progressView setAutoLayoutMode:GtRectLayoutCentered];
#endif    
	[m_spinner.progressView setProgressViewAlpha:0.8];
	[m_spinner.progressView showProgressInSuperview:self.webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[self startSpinner];
	[self updateButtonStates];
	
//	[self startHeartbeat];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self stopSpinner];
	[self updateButtonStates];
	
    if(self.autoSetTitle)
    {
        self.title = [m_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
	self.backButtonTitle = NSLocalizedString(@"Back", nil);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[self stopSpinner];
	[self updateButtonStates];
	
	GtUserNotificationView* alert = [[GtUserNotificationView alloc] initAsErrorNotification];
	alert.title = NSLocalizedString(@"Unable to load URL.", nil);
	if(error.isNotConnectedToInternetError)
	{
		alert.text = NSLocalizedString(@"Please try again when you have a network connection.", nil);
	}
	else
	{
		[alert setTextWithError:error];
	}
	[self.view addSubview:alert];
	GtReleaseWithNil(alert);
}

- (IBAction) buttonClickBack:(id) sender
{
	[m_webView goBack];
}
- (IBAction) buttonClickForward:(id) sender
{
	[m_webView goForward];
}
- (IBAction) buttonClickReload:(id) sender
{
	[m_webView reload];
}

- (NSString*) currentLocationUrl
{
	return [m_webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}

- (BOOL) openInSafari
{
    return [self openURLInSafari:[NSURL URLWithString:self.currentLocationUrl]];
}

- (NSMutableURLRequest*) createURLRequestForURL:(NSURL*) url
{
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
	
	return request;
}

- (void) beginLoadingURL:(NSURL*) url
{
	if(![self _openURLInSafariIfNeeded:url])
	{
		GtAssignObject(m_startURL, url);
	
		[m_webView loadRequest:[self createURLRequestForURL:url]];
	}
}

- (void) userDidCancel:(id) sender
{
    [m_delegate webViewControllerUserDidCancel:self];
}

- (void) viewDidUnload
{
	[self cleanupWebViewController];
    
    [super viewDidUnload];
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	self.webView.backgroundColor = [UIColor clearColor];
	self.webView.opaque = NO;	
	if(GtBitMaskTest(self.buttonMode, GtWebViewControllerButtonModeNavigationButtonsOnTop))
	{
		[self.buttonbar addViewToLeftSide:[GtButtonbarView createImageButtonByName:@"back.png" target:self action:@selector(buttonClickBack:)]  forKey:@"back" animated:NO]; 

		[self.buttonbar addViewToLeftSide:[GtButtonbarView createImageButtonByName:@"forward.png" target:self action:@selector(buttonClickForward:)]  forKey:@"forward" animated:NO]; 
			
		[self.buttonbar addViewToRightSide:[GtButtonbarView createImageButtonByName:@"reload.png" target:self action:@selector(buttonClickReload:)]  forKey:@"reload" animated:NO]; 
	}
    else if(GtBitMaskTest(self.buttonMode, GtWebViewControllerButtonModeNavigationButtonsOnBottom))
    {
        m_bottomToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,GtRectGetBottom(self.view.bounds)-44,self.view.bounds.size.width,44)];
        m_bottomToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        m_bottomToolbar.barStyle = UIBarStyleBlack;
        m_bottomToolbar.translucent = NO;
        
        m_backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage whiteImageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClickBack:)];
        m_forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage whiteImageNamed:@"forward.png"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClickForward:)];
        m_reloadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage whiteImageNamed:@"reload.png"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClickReload:)];
        
        m_bottomToolbar.items = [NSArray arrayWithObjects:
            m_backButton,
            [UIBarButtonItem fixedSpaceBarButtonItem:40],
            m_forwardButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            m_reloadButton,
            nil];
            
        [self.view addSubview:m_bottomToolbar];
    }
    if(GtBitMaskTest(self.buttonMode, GtWebViewControllerButtonModeCanCancel))
    {
        [self.buttonbar addButtonToRightSide:[GtToolbarButton toolbarButton:NSLocalizedString(@"Cancel", nil) target:self action:@selector(userDidCancel:)] forKey:@"cancel" animated:NO]; 
    }
	[self updateButtonStates];
}

- (void) adjustFrames
{
	if(self.navigationController)
	{
		CGRect navBarRect = self.navigationController.navigationBar.frame;

		if(m_bottomToolbar && m_bottomToolbar.hidden == NO)
		{
			CGRect toolbarRect = m_bottomToolbar.frame;
			
			CGRect newRect = self.view.bounds;
			newRect.origin.y = GtRectGetBottom(navBarRect);
			newRect.size.height = toolbarRect.origin.y - newRect.origin.y;
			self.webView.frame = newRect;
		}
		else
		{
			CGRect newRect = self.view.bounds;
			newRect.origin.y = GtRectGetBottom(navBarRect);
			newRect.size.height = GtRectGetBottom(self.view.bounds) - newRect.origin.y;
			self.webView.frame = newRect;
		}
	}
}

- (void) wasPushedOnNavigationController:(UINavigationController *)controller
{
	[super wasPushedOnNavigationController:controller];
	
	[self adjustFrames];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self adjustFrames];
}

+ (void) clearCookiesForDomain:(NSString*) domain
{
	NSMutableArray* deleteThese = [NSMutableArray array];
	for (NSHTTPCookie * cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) 
	{
		if([cookie.domain rangeOfString:domain].length > 0)
		{
			[deleteThese addObject:cookie];
		}
	}
	for (NSHTTPCookie * cookie in deleteThese) 
	{
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}
#if TRACE    
	for (NSHTTPCookie * cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) 
	{
		GtLog([cookie description]);
	}
#endif    
	
}



@end
