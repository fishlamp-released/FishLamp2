//
//	FLGradientView.m
//	ShadowedTableView
//
//	Created by Matt Gallagher on 2009/08/21.
//	Copyright 2009 Matt Gallagher. All rights reserved.
//

#import "FLGradientView.h"

@implementation FLGradientView

@synthesize gradient = _gradientWidget;

- (void) dealloc {
	mrc_release_(_gradientWidget);
	mrc_super_dealloc_();
}

- (void) applyTheme:(FLTheme*) theme {

//	[self setColorRange:[FLColorRange colorRange:self.gradientStartColor endColor:self.gradientEndColor] forControlState:UIControlStateNormal];
}

- (id)initWithFrame:(FLRect)frame {
	if ((self = [super initWithFrame:frame])) {	
        self.wantsApplyTheme = YES;

        _gradientWidget = [[FLGradientWidget alloc] initWithFrame:frame];
        _gradientWidget.contentMode = FLContentModeFill;
        [self addWidget:_gradientWidget];
    }
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self.backgroundColor = [UIColor clearColor];

	if ((self = [super initWithCoder:aDecoder])) {
        _gradientWidget = [[FLGradientWidget alloc] initWithFrame:self.bounds];
        _gradientWidget.contentMode = FLContentModeFill;
        [self addWidget:_gradientWidget];
    }
	return self;
}

- (BOOL) isHighlighted {
    return _gradientWidget.isHighlighted;
}

- (void) setHighlighted:(BOOL) highlighted {
    _gradientWidget.highlighted = highlighted;
}

- (void) setColorRange:(FLColorRange*) range forControlState:(UIControlState) state {
    [_gradientWidget setColorRange:range forControlState:state];
}

// returns normal if a colorRange isn't set for state;
- (FLColorRange*) colorRangeForControlState:(UIControlState) state {
    return [_gradientWidget colorRangeForControlState:state];
}
@end

@implementation FLBlackGradientView

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor darkDarkBlueTintedGrayColor];
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder]))
	{
		self.backgroundColor = [UIColor darkDarkBlueTintedGrayColor];
	}
	
	return self;
}



@end
