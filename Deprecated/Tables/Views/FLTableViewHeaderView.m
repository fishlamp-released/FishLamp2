//
//	FLTableViewHeaderView.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTableViewHeaderView.h"
//#import "FLMobileThemen

@implementation FLTableViewHeaderView

@synthesize textIndent = _indent;
@synthesize textLabel = _label;

- (void) applyTheme:(FLTheme*) theme {
	[self textLabel].font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
//	[self textLabel].textColor = self.tableHeaderTextColor;
	[self textLabel].shadowColor = [UIColor gray20Color];
	[[self textLabel] addGlow];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.backgroundColor = [UIColor clearColor];
		self.wantsApplyTheme = YES;
		_indent = 15;
		
		_label = [[UILabel alloc] initWithFrame:CGRectZero];
		_label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		_label.shadowColor = [UIColor whiteColor];
		_label.textColor = [UIColor darkGrayColor];
		_label.shadowOffset = CGSizeMake(0,1);
		_label.backgroundColor = [UIColor clearColor];
		_label.autoresizingMask = UIViewAutoresizingNone;
		_label.contentMode = UIViewContentModeScaleToFill;
		_label.textAlignment = UITextAlignmentLeft;
		[self addSubview:_label];
	}
	return self;
}

- (void) dealloc
{
	FLRelease(_label);
	FLSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(FLStringIsNotEmpty(_label.text))
	{
		[_label sizeToFitText];
		
		CGRect frame = FLRectJustifyRectInRectBottom(self.bounds, _label.frame);
		frame = FLRectSetLeft(frame, _indent);
		frame.origin.y -= 2;
		_label.frameOptimizedForSize = frame;
	}
}

- (CGFloat) minHeight
{
	if(FLStringIsNotEmpty(_label.text))
	{
		[_label sizeToFitText];
		return _label.frame.size.height + 12.0;
	}
	
	return 0.0f;
}

@end

