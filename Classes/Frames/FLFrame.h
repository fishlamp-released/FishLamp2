//
//  FLFrame.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLContentMode.h"
#import "FLArrangeable.h"
#import "FLArrangeable.h"

// TODO: simplify this
#import "FLControlState.h"

@interface FLFrame : FLArrangeableObject<FLArrangeable, FLControlStateObserver> {
@private
    FLContentMode _contentMode;
    FLControlState* _controlState;
    NSUInteger _tag;
}

@property (readwrite, assign, nonatomic) NSUInteger tag;

@property (readwrite, strong, nonatomic) FLControlState* controlState;

@property (readwrite, assign, nonatomic) FLControlStateMask controlStateMask;

@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;

@property (readwrite, assign, nonatomic, getter=isDoubleSelected) BOOL doubleSelected;

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted; 

@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled; 

@property (readonly, assign, nonatomic) BOOL isFrameOptimized;

@property (readwrite, assign, nonatomic) CGRect frameOptimizedForLocation;

@property (readwrite, assign, nonatomic) CGRect frameOptimizedForSize;

@property (readwrite, assign, nonatomic) FLContentMode contentMode;

@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden; 

- (id) initWithFrame:(CGRect) frame;

- (void) moveFrameBy:(CGPoint) offset;

- (BOOL) pointIsInside:(CGPoint)point;

- (void) didChangeFrame;

- (void) didChangeHidden;

- (void) autoPositionInRect:(CGRect) bounds;

@end
