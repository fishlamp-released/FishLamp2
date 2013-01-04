//
//  FLStatusBar.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStatusBarView.h"

@implementation FLStatusBarView

- (id) init {
    self = [super init];
    if(self) {
        _string = [[FLDrawableString alloc] initWithString:@"Hello world"]; 
    }
    return self;
}

- (void) drawRect:(CGRect) rect {
    [_string drawRect:rect withFrame:self.bounds inParent:self drawEnclosedBlock:nil];
}

@end
