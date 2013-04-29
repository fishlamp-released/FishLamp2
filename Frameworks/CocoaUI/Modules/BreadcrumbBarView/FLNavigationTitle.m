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

typedef enum {
    DrawStateNormal,
    DrawStateHighlighted,
    DrawStateHovering,
    DrawStateDisabled,
    DrawStateMouseDownIn,
    DrawStateMouseDownOut
} DrawState;

- (void) updateDrawState:(DrawState) drawState {

    NSShadow* shadow = FLAutorelease([[NSShadow alloc] init]);
    [shadow setShadowOffset:NSMakeSize( 1.0, -1.0 )];
    [shadow setShadowBlurRadius:1.0];        
    
    NSColor* bgColor = [NSColor clearColor];
    
    NSMutableDictionary* attr = [NSMutableDictionary dictionary];
    [attr setObject:[NSFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];

    switch(drawState) {
        case DrawStateNormal:
            [attr setObject:[NSColor darkGrayColor] forKey:NSForegroundColorAttributeName];
            [shadow setShadowColor:[NSColor whiteColor]];
        break;
        
        case DrawStateDisabled:
            [attr setObject:[NSColor lightGrayColor] forKey:NSForegroundColorAttributeName];
            [shadow setShadowColor:[NSColor whiteColor]];
        break;
        
        case DrawStateHighlighted:
            [attr setObject:FLColorFromHexColorString(@"#b5482b") forKey:NSForegroundColorAttributeName];
            [shadow setShadowColor:[NSColor gray85Color]];
//            [shadow setShadowColor:FLColorFromHexColorString(@"#ef8039" )];
//            shadow = nil;
        break;
        
        case DrawStateHovering:
            [attr setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
            bgColor = [NSColor grayColor];
            [shadow setShadowColor:[NSColor blackColor]];
        break;
        
        case DrawStateMouseDownIn:
            [attr setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
            bgColor = [NSColor darkGrayColor];
            [shadow setShadowColor:[NSColor blackColor]];
        break;
        
        case DrawStateMouseDownOut:
            [attr setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
            [shadow setShadowColor:[NSColor blackColor]];
            bgColor = [NSColor grayColor];
        break;
    }

    if(bgColor) {
        CGColorRef colorRef = [bgColor copyCGColorRef];
        [self setBackgroundColor:colorRef];
        CFRelease(colorRef);
    }

    if(shadow) {
        [attr setObject:shadow forKey:NSShadowAttributeName];
    }
       
    self.attributedString = FLAutorelease([[NSAttributedString alloc] initWithString:self.localizedTitle attributes:attr]);
                

}

- (void) updateState {
    if(_willUpdate) {
//        NSColor* bgColor = [NSColor clearColor];
//        NSColor* textColor = [NSColor grayColor];
//        NSColor* shadowColor = [NSColor whiteColor];
//        
//        FLTextStyle* textStyle = self.titleStyle.enabledStyle;
//        NSShadow* shadow = FLAutorelease([[NSShadow alloc] init]);
//        [shadow setShadowOffset:NSMakeSize( 1.5, -1.5 )];
//        [shadow setShadowBlurRadius:1.0];        
//            
//        if(_enabled) {
//            if(self.isEmphasized) {
//                bgColor = [NSColor clearColor];
//                textStyle = self.titleStyle.emphasizedStyle;
//                
//                textColor = FLColorFromHexColorName(@"#b5482b");
//                shadowColor = FLColorFromHexColorName(@"#ef8039");
////                [NSColor colorWith]
//                
////                shadowColor = [NSColor darkGrayColor];
////                [shadow setShadowOffset:NSMakeSize( 0.5, -0.5 )];
//            }
//            else if(_mouseDown) {
//                if(_mouseIn) {
//                    bgColor = [NSColor grayColor];
//                    textColor = [NSColor whiteColor];
//                    
////    self.enabledStyle.textColor = [NSColor textColor];
////    self.disabledStyle.textColor = [NSColor disabledControlTextColor];
////    self.selectedStyle.textColor = [NSColor selectedControlTextColor];
////    self.highlightedStyle.textColor = [NSColor highlightColor];
//                    
//                    
////                    textStyle = self.titleStyle.highlightedStyle;
//                }
//                else {
//                    bgColor = [NSColor lightGrayColor];
//                    textStyle = self.titleStyle.hoveringStyle;
//                    shadowColor = [NSColor blackColor];
//                }
//            }
//            else if(_mouseIn) {
//                bgColor = [NSColor lightGrayColor];
//                textStyle = self.titleStyle.hoveringStyle;
////                shadowColor = [NSColor blackColor];
//                [shadow setShadowColor:[NSColor whiteColor]];
//
//            }
//        } 
//        else {
//            textStyle = self.titleStyle.disabledStyle;
//            
//            textColor = [NSColor disabledControlTextColor];
//            [shadow setShadowColor:[NSColor whiteColor]];
//    
//        }
//        
//        if(bgColor) {
//            CGColorRef colorRef = [bgColor copyCGColorRef];
//            [self setBackgroundColor:colorRef];
//            CFRelease(colorRef);
//        }
//        
//        
//        NSDictionary* attr = nil;
//        
//        if(shadow) {
//            attr = [NSDictionary dictionaryWithObjectsAndKeys:
//                textColor, NSForegroundColorAttributeName,
//                (id) shadow, NSShadowAttributeName,
//                [NSFont boldSystemFontOfSize:14], NSFontAttributeName,
//                nil];
//        }
//        else {
//            attr = [NSDictionary dictionaryWithObjectsAndKeys:
//                textStyle.textColor, NSForegroundColorAttributeName,
//                [NSFont boldSystemFontOfSize:14], NSFontAttributeName,
//                nil];
//        }

        if(_enabled) {
            if(self.isEmphasized) {
                [self updateDrawState:DrawStateHighlighted];
            }
            else if(_mouseDown) {
                if(_mouseIn) {
                    [self updateDrawState:DrawStateMouseDownIn];
                }
                else {
                    [self updateDrawState:DrawStateMouseDownOut];
                }
            }
            else if(_mouseIn) {
                [self updateDrawState:DrawStateHovering];
            }
            else {
                [self updateDrawState:DrawStateNormal];
            }
        } 
        else {
            [self updateDrawState:DrawStateDisabled];
        }
        
                    
        
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
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext
        graphicsContextWithGraphicsPort:context flipped:NO]];

    CGContextSetTextMatrix(context, CGAffineTransformIdentity );
    CGRect frame = CGRectZero;
    frame.size = [self.attributedString size];
    frame = FLRectOptimizedForViewLocation(FLRectCenterRectInRect(self.bounds, frame));
    [self.attributedString drawInRect:frame];
    [NSGraphicsContext restoreGraphicsState];

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
