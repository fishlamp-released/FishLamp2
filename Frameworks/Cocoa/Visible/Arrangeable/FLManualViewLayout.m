//
//  FLManualViewLayout.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLManualViewLayout.h"
#import "SDKCompatibility.h"

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
    release_(_onLayout);
    release_(_views);
    release_(_frames);
    super_dealloc_();
}
#endif

- (void) setView:(id) view forKey:(id) key {
    [_views setObject:view forKey:key];
}

- (SDKRect) layoutFrameForKey:(id) key {
    NSValue* val = [_frames objectForKey:key];
    if(!val) {
        id view = [_views objectForKey:key];
        if(view) {
            val = [NSValue valueWithSDKRect:[view frame]];
            [_frames setObject:val forKey:key];
        }
    }

    return val ? [val SDKRectValue] : FLRectZero;

}

- (void) setLayoutFrame:(SDKRect) frame forKey:(id) key {
    [_frames setObject:[NSValue valueWithSDKRect:frame] forKey:key];
}

- (void) updateLayoutInBounds:(SDKRect) bounds {
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
            [view setFrame:[val SDKRectValue]];
        }
    }
}


@end
