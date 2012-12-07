//
//  FLView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLArrangeableView.h"

@implementation FLArrangeableView

@synthesize arrangeableState = _arrangeableState;
@synthesize arrangeableInsets = _arrangeableInsets;
@synthesize arrangeableGrowMode = _arrangeableGrowMode;
@synthesize arrangeableWeight = _arrangeableWeight;
@synthesize arrangement = _arrangement;

@dynamic bounds;
@dynamic arrangeables;
@dynamic hidden;
@dynamic arrangeableFrame;

- (id) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.autoresizesSubviews = NO;
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_arrangement);
    super_dealloc_();
}
#endif


@end
