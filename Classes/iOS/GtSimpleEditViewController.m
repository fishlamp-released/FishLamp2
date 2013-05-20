//
//  GtSimpleEditViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSimpleEditViewController.h"
#import "GtGradientView.h"
#import "GtGradientButton.h"
#import "GtHoverViewController.h"

@implementation GtSimpleEditViewController

@synthesize beginSaveCallback = m_beginSaveCallback;
@synthesize beginCancelCallback = m_beginCancelCallback;
@synthesize contentView = m_contentView;
@synthesize saveButtonHidden = m_saveButtonHidden;
@synthesize cancelButtonHidden = m_cancelButtonHidden;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.cancelButtonEnabled = YES;
        self.saveButtonEnabled = YES;
        
        self.saveButtonTitle = NSLocalizedString(@"Save", nil);
        self.cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
        
        self.contentSizeForViewInHoverView = CGSizeMake(600, 400);
    }
    return self;
}

- (void) setSaveButtonEnabled:(BOOL) enabled
{
	m_saveButtonEnabled = enabled;
    if(self.buttonbar)
    {
        [self.buttonbar setViewEnabled:enabled forKey:@"save"];
    }
}

- (BOOL) saveButtonEnabled
{
	return m_saveButtonEnabled;
}

- (void) setCancelButtonEnabled:(BOOL) enabled
{
    m_cancelButtonEnabled = enabled;
    if(self.buttonbar)
    {
        [self.buttonbar setViewEnabled:enabled forKey:@"cancel"];
    }
}

- (void) setCancelButtonHidden:(BOOL) hidden
{
    m_cancelButtonHidden = hidden;
    if(self.buttonbar)
    {
        [self.buttonbar setViewHidden:hidden forKey:@"cancel" animated:NO];
    }
}

- (void) setSaveButtonHidden:(BOOL) hidden
{
    m_saveButtonHidden = hidden;
    if(self.buttonbar)
    {
        [self.buttonbar setViewHidden:hidden forKey:@"save"  animated:NO];
    }
}

- (BOOL) cancelButtonEnabled
{
	return m_cancelButtonEnabled;
}

- (void) willBeginSaving
{
    [self stopEditing];
    [self beginSaving];
}

- (void) beginSaving
{
    [self saveComplete];
}

- (void) saveComplete
{
    GtInvokeCallback(m_beginSaveCallback, self);
}

- (void) beginCancel
{
    [self cancelComplete];
}

- (void) cancelComplete
{
    if(!GtInvokeCallback(m_beginCancelCallback, self))
    {
        [self dismissViewControllerAnimated:YES];
    }
}

- (void) _save:(id) sender
{
	[self willBeginSaving];
}

- (void) _cancel:(id) sender
{
	[self stopEditing];
    [self beginCancel];
}

- (void) dealloc
{
	GtRelease(m_contentView);
	GtRelease(m_saveButton);
	GtRelease(m_cancelButton);
	GtSuperDealloc();
}

- (NSString*) saveButtonTitle
{
	return m_saveButtonTitle;
}

- (void) setSaveButtonTitle:(NSString*) title
{
    GtAssignObject(m_saveButtonTitle, title);
    if(m_saveButton)
    {
        m_saveButton.title = title;
    }
	if(self.buttonbar)
	{
		[self.buttonbar setNeedsLayout];
	}
}
- (NSString*) cancelButtonTitle
{
	return m_cancelButtonTitle;
}

- (void) setCancelButtonTitle:(NSString*) title
{
    GtAssignObject(m_cancelButtonTitle, title);
    if(m_cancelButton)
    {
        m_cancelButton.title = title;
    }
	if(self.buttonbar)
	{
		[self.buttonbar setNeedsLayout];
	}
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    GtReleaseWithNil(m_contentView);
    GtReleaseWithNil(m_saveButton);
    GtReleaseWithNil(m_cancelButton);
}


- (void) configureContentView
{
    self.contentView.viewLayout = [GtFillInSuperviewViewLayout viewLayout];
}

