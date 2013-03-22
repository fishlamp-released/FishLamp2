//
//  FLComeForwardAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLLayerAnimation.h"

@interface FLComeForwardAnimation : FLLayerAnimation {
@private
   CGFloat _scale;
}

@property (readwrite, assign, nonatomic) CGFloat scale;

+ (id) comeForwardAnimation;
@end
