//
//	FLWebViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/18/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWebViewController.h"
#import "FLOldUserNotificationView.h"
#import "FLGradientButton.h"
#import "UIImage+Colorize.h"
#import "FLSimpleProgressView.h"

#if 0
#define TRACE DEBUG
#endif

@implementation FLWebViewController

@synthesize webView= _webView;

FLSynthesizeStructProperty(openHttpLinksInSafari, setOpenHttpLinksInSafari, BOOL, _webViewFlags);
FLSynthesizeStructProperty(openLinksInNewViewController, setOpenLinksInNewViewController, BOOL, _webViewFlags);
FLSynthesizeStructProperty(buttonMode, setButtonMode, FLWebViewControllerButtonMode, _webViewFlags);
FLSynthesizeStructProperty(autoSetTitle, setAutoSetTitle, BOOL, _webViewFlags);

@synthesize actionButton = _actionButton;
@synthesize bottomToolbar = _bottomToolbar;
@synthesize startURL = _startURL;
@synthesize webViewDelegate = _delegate;

FLAssertDefaultInitNotCalled()

- (id) initWithButtonMode:(FLWebViewControllerButtonMode) buttonMode {
	if((self = [super initWithNibName:nil bundle:nil])) {
        self.autoSetTitle = YES;
        _webViewFlags.buttonMode = buttonMode;
		self.wantsFullScreenLayout = YES;
    }

	return self;
}

+ (id) webViewController:(FLWebViewControllerButtonMode) buttonMode
{
    return FLAutorelease([[[self class] alloc] initWithButtonMode:buttonMode]);
}

