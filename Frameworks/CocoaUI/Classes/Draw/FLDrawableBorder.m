//
//  FLDrawableBorder.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDrawableBorder.h"

@implementation FLDrawableBorder

@synthesize borderColor = _borderColor;
@synthesize cornerRadius = _cornerRadius;
@synthesize lineWidth = _lineWidth;

- (void) drawRect:(CGRect) drawRect 
        withFrame:(CGRect) frame 
         inParent:(id) parent
drawEnclosedBlock:(void (^)(void)) drawEnclosedBlock {


}

@end
