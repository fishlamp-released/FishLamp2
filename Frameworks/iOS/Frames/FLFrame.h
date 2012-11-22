//
//  FLFrame.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLArrangeable.h"
#import "FLControlState.h"

@interface FLFrame : NSObject<FLArrangeable> {
@private
    FLRect _frame;
    FLControlState _controlState;
    BOOL _hidden;
    
    FLArrangeableWeight _arrangeableWeight;
    FLArrangeableGrowMode _arrangeableGrowMode;
    FLEdgeInsets _arrangeableInsets;
    FLArrangeableState _arrangeableState;
}

@property (readwrite, assign, nonatomic) FLRect frame;

@property (readwrite, assign, nonatomic) FLControlState controlState;

@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;

@property (readwrite, assign, nonatomic, getter=isDoubleSelected) BOOL doubleSelected;

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted; 

@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled; 

@property (readonly, nonatomic) BOOL isFrameOptimized;

@property (readwrite, assign, nonatomic) FLRect frameOptimizedForLocation;

@property (readwrite, assign, nonatomic) FLRect frameOptimizedForSize;

@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden; 

- (id) initWithFrame:(FLRect) frame;

- (void) moveFrameBy:(FLPoint) offset;

- (BOOL) pointIsInside:(FLPoint)point;

- (void) didChangeFrame;

- (void) didChangeHidden;

@end
