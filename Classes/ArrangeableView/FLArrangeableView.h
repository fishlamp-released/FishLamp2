//
//  FLView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+FLArrangeable.h"

@interface FLArrangeableView : UIView {
@private
    FLArrangeableState _arrangeableState;
    FLArrangement* _subviewArrangement;
}

@property (readwrite, retain, nonatomic) FLArrangement* subviewArrangement;

@property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets; // deltas from arrangement.arrangeableInsets

@property (readwrite, assign, nonatomic) FLArrangeableFillMode arrangeableFillMode;

@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;

@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;


@end
