//
//	GtSimpleHtmlView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSimpleHtmlView.h"
#import "GtGeometry.h"

@implementation GtSimpleHtmlView

@synthesize simpleHtmlViewDelegate = m_simpleHtmlViewDelegate;

GtSynthesizeStructProperty(isLoaded, setIsLoaded, BOOL, m_simpleHtmlFlags);
GtSynthesizeStructProperty(isLoading, setIsLoading, BOOL, m_simpleHtmlFlags);

- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.delegate = self;
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.autoresizesSubviews = YES;
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) 
	{
		self.delegate = self;
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.autoresizesSubviews = YES;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_lastDocument);
	self.delegate = nil;
	self.simpleHtmlViewDelegate = nil;
	[self stopLoading];
	GtRelease(m_spinner);
	GtSuperDealloc();
}

- (void) startSpinner:(UIActivityIndicatorViewStyle) spinnerStyle
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:spinnerStyle];
		m_spinner.hidesWhenStopped = YES;
		[self addSubview:m_spinner];
	}

	[m_spinner startAnimating];

}

- (void) stopSpinner
{
	[m_spinner stopAnimating];
}

- (NSMutableURLRequest*) createURLRequestForURL:(NSURL*) url
{
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
	
	if([self.simpleHtmlViewDelegate respondsToSelector:@selector(simpleHtmlView:configureRequest:)])
	{
		[self.simpleHtmlViewDelegate simpleHtmlView:self configureRequest:request];
	}
	
	return request;
}

- (void) beginLoadingUrl:(NSURL*) url
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle
{
	if(!self.isLoading)
	{
		self.isLoading = YES;
		self.isLoaded = NO;
		[self startSpinner:spinnerStyle];
		[self loadRequest:[self createURLRequestForURL:url]];
	}
}

- (void) beginLoadingHtmlStringDocument:(NSString*) document spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle
{	
	if(!self.isLoading)
	{
		self.isLoading = YES;
		self.isLoaded = NO;
		
		[self startSpinner:spinnerStyle];
		
		if(GtStringsAreEqual(document, m_lastDocument))
		{
			[self performSelectorOnMainThread:@selector(webViewDidFinishLoad:) withObject:self waitUntilDone:NO];
		}
		else
		{
			GtAssignObject(m_lastDocument, document);
			[self loadHTMLString:document baseURL:nil];
		}
	}
}

- (BOOL)webView:(UIWebView *)webView 
	shouldStartLoadWithRequest:(NSURLRequest *)request 
				navigationType:(UIWebViewNavigationType)navigationType
{
	if([m_simpleHtmlViewDelegate respondsToSelector:@selector(simpleHtmlView:shouldStartLoadWithRequest:navigationType:)])
	{
		return [m_simpleHtmlViewDelegate simpleHtmlView:self shouldStartLoadWithRequest:request navigationType:navigationType];
	}
	
	return YES;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if(m_spinner)
	{
		m_spinner.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds, m_spinner.frame);
	}
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	if([m_simpleHtmlViewDelegate respondsToSelector:@selector(simpleHtmlViewDidStartLoading:)])
	{
		[m_simpleHtmlViewDelegate simpleHtmlViewDidStartLoading:self];
	}
}

- (void) setSizeToLoadedSizeWithMaxSize:(CGSize) maxSize
{
	self.frame = GtRectSetSize(self.frame, maxSize.width, 20);

	CGSize loadedSize = [self sizeThatFits:CGSizeMake(maxSize.width, INT_MAX)];
 
	CGRect htmlFrame = self.frame;
	htmlFrame.size.width = maxSize.width;
	htmlFrame.size.height = MIN(loadedSize.height, maxSize.height);
	self.frame = htmlFrame;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[m_spinner stopAnimating];
	
	self.isLoading = NO;
	self.isLoaded = YES;
	[m_simpleHtmlViewDelegate simpleHtmlView:self didFinishLoading:nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	self.isLoaded = YES;
	self.isLoading = NO;
	
	[m_spinner stopAnimating];

	[m_simpleHtmlViewDelegate simpleHtmlView:self didFinishLoading:error];
	
	GtLog(@"webview failed to load: %@", [error description]);
}

- (void) setIsTransparent
{
	self.backgroundColor = [UIColor clearColor];
	self.opaque = NO;
}
	

	
@end
