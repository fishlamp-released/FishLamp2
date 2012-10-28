//
//	FLCountView.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCountView.h"


@implementation FLCountView

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_countView = [[UILabel alloc] initWithFrame:self.bounds];
		_countView.lineBreakMode = UILineBreakModeTailTruncation;
		_countView.textColor = [UIColor whiteColor];
		_countView.shadowColor = [UIColor blackColor];
		_countView.shadowOffset	= FLSizeMake (0.0, 0.0);
		_countView.backgroundColor = [UIColor clearColor];
		_countView.textAlignment = UITextAlignmentCenter;
		_countView.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
		_countView.text = @"0";
		_countView.numberOfLines = 1;
		_countView.autoresizingMask = UIViewAutoresizingNone;
		
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.borderColor = [UIColor whiteColor];
		self.fillColor = [UIColor iPhoneBlueColor];
		self.borderLineWidth = 2;
		self.cornerRadius = 2;
		[self addSubview:_countView];
	}

	return self;
}

- (void) dealloc
{
	FLRelease(_countView);
	FLSuperDealloc();
}

- (void) setCount:(NSInteger) count
{
	_countView.text = [NSString stringWithFormat:@"%d", count];
	[self setNeedsLayout];
}

- (NSInteger) count
{
	return [_countView.text intValue];
}

- (void) layoutSubviews
{
	[super layoutSubviews];

	[_countView sizeToFitText:FLSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
	
	FLRect frame = _countView.frame;
	frame.size.width += 16;
	frame.size.height += 6;
	frame = FLRectCenterOnPoint(frame, FLRectGetCenter(self.frame));
	if([self setFrameIfChanged:frame])
	{
		self.cornerRadius = (self.frame.size.height/2.0f) - 2.0f;
		[self setNeedsDisplay];
	}

	_countView.frameOptimizedForSize = FLRectMoveVertically(FLRectCenterRectInRect(self.bounds, _countView.frame), -1);
}

@end
