//
//  FLView.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLView.h"

#if OSX

@implementation FLView

@synthesize backgroundColor = _backgroundColor;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_backgroundColor release];
    [super dealloc];
}
#endif

- (void)drawRect:(NSRect)dirtyRect {
    // set any NSColor for filling, say white:
    if(_backgroundColor) {
        [_backgroundColor setFill];
        NSRectFill(dirtyRect);
    }
}

@end
#endif


