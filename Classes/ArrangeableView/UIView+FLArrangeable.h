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
#import "NSObject+FLArrangeable.h"

@interface UIView (FLArrangeable)

@property (readwrite, retain, nonatomic) FLArrangement* subviewArrangement;

@property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets;
@property (readwrite, assign, nonatomic) FLArrangeableFillMode arrangeableFillMode;
@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;
@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;

- (id) lastSubviewByWeight:(FLArrangeableWeight) weight;

- (void) layoutSubviewsWithArrangement:(FLArrangement*) arrangement
                        adjustViewSize:(BOOL) adjustSize;

- (void) visitSubviews:(void (^)(id view)) visitor;

- (void) insertSubview:(UIView*) view
 withArrangeableWeight:(FLArrangeableWeight) weight;

- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableFillMode) fillMode;

- (FLRect) layoutBounds;

@end
