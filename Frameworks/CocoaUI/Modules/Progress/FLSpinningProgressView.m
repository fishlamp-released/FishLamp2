//
//  FLSpinningProgressView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSpinningProgressView.h"

@implementation FLSpinningProgressView

- (id) initSpinningProgressView {
    [self setImageWithNameInBundle:@"chasingarrows.png"];
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    return [[super initWithCoder:aDecoder] initSpinningProgressView];
}

- (id)initWithFrame:(NSRect)frame {
    return [[super initWithFrame:frame] initSpinningProgressView];
}

@end

