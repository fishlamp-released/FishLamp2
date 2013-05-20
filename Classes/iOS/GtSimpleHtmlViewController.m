//
//  GtSimpleHtmlViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSimpleHtmlViewController.h"
#import "GtGradientButton.h"
#import "GtHoverViewController.h"

@implementation GtSimpleHtmlViewController

@synthesize finishedLoadingCallback = m_finishLoadingCallback;
@synthesize configureRequestCallback = m_configureRequestCallback;
@synthesize htmlView = m_htmlView;

- (void) dealloc
{
	GtRelease(m_htmlView);
	GtRelease(m_configureRequestCallback);
	GtRelease(m_finishLoadingCallback);
	GtSuperDealloc();
}

- (void)loadView
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
	
		m_htmlView = [[GtSimpleHtmlView alloc] initWithFrame:parentView.bounds];		
		m_htmlView.simpleHtmlViewDelegate = self;
		m_htmlView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		m_htmlView.autoresizesSubviews = YES;

		[parentView addSubview:m_htmlView];
	
		self.view = parentView;
	}
}

- (void) wasPushedOnNavigationController:(UINavigationController *)controller
{
	[super wasPushedOnNavigationController:controller];
	
	float height = GtRectGetBottom(controller.navigationBar.frame);
	
	m_htmlView.frame = GtRectInsetTop(m_htmlView.frame, height);
}

- (void) beginLoadingHtmlStringDocument:(NSString*) document
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle
{
	[self.htmlView beginLoadingHtmlStringDocument:document spinnerStyle:spinnerStyle];
}

- (void) beginLoadingUrl:(NSURL*) url
		 spinnerStyle:(UIActivityIndicatorViewStyle) spinnerStyle
{
	[self.htmlView beginLoadingUrl:url spinnerStyle:spinnerStyle];
}

- (void) simpleHtmlView:(GtSimpleHtmlView*) view configureRequest:(NSMutableURLRequest*) request
{
	if(m_configureRequestCallback)
	{
		m_configureRequestCallback(request);
	}
}

- (void) simpleHtmlView:(GtSimpleHtmlView*) view didFinishLoading:(NSError*) error
{
	if(m_finishLoadingCallback)
	{
		m_finishLoadingCallback(error);
	}
}

- (void) simpleHtmlViewDidStartLoading:(GtSimpleHtmlView*) view
{
}

- (void) cancel:(id) sender
{
	[self dismissViewControllerAnimated:YES];
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
    if(self.navigationController)
    {
        [self.buttonbar addButtonToRightSide:[GtToolbarButton toolbarButton:@"Cancel" target:self action:@selector(cancel:)] forKey:@"cancel" animated:NO]; 
    }
    
    self.contentSizeForViewInHoverView = CGSizeMake(320, 480);
}

@end
