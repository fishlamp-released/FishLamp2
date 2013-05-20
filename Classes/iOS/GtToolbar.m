//
//	GtToolbar.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/17/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtToolbar.h"


@implementation GtToolbar

GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_themeState);
GtSynthesizeStructProperty(themeAction, setThemeAction, SEL, m_themeState);

#if 0
//#if VIEW_AUTOLAYOUT

@synthesize superviewContentsDescriptor = m_superviewContentsDescriptor;
@synthesize autoLayoutMode = m_autoLayoutMode;
@synthesize viewDelegate = m_viewDelegate;
@synthesize lastSuperviewSize = m_lastSuperviewSize;
@synthesize viewLayoutMargins = m_viewLayoutMargins;


- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_superviewContentsDescriptor = GtViewContentsDescriptorInvalid;
		m_autoLayoutMode = GtRectLayoutNone; 
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder]))
	{
		m_superviewContentsDescriptor = GtViewContentsDescriptorInvalid;
		m_autoLayoutMode = GtRectLayoutNone; 
	}
	return self;
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyTheme];
		GtViewDidMoveToSuperview(self);
	}
}

- (void) clearViewDelegate
{
	m_viewDelegate = nil;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(self.superview)
	{
		GtViewDidLayoutSubviews(self);
	}
}

- (void) setPositionInSuperview
{
	GtViewSetPositionInSuperview(self);
}
#endif

@end

@implementation GtToolbarViewController 

- (id) initWithToolbar:(GtToolbar*) toolBar {
    return [super initWithView:toolBar];
}

+ (id) toolbarViewController:(GtToolbar*) toolBar {
    return [[[[self class] alloc] initWithToolbar:toolBar] autorelease];
}

- (GtToolbar*) toolbar {
    return (GtToolbar*) self.view;
}

@end