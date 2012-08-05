//
//  UIView+FLArrangement.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "UIView+FLArrangeable.h"

#import "FLArrangeable.h"

#import <objc/runtime.h>

static void * const kArrangementKey = (void*)&kArrangementKey;

@implementation UIView (FLArrangeable)

@dynamic arrangeableInsets;
@dynamic arrangeableFillMode;
@dynamic arrangeableWeight;
@dynamic arrangeableState;

-(void) visitSubviews:(void (^)(id view)) visitor {
	for(UIView* view in self.subviews) {
		if(!view.isHidden) {
			[view visitSubviews:visitor];
			visitor(view);
		}
	}
}

- (id) lastSubviewByWeight:(FLArrangeableWeight) weight {
    return [FLArrangeableObject lastSubframeByWeight:weight subframes:self.subviews];
}

- (void) layoutSubviewsWithArrangement:(FLArrangement*) arrangement
                        adjustViewSize:(BOOL) adjustSize {
    NSArray* subviews = self.subviews;
    if(arrangement) {
        CGRect bounds = self.bounds;
        bounds.size = [arrangement performArrangement:subviews inBounds:bounds];
        if(adjustSize) {
            self.bounds = bounds;
        }
    }

    for(id subview in subviews) {
        [subview layoutSubviewsWithArrangement:[subview subviewArrangement]
                                  adjustViewSize:YES];
    }
}

- (void) insertSubview:(UIView*) view
  withArrangeableWeight:(FLArrangeableWeight) weight {
    UIView* subview = [self lastSubviewByWeight:weight];
    if(subview) {
        [self insertSubview:view aboveSubview:subview];
    }
    else {
        [self addSubview:view];
    }
}

- (FLArrangement*) subviewArrangement {
    return objc_getAssociatedObject(self, kArrangementKey);
}

- (void) setSubviewArrangement:(FLArrangement*) arrangement {
    objc_setAssociatedObject(self, kArrangementKey, arrangement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableFillMode) fillMode {
}

- (FLRect) layoutBounds {
    return FLEdgeInsetsInsetRect(self.bounds, self.arrangeableInsets);
}

@end
