//
//  FLComeForwardAnimation.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@interface FLComeForwardAnimation : FLAnimation {
@private
   CGFloat _scale;
}

@property (readwrite, assign, nonatomic) CGFloat scale;

@end
