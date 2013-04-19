//
//  FLCocos2d.m
//  FishLampAnimation
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocos2d.h"

void FLInitCocos2d() {
    static BOOL initialized = NO;
    if(!initialized) {
        [CCGLView load_];
    }
}

