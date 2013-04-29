//
//  FLNavigationTitle.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNavigationTitle.h"
#import "FLAttributedString.h"
#import "FLCoreText.h"

@interface FLNavigationTitle ()
@property (readwrite, strong, nonatomic) NSAttributedString* attributedString;
@property (readwrite, strong, nonatomic) id identifier;
@end

@implementation FLNavigationTitle

@synthesize localizedTitle = _localizedTitle;
@synthesize highlighted = _highlighted;
@synthesize enabled = _enabled;
@synthesize emphasized = _emphasized;
@synthesize attributedString = _attributedString;
@synthesize titleStyle = _titleStyle;
@synthesize identifier = _identifier;
@synthesize titleHeight = _titleHeight;

+ (id) layer {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) initWithIdentifier:(id) identifier localizedTitle:(NSString*) localizedTitle {
	self = [super init];
	if(self) {
        self.identifier = identifier;
        self.localizedTitle = localizedTitle;
        self.titleHeight = FLNavigationTitleDefaultHeight;
	}
	return self;
}

+ (id) navigationTitle:(id) identifier localizedTitle:(NSString*) localizedTitle {
    return FLAutorelease([[[self class] alloc] initWithIdentifier:identifier localizedTitle:localizedTitle]);
}

#if FL_MRC
- (void) dealloc {
    [_identifier release];
    [_titleStyle release];
    [_attributedString release];
    [_localizedTitle release];
    [super dealloc];
}
#endif

- (void) updateState {
    if(_willUpdate) {
        NSColor* bgColor = [NSColor clearColor];
        NSColor* shadowColor = [NSColor whiteColor];
        FLTextStyle* textStyle = self.titleStyle.enabledStyle;
        NSShadow* shadw = FLAutorelease([[NSShadow alloc] init]);
        [shadw setShadowOffset:NSMakeSize( 1.0, -1.0 )];
            
        if(_enabled) {
            if(self.isEmphasized) {
                bgColor = [NSColor clearColor];
                textStyle = self.titleStyle.emphasizedStyle;
                shadowColor = [NSColor darkGrayColor];
                [shadw setShadowOffset:NSMakeSize( 0.5, -0.5 )];
            }
            else if(_mouseDown) {
                if(_mouseIn) {
                    bgColor = [NSColor grayColor];
                    textStyle = self.titleStyle.highlightedStyle;
                }
                else {
                    bgColor = [NSColor lightGrayColor];
                    textStyle = self.titleStyle.hoveringStyle;
                    shadowColor = [NSColor blackColor];
                }
            }
            else if(_mouseIn) {
                bgColor = [NSColor lightGrayColor];
                textStyle = self.titleStyle.hoveringStyle;
                    shadowColor = [NSColor blackColor];
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
        
        [shadw setShadowColor:shadowColor];
        [shadw setShadowBlurRadius:1.0];        

        NSDictionary* attr = nil;
        
        if(shadw) {
            attr = [NSDictionary dictionaryWithObjectsAndKeys:
                textStyle.textColor, NSForegroundColorAttributeName,
                (id) shadw, NSShadowAttributeName,
                [NSFont boldSystemFontOfSize:14], NSFontAttributeName,
                nil];
        }
        else {
            attr = [NSDictionary dictionaryWithObjectsAndKeys:
                textStyle.textColor, NSForegroundColorAttributeName,
                [NSFont boldSystemFontOfSize:14], NSFontAttributeName,
                nil];
        }
            
        self.attributedString = FLAutorelease([[NSAttributedString alloc] initWithString:self.localizedTitle attributes:attr]);
        
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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (0.05f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateState];
        });
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

    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext
        graphicsContextWithGraphicsPort:context flipped:NO]];

//    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity );
    CGRect frame = CGRectZero;
    frame.size = [self.attributedString size];
    frame = FLRectOptimizedForViewLocation(FLRectCenterRectInRect(self.bounds, frame));
    
//    [self.attributedString drawWithRect:frame  
//                                options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin];

    [self.attributedString drawInRect:frame];

//    CGColorRef colorRef = [NSColor clearColor].CGColor;
//
//    CGContextSetFillColorWithColor(context, colorRef);
//    CGContextFillRect(context, frame);
//    CGContextSetShouldSmoothFonts(context, YES);
//    CGContextDrawAttributedString(context, self.attributedString,  frame);
//
//          
    [NSGraphicsContext restoreGraphicsState];

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
    FLLog(@"draw title: %@", _localizedTitle);
#endif    
}

- (void) setLocalizedTitle:(NSString*) localizedTitle {
    
    if(FLStringsAreNotEqual(localizedTitle, _localizedTitle)) {
        FLSetObjectWithRetain(_localizedTitle, localizedTitle);
        [self setNeedsUpdate];
    }
}

@end