- (void) viewDidLoad
{
	[super viewDidLoad];

    m_saveButton = [[GtToolbarButton alloc] initWithColor:GtButtonColorBrightBlue title:m_saveButtonTitle target:self action:@selector(_save:)];
    m_cancelButton = [[GtToolbarButton alloc] initWithTitle:m_cancelButtonTitle target:self action:@selector(_cancel:)];
	[self.buttonbar addButtonToLeftSide:m_cancelButton forKey:@"cancel" animated:NO];
	[self.buttonbar addButtonToRightSide:m_saveButton forKey:@"save" animated:NO];
    self.saveButtonEnabled  = m_saveButtonEnabled;
    self.cancelButtonEnabled = m_cancelButtonEnabled;
    self.saveButtonHidden = m_saveButtonHidden;
    self.cancelButtonHidden = m_cancelButtonHidden;
    
    m_contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    m_contentView.autoresizesSubviews = NO;
    m_contentView.backgroundColor = [UIColor clearColor];
    m_contentView.autoresizingMask =  UIViewAutoresizingNone;
    
//                                        UIViewAutoresizingFlexibleBottomMargin | 
//                                        UIViewAutoresizingFlexibleHeight | 
//                                        UIViewAutoresizingFlexibleRightMargin | 
//                                        UIViewAutoresizingFlexibleWidth;
    m_contentView.viewLayout.padding = UIEdgeInsets10;
	
    [self.view addSubview:m_contentView];
    [self configureContentView];
}

- (void) dismissViewControllerAnimated:(BOOL)animated
{
	[self stopEditing];
	[super dismissViewControllerAnimated:animated];
}

- (UIView*) createBackgroundView;
{
	GtGradientView* view = GtReturnAutoreleased([[GtGradientView alloc] initWithFrame:CGRectMake(0,0,320,480)]);
    view.themeAction = @selector(applyThemeToGradientView:);
	
    return view;
}

- (void) loadView
{
	if(GtStringIsNotEmpty(self.nibName))
	{
		[super loadView];
	}
	else
	{
		UIView* view = [self createBackgroundView];
		view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		view.autoresizesSubviews = YES;
		self.view = view;
	}
}

- (void) stopEditing
{
}

- (void) adjustFrames
{
	if(self.navigationController)
	{
		CGRect navBarRect = self.navigationController.navigationBar.frame;

//		if(m_bottomToolbar)
//		{
//			CGRect toolbarRect = m_bottomToolbar.hidden ? CGRectZero : m_bottomToolbar.frame;
//			
//			CGRect newRect = self.view.bounds;
//			newRect.origin.y = GtRectGetBottom(navBarRect);
//			newRect.size.height = toolbarRect.origin.y - newRect.origin.y;
//			self.webView.frame = newRect;
//		}
//		else
		{
			CGRect newRect = self.view.bounds;
			newRect.origin.y = GtRectGetBottom(navBarRect);
			newRect.size.height = GtRectGetBottom(self.view.bounds) - newRect.origin.y;
			m_contentView.frame = newRect;
			
		}
	}
}

- (void) setSizeInPopoverFromContentViewLayout
{
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    if(self.hoverViewController)
	{
        self.view.frame = GtRectSetWidth(self.view.frame, self.contentSizeForViewInHoverView.width);

        [self adjustFrames];
        
        UIView* contentView = self.contentView;
        
        contentView.frameOptimizedForLocation = GtRectSetSizeWithSize(contentView.frame, 
            [contentView.viewLayout layoutArrangeableViews:contentView.subviews inBounds:contentView.bounds]);
        
//        [contentView.viewLayout setViewSize:contentView];
        
        [self.hoverViewController setContentViewSize:
            CGSizeMake(GtRectGetRight(contentView.frame), GtRectGetBottom(contentView.frame)) 
            animated:NO];
    }
    else
    {
        UIView* contentView = self.contentView;
        contentView.frame = self.view.bounds;
        [self adjustFrames];    
        [contentView.viewLayout layoutArrangeableViews:contentView.subviews inBounds:contentView.bounds];
    }
}





@end
