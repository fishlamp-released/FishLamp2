//
//  FLSpinningProgressView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSpinningProgressView.h"

#define CUSTOM_SPINNER 0

@implementation FLSpinningProgressView

#if FL_MRC
- (void) dealloc {
	[_spinner release];
	[super dealloc];
}
#endif

- (void) willInitAnimationLayer {

#if CUSTOM_SPINNER
    if(OSXVersionIsAtLeast10_8()) {
        [super willInitAnimationLayer];
        [self setImageWithNameInBundle:@"chasingarrows.png"];
    }
    else
#endif 
    {
        _spinner = [[NSProgressIndicator alloc] initWithFrame:CGRectZero];
        [_spinner setIndeterminate:YES];
        [_spinner setDisplayedWhenStopped:NO];
        [_spinner setStyle:NSProgressIndicatorSpinningStyle];
        [_spinner setBezeled: NO];
        [_spinner setControlSize:NSSmallControlSize];
        [_spinner setControlTint:NSDefaultControlTint];
        [_spinner sizeToFit];
        [self addSubview:_spinner];
    }
}

- (void) setFrame:(CGRect) frame {
    [super setFrame:frame];
    if(_spinner) {
    
    }
}


@end

