//
//  FLSimpleHtmlViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSimpleHtmlViewController.h"
#import "FLGradientButton.h"
#import "FLFloatingViewController.h"

@implementation FLSimpleHtmlViewController

@synthesize finishedLoadingCallback = _finishLoadingCallback;
@synthesize configureRequestCallback = _configureRequestCallback;
@synthesize htmlView = _htmlView;

- (void) dealloc
{
	FLRelease(_htmlView);
	FLRelease(_configureRequestCallback);
	FLRelease(_finishLoadingCallback);
	FLSuperDealloc();
}

- (void)loadView
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
	
		_htmlView = [[FLSimpleHtmlView alloc] initWithFrame:parentView.bounds];		
		_htmlView.simpleHtmlViewDelegate = self;
		_htmlView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		_htmlView.autoresizesSubviews = YES;

		[parentView addSubview:_htmlView];
	
		self.view = parentView;
	}
}

- (void) wasPushedOnNavigationController:(UINavigationController *)controller
{
	[super wasPushedOnNavigationController:controller];
	
	float height = FLRectGetBottom(controller.navigationBar.frame);
	
	_htmlView.frame = FLRectInsetTop(_htmlView.frame, height);
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

- (void) simpleHtmlView:(FLSimpleHtmlView*) view configureRequest:(NSMutableURLRequest*) request
{
	if(_configureRequestCallback)
	{
		_configureRequestCallback(request);
	}
}

- (void) simpleHtmlView:(FLSimpleHtmlView*) view didFinishLoading:(NSError*) error
{
	if(_finishLoadingCallback)
	{
		_finishLoadingCallback(error);
	}
}

- (void) simpleHtmlViewDidStartLoading:(FLSimpleHtmlView*) view
{
}

- (void) cancel:(id) sender
{
	[self hideViewController:YES];
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
    if(self.navigationController)
    {
        [self.buttonbar addButtonToRightSide:[FLToolbarButtonDeprecated toolbarButton:@"Cancel" target:self action:@selector(cancel:)] forKey:@"cancel" animated:NO]; 
    }
    
    self.contentSizeForViewInFloatingView = CGSizeMake(320, 480);
}

@end
