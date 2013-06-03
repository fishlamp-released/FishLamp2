//
//	FLSimpleHtmlView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSimpleHtmlView.h"
#import "FLGeometry.h"

@implementation FLSimpleHtmlView

@synthesize simpleHtmlViewDelegate = _simpleHtmlViewDelegate;

FLSynthesizeStructProperty(isLoaded, setIsLoaded, BOOL, _simpleHtmlFlags);
FLSynthesizeStructProperty(isLoading, setIsLoading, BOOL, _simpleHtmlFlags);

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
	FLRelease(_lastDocument);
	self.delegate = nil;
	self.simpleHtmlViewDelegate = nil;
	[self stopLoading];
	FLRelease(_spinner);
	FLSuperDealloc();
}

- (void) startSpinner:(UIActivityIndicatorViewStyle) spinnerStyle
{
	if(!_spinner)
	{
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:spinnerStyle];
		_spinner.hidesWhenStopped = YES;
		[self addSubview:_spinner];
	}

	[_spinner startAnimating];

}

- (void) stopSpinner
{
	[_spinner stopAnimating];
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
		
		if(FLStringsAreEqual(document, _lastDocument))
		{
			[self performSelectorOnMainThread:@selector(webViewDidFinishLoad:) withObject:self waitUntilDone:NO];
		}
		else
		{
			FLSetObjectWithRetain(_lastDocument, document);
			[self loadHTMLString:document baseURL:nil];
		}
	}
}

- (BOOL)webView:(UIWebView *)webView 
	shouldStartLoadWithRequest:(NSURLRequest *)request 
				navigationType:(UIWebViewNavigationType)navigationType
{
	if([_simpleHtmlViewDelegate respondsToSelector:@selector(simpleHtmlView:shouldStartLoadWithRequest:navigationType:)])
	{
		return [_simpleHtmlViewDelegate simpleHtmlView:self shouldStartLoadWithRequest:request navigationType:navigationType];
	}
	
	return YES;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if(_spinner)
	{
		_spinner.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, _spinner.frame);
	}
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	if([_simpleHtmlViewDelegate respondsToSelector:@selector(simpleHtmlViewDidStartLoading:)])
	{
		[_simpleHtmlViewDelegate simpleHtmlViewDidStartLoading:self];
	}
}

- (void) setSizeToLoadedSizeWithMaxSize:(CGSize) maxSize
{
	self.frame = FLRectSetSize(self.frame, maxSize.width, 20);

	CGSize loadedSize = [self sizeThatFits:CGSizeMake(maxSize.width, FLT_MAX)];
 
	CGRect htmlFrame = self.frame;
	htmlFrame.size.width = maxSize.width;
	htmlFrame.size.height = MIN(loadedSize.height, maxSize.height);
	self.frame = htmlFrame;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[_spinner stopAnimating];
	
	self.isLoading = NO;
	self.isLoaded = YES;
	[_simpleHtmlViewDelegate simpleHtmlView:self didFinishLoading:nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	self.isLoaded = YES;
	self.isLoading = NO;
	
	[_spinner stopAnimating];

	[_simpleHtmlViewDelegate simpleHtmlView:self didFinishLoading:error];
	
	FLLog(@"webview failed to load: %@", [error description]);
}

- (void) setIsTransparent
{
	self.backgroundColor = [UIColor clearColor];
	self.opaque = NO;
}
	

	
@end
