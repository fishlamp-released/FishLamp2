//
//	FLDeprecatedButtonbarToolbar.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLDeprecatedButtonbarToolbar.h"

@implementation FLDeprecatedButtonbarToolbar

@synthesize buttonbar = _buttonbar;

- (id) initWithFrame:(FLRect)frame buttonbarView:(FLDeprecatedButtonbarView*) buttonbarView
{
	if((self = [super initWithFrame:frame]))
    {
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
		self.barStyle = UIBarStyleBlack;
		self.translucent = YES;
        
        _buttonbar = retain_(buttonbarView);
        [self addSubview:_buttonbar];
    }

    return self;
}

- (id) initWithFrame:(FLRect) frame
{
	return [self initWithFrame:frame buttonbarView:autorelease_([[FLToolbarButtonbarView alloc] initWithFrame:frame])];
}

- (void) dealloc
{
	mrc_release_(_buttonbar);
	mrc_super_dealloc_();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	_buttonbar.newFrame = self.bounds;
}

@end