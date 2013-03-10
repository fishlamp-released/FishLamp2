//
//  FLBarTitleLayer.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLBarTitleLayer.h"
#import "FLAttributedString.h"
#import "FLCoreText.h"

@interface FLBarTitleLayer ()
@property (readwrite, strong, nonatomic) NSAttributedString* attributedString;
@end

@implementation FLBarTitleLayer

+ (id) layer {
    return FLAutorelease([[[self class] alloc] init]);
}

@synthesize title = _title;
@synthesize titleStyle = _titleStyle;
@synthesize highlighted = _highlighted;
@synthesize enabled = _enabled;
@synthesize emphasized = _emphasized;
@synthesize attributedString = _attributedString;

#if FL_MRC
- (void) dealloc {
    [_attributedString release];
    [_titleStyle release];
    [_title release];
    [super dealloc];
}
#endif

- (void) updateState {
    NSColor* bgColor = [NSColor clearColor];
    FLTextStyle* textStyle = _titleStyle.enabledStyle;
        
    if(_enabled) {
        if(self.isEmphasized) {
            bgColor = [NSColor clearColor];
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
        CGColorRef colorRef = [bgColor copyCGColorRef];
        [self setBackgroundColor:colorRef];
        CFRelease(colorRef);
    }
    
    self.attributedString = [NSAttributedString attributedStringWithString:self.title withTextStyle:textStyle];
    
    [self setNeedsDisplay];
}


- (void) handleMouseMoved:(CGPoint) location mouseIn:(BOOL) mouseIn mouseDown:(BOOL) mouseDown {
    if(_mouseIn != mouseIn || _mouseDown != mouseDown) {
        _mouseIn = mouseIn;
        _mouseDown = mouseDown;
        [self updateState];
    }
}

- (void) handleMouseUpInside:(CGPoint) location {
    [self updateState];
}

- (void) setEnabled:(BOOL) enabled {
    _enabled = enabled;
     [self updateState];
}

- (void) setEmphasized:(BOOL)emphasized {
    _emphasized = emphasized;
    [self updateState];
}

- (void) setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    [self updateState];
}

CGFloat GetLineHeightForFont(CTFontRef iFont)
{
    CGFloat lineHeight = 0.0;
 
//    check(iFont != NULL);
 
    // Get the ascent from the font, already scaled for the font's size
    lineHeight += CTFontGetAscent(iFont);
 
    // Get the descent from the font, already scaled for the font's size
    lineHeight += CTFontGetDescent(iFont);
 
    // Get the leading from the font, already scaled for the font's size
    lineHeight += CTFontGetLeading(iFont);
 
    return lineHeight;
}


- (void)drawInContext:(CGContextRef) ctx {
//    CGContextClearRect(ctx, self.bounds);
    
    CGRect frame = CGRectZero;
    frame.size = [self.attributedString sizeForDrawingInBounds:self.bounds];
    frame = FLRectCenterRectInRect(self.bounds, frame);

//    CGColorRef colorRef = [NSColor redColor].copyCGColorRef;
//    CGContextSetFillColorWithColor(ctx, colorRef);
//    CGContextFillRect(ctx, frame);
      
    frame.origin.y -= 2.0f;
    frame = FLRectOptimizedForViewLocation(frame);
      
    CGContextDrawAttributedString(ctx, self.attributedString, frame);  
      
    
//    
////    [super drawInContext:ctx];
//
//    
//    
//    FLLog(@"%@ %@", NSStringFromRect(self.bounds), [((id)colorRef) description] )


//    [self.attributedString drawInContext:ctx
//                                    rect:self.bounds 
//                    withTextAlignment:FLTextAlignmentMake(FLVerticalTextAlignmentCenter,  FLHorizontalTextAlignmentCenter)];
//
}

@end
