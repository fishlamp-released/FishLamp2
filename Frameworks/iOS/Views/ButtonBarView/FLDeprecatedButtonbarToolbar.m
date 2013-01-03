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

- (id) initWithFrame:(CGRect)frame buttonbarView:(FLDeprecatedButtonbarView*) buttonbarView
{
	if((self = [super initWithFrame:frame]))
    {
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
		self.barStyle = UIBarStyleBlack;
		self.translucent = YES;
        
        _buttonbar = FLRetain(buttonbarView);
        [self addSubview:_buttonbar];
    }

    return self;
}

- (id) initWithFrame:(CGRect) frame
{
	return [self initWithFrame:frame buttonbarView:FLAutorelease([[FLToolbarButtonbarView alloc] initWithFrame:frame])];
}

- (void) dealloc
{
	FLRelease(_buttonbar);
	FLSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	_buttonbar.newFrame = self.bounds;
}

@end