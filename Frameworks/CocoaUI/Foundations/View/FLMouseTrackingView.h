//
//  FLMouseTrackingView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol FLMouseHandler <NSObject>
- (void) handleMouseMoved:(CGPoint) location mouseIn:(BOOL) mouseIn mouseDown:(BOOL) mouseDown;
- (void) handleMouseUpInside:(CGPoint) location;
@end

@interface FLMouseTrackingView : NSView<FLMouseHandler> {
@private
    NSTrackingArea* _trackingArea;
    BOOL _mouseIn;
    BOOL _mouseDown;
}

- (void) handleMouseMoved:(CGPoint) location mouseIn:(BOOL) mouseIn mouseDown:(BOOL) mouseDown;
- (void) handleMouseUpInside:(CGPoint) location;

@end