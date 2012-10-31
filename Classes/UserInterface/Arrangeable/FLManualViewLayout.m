//
//  FLManualViewLayout.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLManualViewLayout.h"


@implementation FLManualViewLayout

@synthesize onLayout = _onLayout;

- (id) init {
    self = [super init];
    if(self) {
        _views = [[NSMutableDictionary alloc] init];
        _frames = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    mrc_release_(_onLayout);
    mrc_release_(_views);
    mrc_release_(_frames);
    mrc_super_dealloc_();
}
#endif

- (void) setView:(id) view forKey:(id) key {
    [_views setObject:view forKey:key];
}

- (FLRect) layoutFrameForKey:(id) key {
    NSValue* val = [_frames objectForKey:key];
    if(!val) {
        id view = [_views objectForKey:key];
        if(view) {
            val = [NSValue valueWithFLRect:[view frame]];
            [_frames setObject:val forKey:key];
        }
    }

    return val ? [val FLRectValue] : FLRectZero;

}

- (void) setLayoutFrame:(FLRect) frame forKey:(id) key {
    [_frames setObject:[NSValue valueWithFLRect:frame] forKey:key];
}

- (void) updateLayoutInBounds:(FLRect) bounds {
    if(_onLayout) {
        _onLayout(self, bounds);
    }
}

- (void) updateFrames {
    for(id key in _views) {
        id view = [_views objectForKey:key];
        if(view) {
            [self setLayoutFrame:[view frame] forKey:key];
        }
    }
}

- (void) applyLayout {
    for(id key in _frames) {
        id view = [_views objectForKey:key];
        NSValue* val = [_frames objectForKey:key];
        if(val) {
            [view setFrame:[val FLRectValue]];
        }
    }
}


@end
