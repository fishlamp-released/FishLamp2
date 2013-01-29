//
//  ZFTextField.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFTextField.h"

@implementation ZFTextField

- (void) setToZenfolioStyle {
    self.font = [NSFont zenfolioLabelFont];
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super init];
    if(self) {
        [self setToZenfolioStyle];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setToZenfolioStyle];
    }
    
    return self;
}

@end
