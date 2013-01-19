//
//  FLBreadcrumbBarView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLBreadcrumbBarView.h"
#import "FLCoreText.h"
#import "FLColorRange+Gradients.h"

@interface FLBreadcrumbBarView ()
@property (readwrite, strong, nonatomic) NSTrackingArea* trackingArea;
@end

@implementation FLBreadcrumbBarView

@synthesize trackingArea = _trackingArea;
@synthesize title = _title;
@synthesize touched = _touched;
@synthesize key = _key;


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _shape = [[FLDrawableForwardButtonShape alloc] init];
        _shape.edgeInset = 1.0;
        _shape.edgeInsetColor = [NSColor grayColor];
        _shape.cornerRadius = 1.0;
        _shape.shapeSize = 10.0;
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_key release];
    [_trackingArea release];
    [_touched release];
    [_title release];
    [super dealloc];
}
#endif

- (BOOL) isEnabled {
    return _title.isEnabled;
}

- (void) setEnabled:(BOOL) enabled {
    _title.enabled = enabled;
     [self setNeedsDisplay];
}

- (void) setEmphasized:(BOOL)representsVisibleView {
    _title.emphasized = representsVisibleView;
     [self setNeedsDisplay];
}

- (BOOL) isEmphasized {
    return _title.emphasized;
}

- (void) setHighlighted:(BOOL)highlighted {
    _title.highlighted = highlighted;
     [self setNeedsDisplay];
}

- (BOOL) isHighlighted {
    return _title.isHighlighted;
}

- (void) didLayout {

    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }

    _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:
                                                    NSTrackingMouseEnteredAndExited | 
                                                    NSTrackingMouseMoved | 
                                                    NSTrackingActiveAlways | 
                                                    NSTrackingAssumeInside
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
    [self setNeedsDisplay];
}


- (void)mouseEntered:(NSEvent *)event  {
    NSPoint location = [self convertPoint:[event locationInWindow] fromView:nil];
    // Do whatever you want to do in response to mouse entering

    if(CGRectContainsPoint(self.bounds, location)) {
        if(self.isEnabled && !self.isEmphasized) {
            _mouseIn = YES;
            [self setNeedsDisplay];
        }
    }
}
- (void) updateMouseState {

    if(self.isEnabled && !self.isEmphasized) {
    FLLog(@"tracking mouse");
        self.highlighted = _mouseIn && _mouseDown;
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    _mouseDown = YES;
    [self updateMouseState];
}

- (void)mouseUp:(NSEvent *)theEvent {
    _mouseDown = NO;
    [self updateMouseState];

    if(_mouseIn) {
        if(_touched) {
            _touched();
        }
    }
}

- (void) mouseDragged:(NSEvent *)event {

    NSPoint location = [self convertPoint:[event locationInWindow] fromView:nil]; 
    _mouseIn = CGRectContainsPoint(self.bounds, location);
    [self updateMouseState];
}

- (void)mouseExited:(NSEvent *)event {
    NSPoint location = [self convertPoint:[event locationInWindow] fromView:nil];
    // Do whatever you want to do in response to mouse exiting
    if(!CGRectContainsPoint(self.bounds, location)) {
        _mouseIn = NO;
        [self setNeedsDisplay];
    }
}
//
//- (void)mouseMoved:(NSEvent *)event {
//    [self updateMouseState];
//    NSPoint location = [self convertPoint:[event locationInWindow] fromView:nil];
//    // Do whatever you want to do in response to mouse movements
//
////    if(CGRectContainsPoint(self.bounds, location)) {
////    }
//}

- (void)drawRect:(NSRect)dirtyRect {
    
    if(self.isEmphasized) {
        _shape.backgroundColor = [NSColor gray85Color];
    }
    else if(self.isHighlighted) {
        _shape.backgroundColor = [NSColor grayColor];
    }
    else {
        _shape.backgroundColor = [NSColor gray95Color];
    }
    
    [_shape drawRect:dirtyRect withFrame:self.bounds inParent:self drawEnclosedBlock:^{
        FLTextAlignment align = { FLVerticalTextAlignmentCenter, FLHorizontalTextAlignmentCenter };
        [FLCoreText drawString:[self.title attributedString] withTextAlignment:align inBounds:self.bounds];
    }];


    
//    CGContextSaveGState(context);
//    CGContextSetLineCap(context, kCGLineCapSquare);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextSetLineWidth(context, 1.0);
//    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
//    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);        
 
    
}



@end
