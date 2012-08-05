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
@synthesize subviewArrangement = _subviewArrangement;
FLSynthesizeStructProperty(arrangeableInsets, setArrangeableInsets, FLEdgeInsets, _arrangeableState);
FLSynthesizeStructProperty(arrangeableFillMode, setArrangeableFillMode, FLArrangeableFillMode, _arrangeableState);
FLSynthesizeStructProperty(arrangeableWeight, setArrangeableWeight, FLArrangeableWeight, _arrangeableState);

- (id) initWithFrame:(FLRect) frame {
    self = [super init];
    if(self) {
        self.autoresizesSubviews = NO;
    }
    
    return self;
}

#if FL_DEALLOC
- (void) dealloc {
    [_subviewArrangement release];
    [super dealloc];
}
#endif



@end
