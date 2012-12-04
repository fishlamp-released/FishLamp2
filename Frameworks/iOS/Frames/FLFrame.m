//
//  FLFrame.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFrame.h"

@implementation FLFrame

//@synthesize tag = _tag;
@synthesize controlState = _controlState;
@synthesize frame = _frame;
@synthesize hidden = _hidden;
@synthesize arrangeableWeight = _arrangeableWeight;
@synthesize arrangeableGrowMode = _arrangeableGrowMode;
@synthesize arrangeableInsets = _arrangeableInsets;
@synthesize arrangeableState = _arrangeableState;

- (FLRect) arrangeableFrame {
    return self.frame;
}

- (void) setArrangeableFrame:(FLRect) frame {
    self.frame = frame;
}

- (id) initWithFrame:(FLRect) rect {
    self = [super init];
    if(self) {
        self.frame = rect;
    }
    return self;
}

- (id) init {
    self = [self initWithFrame:FLRectZero];
    if(self) {
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

- (BOOL) pointIsInside:(FLPoint)point {
	return CGRectContainsPoint(self.frame, point);
}	

- (FLRect) frameOptimizedForLocation {
	return FLRectOptimizedForViewLocation(self.frame);
}

- (void) setFrameOptimizedForLocation:(FLRect) frame {
	self.frame = FLRectOptimizedForViewLocation(frame);
}

- (FLRect) frameOptimizedForSize {
	return FLRectOptimizedForViewSize(self.frame);
}

- (void) setFrameOptimizedForSize:(FLRect) frame {
	self.frame = FLRectOptimizedForViewSize(frame);
}

- (BOOL) isFrameOptimized {
	return FLRectIsOptimizedForView(self.frame);
}

- (void) moveFrameBy:(FLPoint) offset {
	self.frame = FLRectMoveWithPoint(self.frame, offset);
}

- (void) didChangeFrame {
}

- (void) setFrame:(FLRect) frame {

    if(!CGRectEqualToRect(self.frame, frame)) {
        _frame = frame;
        [self didChangeFrame];
    }
}

- (BOOL) isHighlighted {
	return FLTestBits(_controlState, FLControlStateHighlighted);
}

- (void) setHighlighted:(BOOL) highlighted {
    FLSetOrClearBits(_controlState, FLControlStateHighlighted, highlighted);
}

- (BOOL) isSelected {
	return FLTestBits(_controlState, FLControlStateSelected);
}

- (BOOL) isDoubleSelected {
	return FLTestBits(_controlState, FLControlStateDoubleSelected);
}

- (void) setSelected:(BOOL) selected {
    FLSetOrClearBits(_controlState, FLControlStateSelected, selected);
}

- (void) setDoubleSelected:(BOOL) selected {
    FLSetOrClearBits(_controlState, FLControlStateDoubleSelected, selected);
}

- (BOOL) isDisabled {
	return FLTestBits(_controlState, FLControlStateDisabled);
}

- (void) setDisabled:(BOOL) disabled {
    FLSetOrClearBits(_controlState, FLControlStateDisabled, disabled);
}

- (void) calculateArrangementSize:(FLSize*) outSize
                           inSize:(FLSize) inSize
                         fillMode:(FLArrangeableGrowMode) growMode {
}

@end
