//
//  GtProgressHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/17/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//
#if IPHONE

#import "GtProgressHandler.h"
#import "GtWindow.h"

@implementation GtProgressHandler

@synthesize buttonAction = m_buttonAction;
@synthesize buttonTarget = m_buttonTarget;
@synthesize opacity = m_opacity;
@synthesize superview = m_superview;

GtSynthesizeStructProperty(isModal, setIsModal, BOOL, m_flags);
GtSynthesizeStructProperty(wantsProgressBar, setWantsProgressBar, BOOL, m_flags);
GtSynthesizeStructProperty(location, setLocation, GtProgressLocation, m_flags);

GtSynthesize(text, setText, NSString, m_busyText);
GtSynthesize(buttonText, setButtonText, NSString, m_buttonText);
GtSynthesize(busyView, setBusyView, GtBusyView, m_busyView);
GtSynthesize(customView, setCustomView, UIView, m_customView);

GtSynthesizeWeakRefProperty();

- (id) init
{
	if(self = [super init])
	{
		self.superview = [GtWindow topWindow];
		self.location = GtProgressLocationCentered;
		self.opacity = -1.0;
	}
	
	return self;
}

- (void) setSuperview:(UIView*) superview
{
	if(superview != nil)
	{
		m_superview = [superview retain];
	}
	else
	{
		m_superview = [GtWindow topWindow];
	}
}

- (void) setButtonInfo:(NSString*) buttonText buttonTarget:(id) buttonTarget buttonAction:(SEL) buttonAction
{
	self.buttonText = buttonText;
	m_buttonAction = buttonAction;
	m_buttonTarget = buttonTarget;
}

- (void) dealloc
{
	[self stopProgress];

    GtReleaseWeakRef();

	GtRelease(m_busyText);
	GtRelease(m_buttonText);
	GtRelease(m_customView);
	GtRelease(m_busyView);
	GtRelease(m_superview);
	[super dealloc];
}

- (void) reset
{
    self.isModal = NO;
    self.wantsProgressBar = NO;
    self.text = @"";
    self.customView = nil;
    [self removeButton];
}
- (void) removeButton
{
    m_buttonAction = nil;
    m_buttonTarget = nil;
    self.buttonText = nil;
}

- (void) startProgress
{
    if(m_busyView)
    {
        [self.busyView setup:self];
    }
    else
    {
        GtBusyView* busy = [GtAlloc(GtBusyView) initWithProgressHandler:self];
        self.busyView = busy;
        GtRelease(busy);
    }
}

- (void) stopProgress
{
	[self.busyView setDone:NO];
	self.busyView = nil;
}

- (BOOL) isShowingProgress
{
	return m_busyView != nil;
}

- (void) updateProgress:(CGFloat) value
{
	if(m_busyView)
	{
		[m_busyView updateProgress:value];
	}
}

- (UIView*) superview
{
    if(self.isModal)
    {
        return [GtWindow topWindow];
#if 0    
        GtAssertNotNil(m_superview);
        
        UIView* view = m_superview;
        while(view && ![view isKindOfClass:[UIWindow class]])
        {
            if(!view.superview)
            {
                GtLog(@"Warning superview not finding window it belongs to");
                break;
            }
            view = view.superview;
        }
        return view;
#endif

    }
    
    return m_superview;
}

@end
#endif