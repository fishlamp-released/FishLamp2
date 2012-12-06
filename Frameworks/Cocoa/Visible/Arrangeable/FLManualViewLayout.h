//
//  FLManualViewLayout.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLGeometry.h"

@class FLManualViewLayout;

typedef void (^FLManualViewLayoutBlock)(FLManualViewLayout* layout, SDKRect inBounds);

@interface FLManualViewLayout : NSObject {
@private
    NSMutableDictionary* _views;
    NSMutableDictionary* _frames;
    FLManualViewLayoutBlock _onLayout;
}

@property (readwrite, copy, nonatomic) FLManualViewLayoutBlock onLayout;

- (void) setView:(id) view forKey:(id) key;

- (SDKRect) layoutFrameForKey:(id) key;
- (void) setLayoutFrame:(SDKRect) frame forKey:(id) key;

- (void) updateFrames;
- (void) updateLayoutInBounds:(SDKRect) bounds;
- (void) applyLayout;

@end