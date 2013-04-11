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

@synthesize styleProvider = _titleDelegate;
@synthesize title = _title;
@synthesize highlighted = _highlighted;
@synthesize enabled = _enabled;
@synthesize emphasized = _emphasized;
@synthesize attributedString = _attributedString;

#if FL_MRC
- (void) dealloc {
    [_attributedString release];
    [_title release];
    [super dealloc];
}
#endif

- (FLStringDisplayStyle*) titleStyle {
    return [self.styleProvider barTitleLayerGetStringDisplayStyle:self];
}

- (void) updateState {
    if(_willUpdate) {
        NSColor* bgColor = [NSColor clearColor];
        FLTextStyle* textStyle = self.titleStyle.enabledStyle;
            
        if(_enabled) {
            if(self.isEmphasized) {
                bgColor = [NSColor clearColor];
                textStyle = self.titleStyle.emphasizedStyle;
            }
            else if(_mouseDown) {
                if(_mouseIn) {
                    bgColor = [NSColor grayColor];
                    textStyle = self.titleStyle.highlightedStyle;
                }
                else {
                    bgColor = [NSColor lightGrayColor];
                    textStyle = self.titleStyle.hoveringStyle;
                }
            }
            else if(_mouseIn) {
                bgColor = [NSColor lightGrayColor];
                textStyle = self.titleStyle.hoveringStyle;
            }
        } 
        else {
            textStyle = self.titleStyle.disabledStyle;
        }
        
        if(bgColor) {
            CGColorRef colorRef = [bgColor copyCGColorRef];
            [self setBackgroundColor:colorRef];
            CFRelease(colorRef);
        }
        
        self.attributedString = [NSAttributedString attributedStringWithString:self.title withTextStyle:textStyle];
        
        [self setNeedsDisplay];
        _willUpdate = NO;

#if TRACE        
        FLLog(@"updated title: %@", _attributedString.string);
#endif        
    }
}

- (void) setNeedsUpdate {
    if(!_willUpdate) {
        _willUpdate = YES;
        [self performSelector:@selector(updateState) withObject:nil afterDelay:0.05];
    }
}

- (void) handleMouseMoved:(CGPoint) location mouseIn:(BOOL) mouseIn mouseDown:(BOOL) mouseDown {
    
    if(!_enabled) {
        return;
    }
    
    if(_mouseIn != mouseIn) {
        _mouseIn = mouseIn;
        [self setNeedsUpdate];
    } 

    if(_mouseDown != mouseDown) {
        _mouseDown = mouseDown;
        [self setNeedsUpdate];
    }
}

- (void) handleMouseUpInside:(CGPoint) location {
    [self setNeedsUpdate];
}

- (void) setEnabled:(BOOL) enabled {
    if(_enabled != enabled) {
        _enabled = enabled;
        [self setNeedsUpdate];
    }
}

- (void) setEmphasized:(BOOL)emphasized {
    if(_emphasized != emphasized) {
        _emphasized = emphasized;
        [self setNeedsUpdate];
    }
}

- (void) setHighlighted:(BOOL)highlighted {
    if(_highlighted != highlighted) {
        [self setNeedsUpdate];
    }
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


- (void)drawInContext:(CGContextRef) context {
//    CGContextClearRect(ctx, self.bounds);

//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity );
    CGRect frame = CGRectZero;
    frame.size = [self.attributedString size];
    frame = FLRectOptimizedForViewLocation(FLRectCenterRectInRect(self.bounds, frame));
    
//    [self.attributedString drawWithRect:frame  
//                                options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin];

//    CGColorRef colorRef = [NSColor whiteColor].CGColor;

//    CGContextSetFillColorWithColor(context, colorRef);
//    CGContextFillRect(context, frame);
    CGContextSetShouldSmoothFonts(context, NO);
    CGContextDrawAttributedString(context, self.attributedString,  frame);

          
    CGContextRestoreGState(context);

  //  [self.attributedString drawWithRect:frame options:NSStringDrawingTruncatesLastVisibleLine]
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

#if TRACE
    FLLog(@"draw title: %@", _title);
#endif    
}

- (void) setTitle:(NSString*) title {
    if(FLStringsAreNotEqual(title, _title)) {
        FLSetObjectWithRetain(_title, title);
        [self setNeedsUpdate];
    }
}

@end
