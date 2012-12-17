//
//  FLView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLView.h"

@implementation FLView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#if OSX
- (void)drawRect:(NSRect)dirtyRect {
    // set any NSColor for filling, say white:
    UIColor* bgColor = self.backgroundColor;
    if(bgColor) {
        [bgColor setFill];
        NSRectFill(dirtyRect);
    }
}
#endif

@end