- (void) loadView
{
	if(FLStringIsNotEmpty(self.nibName))
	{
		[super loadView];
	}
	else
	{
		UIView* parentView = FLAutorelease([[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)]);
		parentView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		parentView.autoresizesSubviews = YES;
		parentView.backgroundColor = [UIColor whiteColor];
	
		_webView = [[UIWebView alloc] initWithFrame:parentView.bounds];		
		_webView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		_webView.autoresizesSubviews = YES;
		_webView.delegate = self;
		
		[parentView addSubview:_webView];
	
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
    if(FLTestBits(self.buttonMode, FLWebViewControllerButtonModeNavigationButtonsOnTop))
    {
        [self.buttonbar setViewEnabled:_webView.canGoBack forKey:@"back"];
        [self.buttonbar setViewEnabled:_webView.canGoForward forKey:@"forward"];
        [self.buttonbar setViewEnabled:!_webView.loading forKey:@"reload"];
    }
    else if(FLTestBits(self.buttonMode, FLWebViewControllerButtonModeNavigationButtonsOnBottom))
    {
        _backButton.enabled = _webView.canGoBack;
        _forwardButton.enabled = _webView.canGoForward;
        _reloadButton.enabled = !_webView.loading;
        _actionButton.enabled = !_webView.loading;
    }
}

//- (void) describeViewContents:(FLMutableViewContentsDescriptor*) descriptor
//{
//    if(DeviceIsPad())
//    {
//        descriptor.hasStatusBar = NO;
//    }
//}

- (void) cleanupWebViewController
{
	FLReleaseWithNil(_bottomToolbar);
	FLReleaseWithNil(_reloadButton);
	FLReleaseWithNil(_backButton);
	FLReleaseWithNil(_forwardButton);
    _webView.delegate = nil;
	[_webView stopLoading];
    if(_progress)
    {
        [_progress hideProgress];
        FLReleaseWithNil(_webView);
    }
	FLReleaseWithNil(_progress);
	FLReleaseWithNil(_actionButton);
}

- (void) removeActionButton
{
	NSMutableArray* items = FLAutorelease([[_bottomToolbar items] mutableCopy]);
	[items removeObject:_actionButton];
	_bottomToolbar.items = items;
}

- (void) dealloc {
	FLRelease(_startURL);
	[self cleanupWebViewController];
	FLSuperDealloc();
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
    FLLog(@"requesting load with URL: %@, nav type: %d", request.URL, navigationType);
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
                FLWebViewController* controller = FLAutorelease([[[self class] alloc] initWithButtonMode:self.buttonMode]);
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
	if(_progress)
	{
        [_progress hideProgress];
		FLReleaseWithNil(_progress);
	}
}

- (void) startSpinner
{
	[self stopSpinner];
	
	_progress = [[FLProgressViewController alloc] initWithProgressViewClass:[FLSimpleProgressView class]];
	[_progress setTitle:NSLocalizedString(@"Loading...", nil)];
	[_progress setContentMode:FLRectLayoutCentered];
//	[_progress.progressView setProgressViewAlpha:0.8];
    [self showChildViewController:_progress];
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
        self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
	self.backButtonTitle = NSLocalizedString(@"Back", nil);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[self stopSpinner];
	[self updateButtonStates];

// TODO: fix this
	
//	FLOldUserNotificationView* alert = [[FLOldUserNotificationView alloc] initAsErrorNotification];
//	alert.title = NSLocalizedString(@"Unable to load URL.", nil);
//	if(error.isNotConnectedToInternetError)
//	{
//		alert.text = NSLocalizedString(@"Please try again when you have a network connection.", nil);
//	}
//	else
//	{
//		[alert setTextWithError:error];
//	}
//	[self.view addSubview:alert];
//	FLReleaseWithNil(alert);
}

- (IBAction) buttonClickBack:(id) sender
{
	[_webView goBack];
}
- (IBAction) buttonClickForward:(id) sender
{
	[_webView goForward];
}
- (IBAction) buttonClickReload:(id) sender
{
	[_webView reload];
}

- (NSString*) currentLocationUrl
{
	return [_webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
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
		FLSetObjectWithRetain(_startURL, url);
	
		[_webView loadRequest:[self createURLRequestForURL:url]];
	}
}

- (void) userDidCancel:(id) sender
{
    [_delegate webViewControllerUserDidCancel:self];
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
	if(FLTestBits(self.buttonMode, FLWebViewControllerButtonModeNavigationButtonsOnTop))
	{
		[self.buttonbar addViewToLeftSide:[FLDeprecatedButtonbarView createImageButtonByName:@"back.png" imageColor:FLImageColorBlack target:self action:@selector(buttonClickBack:)]  forKey:@"back" animated:NO]; 

		[self.buttonbar addViewToLeftSide:[FLDeprecatedButtonbarView createImageButtonByName:@"forward.png" imageColor:FLImageColorBlack target:self action:@selector(buttonClickForward:)]  forKey:@"forward" animated:NO]; 
			
		[self.buttonbar addViewToRightSide:[FLDeprecatedButtonbarView createImageButtonByName:@"reload.png" imageColor:FLImageColorBlack target:self action:@selector(buttonClickReload:)]  forKey:@"reload" animated:NO]; 
	}
    else if(FLTestBits(self.buttonMode, FLWebViewControllerButtonModeNavigationButtonsOnBottom))
    {
        _bottomToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,FLRectGetBottom(self.view.bounds)-44,self.view.bounds.size.width,44)];
        _bottomToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _bottomToolbar.barStyle = UIBarStyleBlack;
        _bottomToolbar.translucent = NO;
        
        _backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage whiteImageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClickBack:)];
        _forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage whiteImageNamed:@"forward.png"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClickForward:)];
        _reloadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage whiteImageNamed:@"reload.png"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClickReload:)];
        
        _bottomToolbar.items = [NSArray arrayWithObjects:
            _backButton,
            [UIBarButtonItem fixedSpaceBarButtonItem:40],
            _forwardButton,
            [UIBarButtonItem flexibleSpaceBarButtonItem],
            _reloadButton,
            nil];
            
        [self.view addSubview:_bottomToolbar];
    }
    if(FLTestBits(self.buttonMode, FLWebViewControllerButtonModeCanCancel))
    {
        [self.buttonbar addButtonToRightSide:[FLToolbarButtonDeprecated toolbarButton:NSLocalizedString(@"Cancel", nil) target:self action:@selector(userDidCancel:)] forKey:@"cancel" animated:NO]; 
    }
	[self updateButtonStates];
}

- (void) adjustFrames
{
	if(self.navigationController)
	{
		CGRect navBarRect = self.navigationController.navigationBar.frame;

		if(_bottomToolbar && _bottomToolbar.hidden == NO)
		{
			CGRect toolbarRect = _bottomToolbar.frame;
			
			CGRect newRect = self.view.bounds;
			newRect.origin.y = FLRectGetBottom(navBarRect);
			newRect.size.height = toolbarRect.origin.y - newRect.origin.y;
			self.webView.frame = newRect;
		}
		else
		{
			CGRect newRect = self.view.bounds;
			newRect.origin.y = FLRectGetBottom(navBarRect);
			newRect.size.height = FLRectGetBottom(self.view.bounds) - newRect.origin.y;
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
		FLLog([cookie description]);
	}
#endif    
	
}



@end
