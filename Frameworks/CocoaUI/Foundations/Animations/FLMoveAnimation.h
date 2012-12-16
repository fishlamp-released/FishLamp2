//
//  FLMoveAnimation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLAnimation.h"

@interface FLMoveAnimation : FLAnimation {
@private
    CGRect _fromFrame;
    CGRect _destinationFrame;
}

@property (readonly, assign, nonatomic) CGRect fromFrame;
@property (readwrite, assign, nonatomic) CGRect destinationFrame;

@end

@interface FLSlideInFromRightAnimation : FLMoveAnimation {
}
@end

@interface FLSlideOutToRightAnimation : FLMoveAnimation {
}
@end