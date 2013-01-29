//
//  ZFLinkTextField.m
//  ZenfolioDownloader
//
//  Created by patrick machielse on 28-7-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import "ZFLinkTextField.h"
#import "NSColor+ZFAdditions.h"

@implementation ZFLinkTextField

- (void) setToZenfolioStyle {
    [super setToZenfolioStyle];
    _color = FLRetain(self.textColor);
    
//    self.font = [NSFont zenfolioLinkButtonFont];
}

- (void)removeTrackingTags {
    if(_boundsTrackingTag) {
        [self removeTrackingRect:_boundsTrackingTag];
        _boundsTrackingTag = 0;
    }
}

- (void)updateBoundsTrackingTag {
    [self removeTrackingTags];
    
    NSPoint loc = [self convertPoint:[[self window] mouseLocationOutsideOfEventStream] fromView:nil];
   
    BOOL inside = ([self hitTest:loc] == self);
   
    if (inside) {
        [[self window] makeFirstResponder:self]; // if the view accepts first responder status
    }
   
   _boundsTrackingTag = [self addTrackingRect:[self visibleRect] owner:self userData:nil assumeInside:inside];
}

- (BOOL)acceptsFirstResponder { 
    return YES;
} 

- (BOOL)becomeFirstResponder {
    return YES;
}

- (void)resetCursorRects {
	[self addCursorRect:[self bounds] cursor:[NSCursor pointingHandCursor]];
    [self updateBoundsTrackingTag];
}

- (void)mouseUp:(NSEvent *)mouseEvent {
    _mouseDown = NO;
    [self setNeedsDisplay:YES];
    if(_mouseIn) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:self.stringValue]];
    }
}

- (void)mouseMoved:(NSEvent *)theEvent {
    FLLog(@"mouseMoved");
}

- (void)mouseDown:(NSEvent *)theEvent  {
    _mouseDown = YES;
    [self setNeedsDisplay:YES];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    _mouseIn = YES;
    [self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent {
    _mouseIn = NO;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect {
	
    if( _mouseDown && _mouseIn) {
        self.textColor = [NSColor zenfolioOrange];
    }
    else {
        self.textColor = _color;
    }

    [self.textColor set];

	[super drawRect:rect];
	
//	if ( _mouseIn ) {
//    	NSRect bounds = [self bounds];
//		[NSBezierPath strokeLineFromPoint:NSMakePoint(NSMinX(bounds)  + 2, NSMaxY(bounds))
//								  toPoint:NSMakePoint(NSWidth(bounds) - 2, NSMaxY(bounds))];
//	}
}



- (void)viewWillMoveToWindow:(NSWindow*) window {
    
    if(!window) {
        [self removeTrackingTags];
    }
    else {
        [self updateBoundsTrackingTag];
    }
    
    [super viewWillMoveToWindow:window];
}

@end
