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

@implementation NSView (FLCompatibility)

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


@end

#endif


@implementation SDKViewController (FLNibLoading)

- (NSString*) defaultNibName {
#if OSX
    return [NSString stringWithFormat:@"%@-OSX", NSStringFromClass([self class])];
#else 
    return [NSString stringWithFormat:@"%@-iOS", NSStringFromClass([self class])];
#endif    
}

- (id) initWithDefaultNibName {
    return [self initWithNibName:self.defaultNibName bundle:nil];
}

- (id) initWithDefaultNibName:(NSBundle *)nibBundleOrNil {
    return [self initWithNibName:self.defaultNibName bundle:nibBundleOrNil];
}


@end