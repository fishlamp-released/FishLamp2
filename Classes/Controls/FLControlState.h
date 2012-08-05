//
//  FLControlState.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO: simplify this


enum {
    FLControlStateNormal                =   0,                       
    FLControlStateHighlighted           =   UIControlStateHighlighted,                  
    FLControlStateDisabled              =   UIControlStateDisabled,
    FLControlStateSelected              =   UIControlStateSelected,                  
    FLControlStateDoubleSelected        =   (1 << 3), // user clicks on an already selected item.                  

    FLControlStateAll                   =   FLControlStateHighlighted | 
                                            FLControlStateDisabled | 
                                            FLControlStateSelected |
                                            FLControlStateDoubleSelected
};
typedef NSUInteger FLControlStateMask;

@class FLControlState;

@protocol FLControlStateObserver <NSObject>
- (void) controlStateDidChangeState:(FLControlState*) state 
                       changedState:(FLControlStateMask) changedState;
@end

@interface FLControlState : NSObject<FLControlStateObserver> {
@private
    FLControlStateMask _controlState;
    FLControlStateMask _previousControlState;
    FLControlStateMask _enabledControlStates;
    NSMutableArray* _observers;
}

@property (readwrite, assign, nonatomic) FLControlStateMask enabledControlStates; // FLFrameAll by default

@property (readonly, assign, nonatomic) FLControlStateMask previousControlState;

@property (readwrite, assign, nonatomic) FLControlStateMask controlStateMask;

@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;

@property (readwrite, assign, nonatomic, getter=isDoubleSelected) BOOL doubleSelected;

@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted; 

@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled; 

- (void) controlStateDidChange:(FLControlStateMask) changedState;

// NOT RETAINED
- (void) addControlStateObserver:(id<FLControlStateObserver>) observer;
- (void) removeControlStateObserver:(id<FLControlStateObserver>) observer;

@end

