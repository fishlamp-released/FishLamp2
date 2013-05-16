//
//  GtActionSheet.m
//  MyZen
//
//  Created by Mike Fullerton on 2/2/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtActionSheet.h"
#import "GtGeometry.h"
#import "GtWindow.h"

@implementation GtActionSheet

@synthesize clickedButtonIndex = m_clickedButton;

static BOOL s_defaultRotate = NO;

+ (BOOL) defaultRotateToStatusBarOrientation
{
    return s_defaultRotate;
}

+ (void) setDefaultRotateToStatusBarOrientation:(BOOL) defaultDoRotate
{
    s_defaultRotate = defaultDoRotate;
}


GtSynthesizeStructProperty(rotateToStatusBarOrientation, setRotateToStatusBarOrientation, BOOL, m_flags);

- (id)initWithTitle:(NSString *)title 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  destructiveButtonTitle:(NSString *)destructiveButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if(self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil])
    {
        if(destructiveButtonTitle)
        {
        	[self addButtonWithTitle:destructiveButtonTitle];
			self.destructiveButtonIndex = self.numberOfButtons - 1;
		}
        
		if(otherButtonTitles)
		{
			[self addButtonWithTitle:otherButtonTitles];
		
			va_list valist;
			va_start(valist, otherButtonTitles);   
			id obj = nil;
			while (obj = va_arg(valist, id))
			{ 
				[self addButtonWithTitle:obj];
			}
			va_end(valist);
		}
        
        if(cancelButtonTitle)
		{
			[self addButtonWithTitle:cancelButtonTitle];
			self.cancelButtonIndex = self.numberOfButtons - 1;
		}
        
        self.rotateToStatusBarOrientation = [GtActionSheet defaultRotateToStatusBarOrientation];
    }
    
    return self;
}

- (void) dealloc
{
    if(m_rotateView)
    {
        [m_rotateView removeFromSuperview];
    }

    GtRelease(m_rotateView);
    GtRelease(m_clickedCallback);
    [super dealloc];
}

- (void) setButtonClickedCallback:(id) target action:(SEL) action
{
	GtReleaseWithNil(m_clickedCallback);
	m_clickedCallback = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:target action:action];
}

- (BOOL) wasCancelled
{
	return m_clickedButton == self.cancelButtonIndex;
}

- (BOOL) needsRotating
{
    return [UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && 
        self.rotateToStatusBarOrientation;
}

- (void) manuallyRotateAndShowInView:(UIView*) superview
{
    if(m_rotateView)
    {
        [m_rotateView removeFromSuperview];
        GtReleaseWithNil(m_rotateView);
    }

    m_rotateView = [GtAlloc(UIView) initWithFrame:superview.bounds];
    
    switch([UIApplication sharedApplication].statusBarOrientation)
    {
        case UIDeviceOrientationLandscapeRight:
            m_rotateView.transform = CGAffineTransformMakeRotation(GtDegreesToRadian(-90));
        break;
        
        case UIDeviceOrientationLandscapeLeft:
            m_rotateView.transform = CGAffineTransformMakeRotation(GtDegreesToRadian(90));
        break;
    }
    
    m_rotateView.bounds = CGRectMake(0, 0, 480, 320);
           
    [superview addSubview:m_rotateView];
    
    [super showInView:m_rotateView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	m_clickedButton = buttonIndex;

	if(m_clickedCallback)
	{
		[m_clickedCallback invoke:self];
	}
}

- (void)showFromToolbar:(UIToolbar *)view
{
    
    if(self.needsRotating)
    {
        self.actionSheetStyle = view.barStyle;
    
        [self manuallyRotateAndShowInView:[GtWindow topWindow]];
    }
    else
    {
        [super showFromToolbar:view];
    }
    
}

- (void)showFromTabBar:(UITabBar *)view
{
    if(self.needsRotating)
    {
        [self manuallyRotateAndShowInView:[GtWindow topWindow]];
    }
    else
    {
        [super showFromTabBar:view];
    }
}

- (void)showInView:(UIView *)view
{
    if(self.needsRotating)
    {
        [self manuallyRotateAndShowInView:[GtWindow topWindow]];
    }
    else
    {
        [super showInView:view];
    }
}


@end
