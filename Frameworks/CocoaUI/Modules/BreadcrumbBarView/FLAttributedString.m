//
//  FLAttributedString.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAttributedString.h"

@implementation FLAttributedString

@synthesize enabledColor = _enabledColor;
@synthesize disabledColor = _disabledColor;
@synthesize highlightedColor = _highlightedColor;
@synthesize enabledShadowColor = _enabledShadowColor;
@synthesize disabledShadowColor = _disabledShadowColor;
@synthesize highlightedShadowColor = _highlightedShadowColor;
@synthesize emphasizedColor = _emphasizedColor;
@synthesize emphasizedShadowColor = _emphasizedShadowColor;
@synthesize textFont = _textFont;
@synthesize string = _string;
@synthesize highlighted = _highlighted;
@synthesize touchable = _touchable;
@synthesize enabled = _enabled;
@synthesize hidden = _hidden;
@synthesize underlined = _underlined;
@synthesize emphasized = _emphasized;

- (id) init {
    return [self initWithString:@""];
}

- (id) initWithString:(NSString*) string {
    self = [super init];
    if(self) {
        self.string = string;
    }
    
    return self;
}

+ (FLAttributedString*) attributedString {
    return FLAutorelease([[FLAttributedString alloc] initWithString:@""]);
}

+ (FLAttributedString*) attributedString:(NSString*) string {
    return FLAutorelease([[FLAttributedString alloc] initWithString:string]);
}

#if FL_MRC
- (void) dealloc {
    [_emphasizedColor release];
    [_emphasizedShadowColor release];
    [_enabledShadowColor release];
    [_disabledShadowColor release];
    [_highlightedShadowColor release];
    [_enabledColor release];
    [_disabledColor release];
    [_highlightedColor release];
    [_textFont release];
    [_string release];
    [super dealloc];
}
#endif

- (UIColor*) colorForState {

    if(self.isEnabled) {
        if(self.isHighlighted) {
            return self.highlightedColor;
        }
        else if(self.isEmphasized) {
            return self.emphasizedColor;
        }
        else {
            return self.enabledColor;
        }
    }
    else {
        return self.disabledColor;
    }
}

- (UIColor*) shadowColorForState {

    if(self.isEnabled) {
        if(self.isHighlighted) {
            return self.highlightedShadowColor;
        }
        else if(self.isEmphasized) {
            return self.emphasizedShadowColor;
        }
        else {
            return self.enabledShadowColor;
        }
    }
    else {
        return self.disabledShadowColor;
    }
}
//- (NSDictionary*) attributes {
//    MSMutableDictionary* attributes = [MSMutableDictionary dictionary];
//    if(self.textFont) {
//        CTFontRef fontRef = CTFontCreateWithName(bridge_(CFStringRef, self.textFont.fontName), self.textFont.pointSize, NULL);
//        FLAssertIsNotNil_(fontRef);
//    
//    
//        [attributes setObject:fontRef forKey:(NSString*) kCTFontAttributeName];
//    }
//    
//    NSColor* color = self.colorForState;
//    if(color) {
//        [attributes setObject:color forKey:(NSString*) kCTForegroundColorAttributeName];
//    }
//    
//    NSColor* shadowColor = self.shadowColorForState;
//    if(color) {
//        [attributes setObject:shadowColor forKey:(NSString*) NSShadowAttributeName ];
//    }
//    
//    return attributes;
//}


- (NSAttributedString*) attributedString {
    NSRange range = NSMakeRange(0, self.string.length);

    NSMutableAttributedString* string =
        FLAutorelease([[NSMutableAttributedString alloc] initWithString:self.string]);
    
    CTFontRef fontRef = CTFontCreateWithName(bridge_(CFStringRef, self.textFont.fontName), self.textFont.pointSize, NULL);
    FLAssertIsNotNil_(fontRef);
    
    if(fontRef) {
        [string addAttribute:(NSString*) kCTFontAttributeName
            value:bridge_(id, fontRef) 
            range:range];

        CFRelease(fontRef);
    }

    FLAssertNotNil_v([self colorForState], @"color not set");

    [string addAttribute:(NSString*) kCTForegroundColorAttributeName 
        value:bridge_(id, [[self colorForState] CGColor])
        range:range];

    NSColor* shadowColor = self.shadowColorForState;
    if(shadowColor) {
        [string addAttribute:(NSString*) NSShadowAttributeName 
            value:bridge_(id, [shadowColor CGColor])
            range:range];
    }

    if(self.underlined) {
        [string addAttribute:(NSString*) NSUnderlineStyleAttributeName 
            value:[NSNumber numberWithBool:YES]
            range:range];
    }
    
    [string addAttribute:@"com.fishlamp.string" value:self range:range];
    
    return string;
}

@end
