//
//  FLArrangement.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLArrangement.h"

// - (FLEdgeInsets) addArrangementFrameInsetsToInsets:(FLEdgeInsets) arrangeableInsets;

@implementation FLArrangement

@synthesize arrangementInsets = _arrangementInsets;
@synthesize arrangeableInsets = _arrangeableInsets;
@synthesize onWillArrange = _onWillArrange;
@synthesize frameSetter = _frameSetter;

+ (id) arrangement {
	return FLReturnAutoreleased([[[self class] alloc] init]);
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
    FLRelease(_frameSetter);
    FLRelease(_onWillArrange);
    FLSuperDealloc();
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
    
    FLSize layoutSize = [self performArrangement:arrangeableFrames
                                   inBounds:FLEdgeInsetsInsetRect(bounds, self.arrangementInsets)];
    
    layoutSize.width += (self.arrangementInsets.left + self.arrangementInsets.right);
    layoutSize.height += (self.arrangementInsets.top + self.arrangementInsets.bottom);
    return layoutSize;
}

- (FLEdgeInsets) addArrangementFrameInsetsToInsets:(FLEdgeInsets) arrangeableInsets {
    FLEdgeInsets padding = self.arrangeableInsets;
    padding.top += arrangeableInsets.top;
    padding.bottom += arrangeableInsets.bottom;
    padding.left += arrangeableInsets.left;
    padding.right += arrangeableInsets.right;
	return padding;
}

NS_INLINE
FLRect FLArrangeableStateCalcFrame(FLArrangeableState state, CGRect frame) {
    if(FLRectEqualToRect(frame, state._lastFrame)) {
        frame.origin.x -= state._lastInsets.left;
        frame.origin.y -= state._lastInsets.top;
        frame.size.width += (state._lastInsets.left + state._lastInsets.right);
        frame.size.height += (state._lastInsets.top + state._lastInsets.bottom);
    }

    return frame;
}
- (FLRect) setArrangeableFrame:(FLRect) frame
                     forObject:(id) object {

    FLArrangeableState state = [object arrangeableState];
    FLEdgeInsets insets = [self addArrangementFrameInsetsToInsets:state.arrangeableInsets];
    CGRect newFrame = FLEdgeInsetsInsetRect(frame, insets);
    
    if( state.arrangeableFillMode == FLArrangeableFillModeGrowWidth ||
        state.arrangeableFillMode == FLArrangeableFillModeGrowHeight) {
        FLSize size = newFrame.size;
        [object calculateArrangementSize:&size inSize:newFrame.size fillMode:state.arrangeableFillMode];
        
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

- (FLRect) arrangeableFrameForObject:(id) object {
    return FLArrangeableStateCalcFrame([object arrangeableState], [object frame]);
}

//- (FLRect) padFrameForArrangeableFrame:(id) arrangeableFrame unpaddedRect:(FLRect) unpaddedRect {
//    
//    FLEdgeInsets padding = [self addArrangementInsetsToInsets:[arrangeableFrame arrangeableInsets]];
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













