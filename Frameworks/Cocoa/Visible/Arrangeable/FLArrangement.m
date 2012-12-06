//
//  FLArrangement.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLArrangement.h"

// - (SDKEdgeInsets) addInnerInsetsToOuterInsets:(SDKEdgeInsets) innerInsets;

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

- (SDKSize) layoutArrangeableObjects:(NSArray*) objects
                           inBounds:(SDKRect) bounds {
    return bounds.size;
}

- (SDKSize) performArrangement:(NSArray*) arrangeableFrames 
                inBounds:(SDKRect) bounds {

    if(_onWillArrange) {
        _onWillArrange(self, bounds);
    }   
    
    SDKSize layoutSize = [self layoutArrangeableObjects:arrangeableFrames
                                              inBounds:FLRectInsetWithEdgeInsets(bounds, self.outerInsets)];
    
    layoutSize.width += (self.outerInsets.left + self.outerInsets.right);
    layoutSize.height += (self.outerInsets.top + self.outerInsets.bottom);
    return layoutSize;
}

- (SDKEdgeInsets) addInnerInsetsToOuterInsets:(SDKEdgeInsets) innerInsets {
    SDKEdgeInsets insets = self.outerInsets;
    insets.top += innerInsets.top;
    insets.bottom -= innerInsets.bottom;
    insets.left += innerInsets.left;
    insets.right -= innerInsets.right;
	return insets;
}

NS_INLINE
SDKRect FLArrangeableStateCalcFrame(FLArrangeableState state, SDKRect frame) {
    if(FLRectEqualToRect(frame, state._lastFrame)) {
        frame.origin.x -= state._lastInsets.left;
        frame.origin.y -= state._lastInsets.top;
        frame.size.width += (state._lastInsets.left + state._lastInsets.right);
        frame.size.height += (state._lastInsets.top + state._lastInsets.bottom);
    }

    return frame;
}
- (SDKRect) setFrame:(SDKRect) frame
          forObject:(id) object {

    FLArrangeableState state = [object arrangeableState];
    SDKEdgeInsets insets = [self addInnerInsetsToOuterInsets:state._lastInsets];
    SDKRect newFrame = FLRectInsetWithEdgeInsets(frame, insets);
    
    FLArrangeableGrowMode growMode = [object arrangeableGrowMode];
    
    if( growMode == FLArrangeableGrowModeGrowWidth ||
        growMode == FLArrangeableGrowModeGrowHeight) {
        SDKSize size = newFrame.size;
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

- (SDKRect) frameForObject:(id) object {
    return FLArrangeableStateCalcFrame([object arrangeableState], [object frame]);
}

//- (SDKRect) padFrameForArrangeableFrame:(id) arrangeableFrame unpaddedRect:(SDKRect) unpaddedRect {
//    
//    SDKEdgeInsets padding = [self addouterInsetsToInsets:[arrangeableFrame innerInsets]];
//    unpaddedRect.origin.x += padding.left;
//    unpaddedRect.origin.y += padding.top;
//    unpaddedRect.size.width -= padding.left + padding.right;
//    unpaddedRect.size.height -= padding.top + padding.bottom;
//    return unpaddedRect;
//} 

static FLArrangementFrameSetter s_frameSetter = ^(id arrangeableFrame, SDKRect frame) { 
        [arrangeableFrame setFrame:frame];
    };
    
+ (FLArrangementFrameSetter) defaultFrameSetter {
    return s_frameSetter;
}

static FLArrangementFrameSetter s_size_setter = ^(id arrangeableFrame, SDKRect frame) { 
    [arrangeableFrame setFrame:FLRectOptimizedForViewSize(frame)];
};

+ (FLArrangementFrameSetter) optimizedForSizeFrameSetter {
    return s_size_setter;
}

static FLArrangementFrameSetter s_location_setter = ^(id arrangeableFrame, SDKRect frame) { 
    [arrangeableFrame setFrame:FLRectOptimizedForViewLocation(frame)];
};

+ (FLArrangementFrameSetter) optimizedForLocationFrameSetter {
    return s_location_setter;
}



@end













