//
//  FLView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLArrangeableContainer.h"
#import "FLArrangeable.h"

#import "UIView+FLArrangeable.h"

@interface FLArrangeableView : UIView<FLArrangeableContainer, FLArrangeable> {
@private
    FLArrangeableState _arrangeableState;
    FLArrangement* _arrangement;
}

// arrangeble container
@property (readwrite, retain, nonatomic) FLArrangement* arrangement;

// arrangeable
@property (readwrite, assign, nonatomic) FLEdgeInsets arrangeableInsets;

@property (readwrite, assign, nonatomic) FLArrangeableGrowMode arrangeableGrowMode;

@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;

@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;


@end