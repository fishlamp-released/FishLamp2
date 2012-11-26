//
//  UIView+FLArrangement.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FishLampCore.h"
#import "FLArrangeable.h"
#import "FLArrangeableContainer.h"

#import "NSObject+FLArrangeable.h"

@interface UIView (FLArrangeableContainer)
@property (readwrite, retain, nonatomic) FLArrangement* arrangement;
@end

@interface UIView (FLArrangeable)
@property (readwrite, assign, nonatomic) FLEdgeInsets innerInsets;
@property (readwrite, assign, nonatomic) FLArrangeableGrowMode arrangeableGrowMode;
@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;
@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;
@end

@interface UIView (FLArrangeableUtils)

- (id) lastSubviewByWeight:(FLArrangeableWeight) weight;

- (void) layoutSubviewsWithArrangement:(FLArrangement*) arrangement
                        adjustViewSize:(BOOL) adjustSize;

- (void) insertSubview:(UIView*) view
 withArrangeableWeight:(FLArrangeableWeight) weight;

- (void) calculateArrangementSize:(FLSize*) outSize
                           inSize:(FLSize) inSize
                         fillMode:(FLArrangeableGrowMode) fillMode;
@end

@interface UIView (FLMiscUtils)
- (void) visitSubviews:(void (^)(id view)) visitor;
- (FLRect) layoutBounds;
@end
