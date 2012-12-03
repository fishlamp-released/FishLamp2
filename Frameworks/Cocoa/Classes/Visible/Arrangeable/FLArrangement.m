//
//  FLArrangement.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLArrangement.h"

// - (FLEdgeInsets) addInnerInsetsToOuterInsets:(FLEdgeInsets) innerInsets;

@implementation FLArrangement

@synthesize outerInsets = _outerInsets;
@synthesize innerInsets = _innerInsets;
@synthesize onWillArrange = _onWillArrange;
@synthesize frameSetter = _frameSetter;

+ (id) arrangement {
	return autorelease_([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
        self.frameSetter = [FLArrangement defaultFrameSetter];
    }
    
    return self;
}

#if DEBUG
- (void) dealloc {
    release_(_frameSetter);
    release_(_onWillArrange);
    super_dealloc_();
}
#endif

- (FLSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(FLRect) bounds {
    return bounds.size;
}

- (FLSize) performArrangement:(NSArray*) arrangeableFrames 
                inBounds:(FLRect) bounds {

    if(_onWillArrange) {
        _onWillArrange(self, bounds);
    }   
    
    FLSize layoutSize = [self layoutArrangeableObjects:arrangeableFrames
                                              inBounds:FLEdgeInsetsInsetRect(bounds, self.outerInsets)];
    
    layoutSize.width += (self.outerInsets.left + self.outerInsets.right);
    layoutSize.height += (self.outerInsets.top + self.outerInsets.bottom);
    return layoutSize;
}

- (FLEdgeInsets) addInnerInsetsToOuterInsets:(FLEdgeInsets) innerInsets {
    FLEdgeInsets insets = self.outerInsets;
    insets.top += innerInsets.top;
    insets.bottom -= innerInsets.bottom;
    insets.left += innerInsets.left;
    insets.right -= innerInsets.right;
	return insets;
}

NS_INLINE
FLRect FLArrangeableStateCalcFrame(FLArrangeableState state, FLRect frame) {
    if(FLRectEqualToRect(frame, state._lastFrame)) {
        frame.origin.x -= state._lastInsets.left;
        frame.origin.y -= state._lastInsets.top;
        frame.size.width += (state._lastInsets.left + state._lastInsets.right);
        frame.size.height += (state._lastInsets.top + state._lastInsets.bottom);
    }

    return frame;
}
- (FLRect) setFrame:(FLRect) frame
          forObject:(id) object {

    FLArrangeableState state = [object arrangeableState];
    FLEdgeInsets insets = [self addInnerInsetsToOuterInsets:state._lastInsets];
    FLRect newFrame = FLEdgeInsetsInsetRect(frame, insets);
    
    FLArrangeableGrowMode growMode = [object arrangeableGrowMode];
    
    if( growMode == FLArrangeableGrowModeGrowWidth ||
        growMode == FLArrangeableGrowModeGrowHeight) {
        FLSize size = newFrame.size;
        [object calculateArrangementSize:&size inSize:newFrame.size fillMode:growMode];
        
        newFrame.size = size;
    }
    
    if(!FLRectEqualToRect([object frame], newFrame)) {
        self.frameSetter(object, newFrame);
        state._lastInsets = insets;
        state._lastFrame = [object frame];
        [object setArrangeableState:state];
    }

    return frame;
}

- (FLRect) frameForObject:(id) object {
    return FLArrangeableStateCalcFrame([object arrangeableState], [object frame]);
}

//- (FLRect) padFrameForArrangeableFrame:(id) arrangeableFrame unpaddedRect:(FLRect) unpaddedRect {
//    
//    FLEdgeInsets padding = [self addouterInsetsToInsets:[arrangeableFrame innerInsets]];
//    unpaddedRect.origin.x += padding.left;
//    unpaddedRect.origin.y += padding.top;
//    unpaddedRect.size.width -= padding.left + padding.right;
//    unpaddedRect.size.height -= padding.top + padding.bottom;
//    return unpaddedRect;
//} 

static FLArrangementFrameSetter s_frameSetter = ^(id arrangeableFrame, FLRect frame) { 
        [arrangeableFrame setFrame:frame];
    };
    
+ (FLArrangementFrameSetter) defaultFrameSetter {
    return s_frameSetter;
}

static FLArrangementFrameSetter s_size_setter = ^(id arrangeableFrame, FLRect frame) { 
    [arrangeableFrame setFrame:FLRectOptimizedForViewSize(frame)];
};

+ (FLArrangementFrameSetter) optimizedForSizeFrameSetter {
    return s_size_setter;
}

static FLArrangementFrameSetter s_location_setter = ^(id arrangeableFrame, FLRect frame) { 
    [arrangeableFrame setFrame:FLRectOptimizedForViewLocation(frame)];
};

+ (FLArrangementFrameSetter) optimizedForLocationFrameSetter {
    return s_location_setter;
}



@end













