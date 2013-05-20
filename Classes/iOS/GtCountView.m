//
//	GtCountView.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCountView.h"


@implementation GtCountView

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_countView = [[UILabel alloc] initWithFrame:self.bounds];
		m_countView.lineBreakMode = UILineBreakModeTailTruncation;
		m_countView.textColor = [UIColor whiteColor];
		m_countView.shadowColor = [UIColor blackColor];
		m_countView.shadowOffset	= CGSizeMake (0.0, 0.0);
		m_countView.backgroundColor = [UIColor clearColor];
		m_countView.textAlignment = UITextAlignmentCenter;
		m_countView.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		m_countView.text = @"0";
		m_countView.numberOfLines = 1;
		m_countView.autoresizingMask = UIViewAutoresizingNone;
		
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.borderColor = [UIColor whiteColor];
		self.fillColor = [UIColor iPhoneBlueColor];
		self.borderLineWidth = 2;
		self.cornerRadius = 2;
		[self addSubview:m_countView];
	}

	return self;
}

- (void) dealloc
{
	GtRelease(m_countView);
	GtSuperDealloc();
}

- (void) setCount:(NSInteger) count
{
	m_countView.text = [NSString stringWithFormat:@"%d", count];
	[self setNeedsLayout];
}

- (NSInteger) count
{
	return [m_countView.text intValue];
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	[m_countView sizeToFitText:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
	
	CGRect frame = m_countView.frame;
	frame.size.width += 16;
	frame.size.height += 6;
	frame = GtRectCenterOnPoint(frame, GtRectGetCenter(self.frame));
	if([self setFrameIfChanged:frame])
	{
		self.cornerRadius = (self.frame.size.height/2.0f) - 2.0f;
		[self setNeedsDisplay];
	}

	m_countView.frameOptimizedForSize = GtRectMoveVertically(GtRectCenterRectInRect(self.bounds, m_countView.frame), -1);
}

@end
