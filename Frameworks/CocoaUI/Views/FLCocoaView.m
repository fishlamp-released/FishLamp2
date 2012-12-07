//
//  FLView.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaView.h"

@implementation FLCocoaView

@synthesize backgroundColor = _backgroundColor;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.backgroundColor = [NSColor whiteColor];
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

#if OSX
- (void) setNeedsLayout {
    [self setNeedsDisplay:YES];
}

- (void) setNeedsDisplay {
    [self setNeedsDisplay:YES];
}

- (BOOL) userInteractionEnabled {
    return NO;
}

- (void) setUserInteractionEnabled:(BOOL) enabled {

}
#endif


@end
