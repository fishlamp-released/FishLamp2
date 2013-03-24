//
//  FLArrangeableView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//


#import "FLArrangeableContainer.h"
#import "FLArrangeable.h"
#import "SDKView+FLArrangeable.h"

@interface FLArrangeableView : SDKView<FLArrangeableContainer, FLArrangeable> {
@private
    FLArrangeableState _arrangeableState;
    FLArrangement* _arrangement;
    UIEdgeInsets _arrangeableInsets;
    FLArrangeableGrowMode _arrangeableGrowMode;
    FLArrangeableWeight _arrangeableWeight;
}

// arrangeble container
@property (readwrite, retain, nonatomic) FLArrangement* arrangement;

// arrangeable
@property (readwrite, assign, nonatomic) UIEdgeInsets arrangeableInsets;

@property (readwrite, assign, nonatomic) FLArrangeableGrowMode arrangeableGrowMode;

@property (readwrite, assign, nonatomic) FLArrangeableWeight arrangeableWeight;

@property (readwrite, assign, nonatomic) FLArrangeableState arrangeableState;


@end
