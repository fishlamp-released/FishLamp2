//
//  GtSimpleHtmlView.m
//  MyZen
//
//  Created by Mike Fullerton on 1/26/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtSimpleHtmlView.h"
#import "GtGeometry.h"

@implementation GtSimpleHtmlView

@synthesize html = m_builder;
@synthesize loadedSize = m_loadedSize;
@synthesize loadError = m_error;

GtSynthesizeStructProperty(isLoaded, setIsLoaded, BOOL, m_simpleHtmlFlags);

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        m_builder = [GtAlloc(GtHtmlBuilder) initWithPrettyPrint:NO];
        self.delegate = self;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) 
    {
	    m_builder = [GtAlloc(GtHtmlBuilder) initWithPrettyPrint:NO];
        self.delegate = self;
        
        self.backgroundColor = [UIColor blueColor];
    }
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_builder);
    GtRelease(m_spinner);
    GtRelease(m_error);
    GtRelease(m_loadedCallback);
    
    [super dealloc];
}

- (void) renderHtml
{   
    
    [self loadHTMLString:[m_builder toString] baseURL:nil];

    GtReleaseWithNil(m_builder);
}

- (BOOL)webView:(UIWebView *)webView 
    shouldStartLoadWithRequest:(NSURLRequest *)request 
                navigationType:(UIWebViewNavigationType)navigationType
{
    switch(navigationType)
    {
        case UIWebViewNavigationTypeLinkClicked:
            [[UIApplication sharedApplication] openURL:[request URL]];
            return NO;
            break;
    }

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    m_spinner = [GtAlloc(UIActivityIndicatorView) initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    m_spinner.frame = GtCenterRectInRect(self.bounds, m_spinner.frame);
    [m_spinner startAnimating];
    [self addSubview:m_spinner];
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [m_spinner removeFromSuperview];
    GtReleaseWithNil(m_spinner);
    
    m_loadedSize = [self sizeThatFits:CGSizeZero];
    
    [m_loadedCallback invoke:self];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    GtRelease(m_error);
    m_error = [error retain];
    
    [m_spinner removeFromSuperview];
    GtReleaseWithNil(m_spinner);

    [m_loadedCallback invoke:self];
}

- (void) setIsTransparent
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}
    
- (void) setLoadedCallback:(id) target action:(SEL) action
{
    GtReleaseWithNil(m_loadedCallback);
    
    m_loadedCallback = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:target action:action];
}
    
@end
