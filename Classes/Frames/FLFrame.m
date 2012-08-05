//
//  FLFrame.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFrame.h"

@implementation FLFrame

@synthesize tag = _tag;
@synthesize contentMode = _contentMode;
@synthesize controlState = _controlState;

- (id) initWithFrame:(CGRect) frame {   
    self = [super initWithFrame:frame];
	if(self) {
        _controlState = [[FLControlState alloc] init];
        [_controlState addControlStateObserver:self];
	}
	
	return self;
}

- (id) init {
    self = [super init]; 
    if(self) {
        _controlState = [[FLControlState alloc] init];
        [_controlState addControlStateObserver:self];
    }
    return self;
}

- (void) didChangeHidden {
}

- (void) setHidden:(BOOL) hidden {
    if(self.isHidden != hidden) {
        self.hidden = hidden;
        [self didChangeHidden];
    }
}

- (BOOL) pointIsInside:(CGPoint)point {
	return CGRectContainsPoint(self.frame, point);
}	

- (CGRect) frameOptimizedForLocation {
	return FLRectOptimizedForViewLocation(self.frame);
}

- (void) setFrameOptimizedForLocation:(CGRect) frame {
	self.frame = FLRectOptimizedForViewLocation(frame);
}

- (CGRect) frameOptimizedForSize {
	return FLRectOptimizedForViewSize(self.frame);
}

- (void) setFrameOptimizedForSize:(CGRect) frame {
	self.frame = FLRectOptimizedForViewSize(frame);
}

- (BOOL) isFrameOptimized {
	return FLRectIsOptimizedForView(self.frame);
}

- (void) moveFrameBy:(CGPoint) offset {
	self.frame = FLRectMoveWithPoint(self.frame, offset);
}

- (void) didChangeFrame {
}

- (void) setFrame:(CGRect) frame {

    if(!CGRectEqualToRect(self.frame, frame)) {
        [super setFrame:frame];
        [self didChangeFrame];
    }
}

- (void) autoPositionInRect:(CGRect) bounds {
    self.frameOptimizedForLocation = FLRectPositionRectInRectWithContentMode(bounds, self.frame, self.contentMode);
}

- (void) controlStateDidChangeState:(FLControlState*) state 
                       changedState:(FLControlStateMask) changedState {
}

- (void) setControlState:(FLControlState*) state {
    if(_controlState) {
        [_controlState removeControlStateObserver:self];
    }
    
    FLAssignObject(_controlState, state);
    
    [_controlState addControlStateObserver:self];
}

- (FLControlStateMask) controlStateMask {
    return _controlState.controlStateMask;
}

- (void) setControlStateMask:(FLControlStateMask) controlState {
    _controlState.controlStateMask = controlState;
}

#if FL_DEALLOC
- (void) dealloc {
    [_controlState release];
    [super dealloc];
}

#endif

- (BOOL) isHighlighted {
	return _controlState.isHighlighted;
}

- (void) setHighlighted:(BOOL) highlighted {
    _controlState.highlighted = highlighted;
}

- (BOOL) isSelected {
	return _controlState.isSelected;
}

- (BOOL) isDoubleSelected {
	return _controlState.isDoubleSelected;
}

- (void) setSelected:(BOOL) selected {
    _controlState.selected = selected;
}

- (void) setDoubleSelected:(BOOL) selected {
    _controlState.doubleSelected = selected;
}

- (BOOL) isDisabled {
	return _controlState.isDisabled;
}

- (void) setDisabled:(BOOL) disabled {
    _controlState.disabled = disabled;
}

- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableFillMode) fillMode {
}

@end
