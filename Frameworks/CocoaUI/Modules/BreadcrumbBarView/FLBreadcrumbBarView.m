//
//  FLBreadcrumbBarView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLBreadcrumbBarView.h"
#import "FLCoreText.h"
#import "FLColorRange+Gradients.h"

@interface FLBreadcrumbBarView ()
@property (readwrite, strong, nonatomic) NSTrackingArea* trackingArea;
@end



@implementation FLBreadcrumbBarView

@synthesize trackingArea = _trackingArea;
@synthesize title = _title;
@synthesize touchedBlock = _touchedBlock;
@synthesize key = _key;
@synthesize enabled = _enabled;
@synthesize emphasized = _emphasized;
@synthesize highlighted = _highlighted;
@synthesize titleStyle = _titleStyle;
@synthesize drawTopLine = _drawTopLine;
@synthesize lineColor = _lineColor;

- (id) initWithFrame:(NSRect) rect {
    self = [super initWithFrame:rect];
    if(self) {
//        self.wantsLayer = YES;
//        self.layer.borderColor = [NSColor NSColorToCGColor:[NSColor whiteColor]];
//        self.layer.cornerRadius = 0.0f;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_lineColor release];
    [_titleStyle release];
    [_key release];
    [_trackingArea release];
    [_touchedBlock release];
    [_title release];
    [super dealloc];
}
#endif


- (void) setEnabled:(BOOL) enabled {
    _enabled = enabled;
     [self setNeedsDisplay];
}

- (void) setEmphasized:(BOOL)emphasized {
    _emphasized = emphasized;
    [self setNeedsDisplay];
}

- (void) setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

- (void) didLayout {

    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    
    NSTrackingAreaOptions trackingOptions =         NSTrackingMouseEnteredAndExited | 
                                                    NSTrackingMouseMoved | 
                                                    NSTrackingActiveAlways | 
                                                    NSTrackingAssumeInside |
                                                    NSTrackingEnabledDuringMouseDrag;
                                            
    _trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                 options:trackingOptions
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
    [self setNeedsDisplay];
}

- (void) updateMouseState {

    if(self.isEnabled && !self.isEmphasized) {
//FLLog(@"updating mouse state");

        if(_mouseDown) {
//            self.layer.cornerRadius = 0.0f;
            self.highlighted = _mouseIn && _mouseDown;
        }
        else {
//            if(_mouseIn) {
//                self.layer.cornerRadius = 1.0f;
//            }
//            else {
//                self.layer.cornerRadius = 0.0f;
//            }
        } 
        
        [self setNeedsDisplay];
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
        if(_touchedBlock) {
            _touchedBlock(self);
        }
    }
}

- (void) mouseUpdate:(NSEvent*) event {
    NSPoint location = [self convertPoint:[event locationInWindow] fromView:nil];
    BOOL mouseIn = CGRectContainsPoint(self.bounds, location);
    if(mouseIn != _mouseIn) {
        _mouseIn = mouseIn;
 //       FLLog(@"mouse in: %d", _mouseIn);
        [self updateMouseState];
    }
}

- (void)mouseEntered:(NSEvent *)event  {
    [self mouseUpdate:event];
}

- (void) mouseDragged:(NSEvent *)event {
    [self mouseUpdate:event];
}

- (void)mouseExited:(NSEvent *)event {
    [self mouseUpdate:event];
}

- (void)mouseMoved:(NSEvent *)event {
    [self mouseUpdate:event];
}

- (FLTextStyle*) textStyleForState {

    if(self.isEnabled) {
        if(self.isEmphasized) {
            return _titleStyle.emphasizedStyle;
        }
        if(self.isHighlighted) {
            return _titleStyle.highlightedStyle;
        }
        else if(_mouseIn) {
            return _titleStyle.hoveringStyle;
        }
    
        return _titleStyle.enabledStyle;
    }
    else {
        return _titleStyle.disabledStyle;
    }
}


- (void) drawTitle:(NSRect) dirtyRect {
    FLTextAlignment align = { FLVerticalTextAlignmentCenter, FLHorizontalTextAlignmentCenter };
    [FLCoreText drawString:[self.title buildAttributedStringWithTextStyle:[self textStyleForState]] 
         withTextAlignment:align 
                  inBounds:self.bounds];

}

- (void)drawRect:(NSRect)dirtyRect {

    FLTextStyle* textStyle = nil;
    UIColor* bgColor = nil;

    if(_enabled) {
        textStyle = _titleStyle.enabledStyle;

        if(self.isEmphasized) {
            bgColor = [NSColor whiteColor];
            textStyle = _titleStyle.emphasizedStyle;
        }
        else if(_mouseDown) {
            if(_mouseIn) {
                bgColor = [NSColor grayColor];
                textStyle = _titleStyle.highlightedStyle;
            }
            else {
                bgColor = [NSColor lightGrayColor];
                textStyle = _titleStyle.hoveringStyle;
            }
        }
        else if(_mouseIn) {
            bgColor = [NSColor lightGrayColor];
            textStyle = _titleStyle.hoveringStyle;
        }
    } 
    else {
        textStyle = _titleStyle.disabledStyle;
    }

    
    if(bgColor) {
        [bgColor setFill];
        NSRectFill(dirtyRect);
    }

    FLTextAlignment align = { FLVerticalTextAlignmentCenter, FLHorizontalTextAlignmentCenter };
    [FLCoreText drawString:[self.title buildAttributedStringWithTextStyle:textStyle] 
         withTextAlignment:align 
                  inBounds:self.bounds];

    if(_emphasized) {
        [_lineColor set];
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(currentContext,1.0f);
//        if(_drawTopLine) {
            CGContextMoveToPoint(currentContext,0.0f, FLRectGetBottom(self.bounds) - 0.5);
            CGContextAddLineToPoint(currentContext,FLRectGetRight(self.bounds), FLRectGetBottom(self.bounds) - 0.5f );
            CGContextStrokePath(currentContext);
//        }
        
        CGContextMoveToPoint(currentContext,0.0f, 0.5f);
        CGContextAddLineToPoint(currentContext,FLRectGetRight(self.bounds),0.5f );
        CGContextStrokePath(currentContext);
    }
}



@end

@implementation FLHorizontalBreadcrumbBarView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _shape = FLAutorelease([[FLDrawableForwardButtonShape alloc] init]);
        _shape.edgeInset = 1.0;
        _shape.edgeInsetColor = [NSColor grayColor];
        _shape.cornerRadius = 1.0;
        _shape.shapeSize = 10.0;
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_shape release];
    [super dealloc];
}
#endif

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
        [self drawTitle:dirtyRect];
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
#endif