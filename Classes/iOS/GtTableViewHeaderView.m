//
//	GtTableViewHeaderView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTableViewHeaderView.h"
//#import "GtMobileThemen

@implementation GtTableViewHeaderView

@synthesize textIndent = m_indent;
@synthesize textLabel = m_label;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.backgroundColor = [UIColor clearColor];
		self.themeAction = @selector(applyThemeToTableViewHeaderView:);
		m_indent = 15;
		
		m_label = [[UILabel alloc] initWithFrame:CGRectZero];
		m_label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		m_label.shadowColor = [UIColor whiteColor];
		m_label.textColor = [UIColor darkGrayColor];
		m_label.shadowOffset = CGSizeMake(0,1);
		m_label.backgroundColor = [UIColor clearColor];
		m_label.autoresizingMask = UIViewAutoresizingNone;
		m_label.contentMode = UIViewContentModeScaleToFill;
		m_label.textAlignment = UITextAlignmentLeft;
		[self addSubview:m_label];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_label);
	GtSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(GtStringIsNotEmpty(m_label.text))
	{
		[m_label sizeToFitText];
		
		CGRect frame = GtRectJustifyRectInRectBottom(self.bounds, m_label.frame);
		frame = GtRectSetLeft(frame, m_indent);
		frame.origin.y -= 2;
		m_label.frameOptimizedForSize = frame;
	}
}

- (CGFloat) minHeight
{
	if(GtStringIsNotEmpty(m_label.text))
	{
		[m_label sizeToFitText];
		return m_label.frame.size.height + 12.0;
	}
	
	return 0.0f;
}

@end

