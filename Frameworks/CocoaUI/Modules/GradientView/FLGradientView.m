//
//	FLGradientView.m
//	ShadowedTableView
//
//	Created by Matt Gallagher on 2009/08/21.
//	Copyright 2009 Matt Gallagher. All rights reserved.
//

#import "FLGradientView.h"

@implementation FLGradientView

#if IOS
@synthesize gradient = _gradientWidget;
#endif

#if FL_MRC
- (void) dealloc {
#if IOS
	[_gradientWidget release];
#endif    
	[super dealloc];
}
#endif


- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {	

#if IOS
        self.wantsApplyTheme = YES;
        _gradientWidget = [[FLGradientWidget alloc] initWithFrame:frame];
        _gradientWidget.contentMode = FLRectLayoutFill;
        [self addWidget:_gradientWidget];
#endif        
    }
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self.backgroundColor = [UIColor clearColor];

	if ((self = [super initWithCoder:aDecoder])) {
#if IOS
        _gradientWidget = [[FLGradientWidget alloc] initWithFrame:self.bounds];
        _gradientWidget.contentMode = FLRectLayoutFill;
        [self addWidget:_gradientWidget];
#endif        
    }
	return self;
}

- (BOOL) isHighlighted {
#if IOS
    return _gradientWidget.isHighlighted;
#else 
    return NO;
#endif
}

- (void) setHighlighted:(BOOL) highlighted {
#if IOS
    _gradientWidget.highlighted = highlighted;
#endif    
}

- (void) setColorRange:(FLColorRange*) range forControlState:(UIControlState) state {
#if IOS
    [_gradientWidget setColorRange:range forControlState:state];
#endif    
}

// returns normal if a colorRange isn't set for state;
- (FLColorRange*) colorRangeForControlState:(UIControlState) state {
#if IOS
    return [_gradientWidget colorRangeForControlState:state];
#else
    return nil;
#endif
}
@end

@implementation FLBlackGradientView

- (id) initWithFrame:(CGRect) frame
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
