//
//  FLSimpleEditViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSimpleEditViewController.h"
#import "FLGradientView.h"
#import "FLGradientButton.h"
#import "FLFloatingViewController.h"
#import "FLFillInBoundsArrangement.h"


@implementation FLSimpleEditViewController

@synthesize beginSaveCallback = _beginSaveCallback;
@synthesize beginCancelCallback = _beginCancelCallback;
@synthesize contentView = _contentView;
@synthesize saveButtonHidden = _saveButtonHidden;
@synthesize cancelButtonHidden = _cancelButtonHidden;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.cancelButtonEnabled = YES;
        self.saveButtonEnabled = YES;
        
        self.saveButtonTitle = NSLocalizedString(@"Save", nil);
        self.cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
        
        self.contentSizeForViewInFloatingView = CGSizeMake(600, 400);
    }
    return self;
}

- (void) setSaveButtonEnabled:(BOOL) enabled
{
	_saveButtonEnabled = enabled;
    if(self.buttonbar)
    {
        [self.buttonbar setViewEnabled:enabled forKey:@"save"];
    }
}

- (BOOL) saveButtonEnabled
{
	return _saveButtonEnabled;
}

- (void) setCancelButtonEnabled:(BOOL) enabled
{
    _cancelButtonEnabled = enabled;
    if(self.buttonbar)
    {
        [self.buttonbar setViewEnabled:enabled forKey:@"cancel"];
    }
}

- (void) setCancelButtonHidden:(BOOL) hidden
{
    _cancelButtonHidden = hidden;
    if(self.buttonbar)
    {
        [self.buttonbar setViewHidden:hidden forKey:@"cancel" animated:NO];
    }
}

- (void) setSaveButtonHidden:(BOOL) hidden
{
    _saveButtonHidden = hidden;
    if(self.buttonbar)
    {
        [self.buttonbar setViewHidden:hidden forKey:@"save"  animated:NO];
    }
}

- (BOOL) cancelButtonEnabled
{
	return _cancelButtonEnabled;
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
    FLInvokeCallback(_beginSaveCallback, self);
}

- (void) beginCancel
{
    [self cancelComplete];
}

- (void) cancelComplete
{
    if(!FLInvokeCallback(_beginCancelCallback, self))
    {
        [self hideViewController:YES];
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
	FLRelease(_contentView);
	FLRelease(_saveButton);
	FLRelease(_cancelButton);
	FLSuperDealloc();
}

- (NSString*) saveButtonTitle
{
	return _saveButtonTitle;
}

- (void) setSaveButtonTitle:(NSString*) title
{
    FLSetObjectWithRetain(_saveButtonTitle, title);
    if(_saveButton)
    {
        _saveButton.title = title;
    }
	if(self.buttonbar)
	{
		[self.buttonbar setNeedsLayout];
	}
}
- (NSString*) cancelButtonTitle
{
	return _cancelButtonTitle;
}

- (void) setCancelButtonTitle:(NSString*) title
{
    FLSetObjectWithRetain(_cancelButtonTitle, title);
    if(_cancelButton)
    {
        _cancelButton.title = title;
    }
	if(self.buttonbar)
	{
		[self.buttonbar setNeedsLayout];
	}
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    FLReleaseWithNil(_contentView);
    FLReleaseWithNil(_saveButton);
    FLReleaseWithNil(_cancelButton);
}


- (void) configureContentView
{
    self.contentView.arrangement = [FLFillInBoundsArrangement arrangement];
}

- (void) viewDidLoad
{
	[super viewDidLoad];

    _saveButton = [[FLToolbarButtonDeprecated alloc] initWithColor:FLGradientButtonColorBrightBlue title:_saveButtonTitle target:self action:@selector(_save:)];
    _cancelButton = [[FLToolbarButtonDeprecated alloc] initWithTitle:_cancelButtonTitle target:self action:@selector(_cancel:)];
	[self.buttonbar addButtonToLeftSide:_cancelButton forKey:@"cancel" animated:NO];
	[self.buttonbar addButtonToRightSide:_saveButton forKey:@"save" animated:NO];
    self.saveButtonEnabled  = _saveButtonEnabled;
    self.cancelButtonEnabled = _cancelButtonEnabled;
    self.saveButtonHidden = _saveButtonHidden;
    self.cancelButtonHidden = _cancelButtonHidden;
    
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    _contentView.autoresizesSubviews = NO;
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.autoresizingMask =  UIViewAutoresizingNone;
    
//                                        UIViewAutoresizingFlexibleBottomMargin | 
//                                        UIViewAutoresizingFlexibleHeight | 
//                                        UIViewAutoresizingFlexibleRightMargin | 
//                                        UIViewAutoresizingFlexibleWidth;
    _contentView.arrangement.outerInsets = FLEdgeInsets10;
	
    [self.view addSubview:_contentView];
    [self configureContentView];
}

- (void) hideViewController:(BOOL)animated
{
	[self stopEditing];
	[super hideViewController:animated];
}

- (void) applyTheme:(FLTheme*) theme {

//	[self applyThemeToNotificationView:view];

}

- (UIView*) createBackgroundView {
	FLGradientView* view = FLAutorelease([[FLGradientView alloc] initWithFrame:CGRectMake(0,0,320,480)]);
    return view;
}

- (void) loadView
{
	if(FLStringIsNotEmpty(self.nibName))
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

//		if(_bottomToolbar)
//		{
//			CGRect toolbarRect = _bottomToolbar.hidden ? CGRectZero : _bottomToolbar.frame;
//			
//			CGRect newRect = self.view.bounds;
//			newRect.origin.y = FLRectGetBottom(navBarRect);
//			newRect.size.height = toolbarRect.origin.y - newRect.origin.y;
//			self.webView.frame = newRect;
//		}
//		else
		{
			CGRect newRect = self.view.bounds;
			newRect.origin.y = FLRectGetBottom(navBarRect);
			newRect.size.height = FLRectGetBottom(self.view.bounds) - newRect.origin.y;
			_contentView.frame = newRect;
			
		}
	}
}

- (void) setSizeInPopoverFromContentArrangement
{
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    if(self.floatingViewController)
	{
        self.view.frame = FLRectSetWidth(self.view.frame, self.contentSizeForViewInFloatingView.width);

        [self adjustFrames];
        
        UIView* contentView = self.contentView;
        
        contentView.frameOptimizedForLocation = FLRectSetSizeWithSize(contentView.frame, 
            [contentView.arrangement performArrangement:contentView.subviews inBounds:contentView.bounds]);
        
//        [contentView.arrangement setViewSize:contentView];
        
        [self.floatingViewController setContentViewSize:
            CGSizeMake(FLRectGetRight(contentView.frame), FLRectGetBottom(contentView.frame)) 
            animated:NO];
    }
    else
    {
        UIView* contentView = self.contentView;
        contentView.frame = self.view.bounds;
        [self adjustFrames];    
        [contentView.arrangement performArrangement:contentView.subviews inBounds:contentView.bounds];
    }
}





@end
