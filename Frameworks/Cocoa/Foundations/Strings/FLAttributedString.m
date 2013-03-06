//
//  FLAttributedString.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAttributedString.h"

@interface FLTextStyle ()
@end

@implementation FLTextStyle
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;
@synthesize underlined = _underlined;
@synthesize textFont = _textFont;

- (id) init {
    self = [super init];
    if(self) {
        self.textColor = [NSColor blackColor];
        self.shadowColor = [NSColor whiteColor];
    }
    return self;
}

- (id) initWithTextColor:(UIColor*) textColor shadowColor:(UIColor*) shadowColor {
    self = [super init];
    if(self) {
        self.textColor = textColor;
        self.shadowColor = shadowColor;
    }
    return self;
}

+ (id) textStyle {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) textStyle:(UIColor*) textColor shadowColor:(UIColor*) shadowColor {
    return FLAutorelease([[[self class] alloc] initWithTextColor:textColor shadowColor:shadowColor]);
}

#if FL_MRC
- (void) dealloc {
    [_textColor release];
    [_shadowColor release];
    [_textFont release];
    [super dealloc];
}
#endif

- (id) copyWithZone:(NSZone *)zone {
    FLTextStyle* style = [FLTextStyle textStyle];
    style.textColor = self.textColor;
    style.shadowColor = self.shadowColor;
    style.textFont = self.textFont;
    style.underlined = self.isUnderlined;
    return style;
}

@end

@implementation FLStringDisplayStyle 

@synthesize enabledStyle = _enabledStyle;
@synthesize disabledStyle = _disabledStyle;
@synthesize highlightedStyle = _highlightedStyle;
@synthesize emphasizedStyle = _emphasizedStyle;
@synthesize hoveringStyle = _hoveringStyle;
@synthesize selectedStyle = _selectedStyle;

+ (id) stringDisplayStyle {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    self = [super init];
    if(self) {
        _selectedStyle = [[FLTextStyle alloc] init];
        _enabledStyle = [[FLTextStyle alloc] init];
        _disabledStyle = [[FLTextStyle alloc] init];
        _highlightedStyle = [[FLTextStyle alloc] init];
        _emphasizedStyle = [[FLTextStyle alloc] init];
        _hoveringStyle = [[FLTextStyle alloc] init];
    }
    return self;
}

- (void) setToControlDefaults {
    [self setTextFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];

#if OSX
    [self visitStyles:^(FLTextStyle* style){
        style.shadowColor = [UIColor shadowColor];
    }];

    self.enabledStyle.textColor = [NSColor textColor];
    self.disabledStyle.textColor = [NSColor disabledControlTextColor];
    self.selectedStyle.textColor = [NSColor selectedControlTextColor];
    self.highlightedStyle.textColor = [NSColor highlightColor];
    self.hoveringStyle = self.highlightedStyle;

#endif       

}

#if FL_MRC
- (void) dealloc {
    [_selectedStyle release];
    [_enabledStyle release];
    [_disabledStyle release];
    [_highlightedStyle release];
    [_emphasizedStyle release];
    [_hoveringStyle release];
    [super dealloc];
}
#endif

- (id) copyWithZone:(NSZone*) zone {
    FLStringDisplayStyle* colors = [[FLStringDisplayStyle alloc] init];
    colors.enabledStyle = self.enabledStyle;
    colors.disabledStyle = self.disabledStyle;
    colors.highlightedStyle = self.highlightedStyle;
    colors.emphasizedStyle = self.emphasizedStyle;
    colors.hoveringStyle = self.hoveringStyle;
    colors.selectedStyle = self.selectedStyle;
    return colors;
}

- (void) visitStyles:(void (^)(FLTextStyle* style)) visitor {
    visitor(self.selectedStyle);
    visitor(self.enabledStyle);
    visitor(self.disabledStyle);
    visitor(self.highlightedStyle);
    visitor(self.emphasizedStyle);
    visitor(self.hoveringStyle);
}

- (void) setTextFont:(UIFont*) font {
    [self visitStyles:^(FLTextStyle* style){
        style.textFont = font;
    }];
}

@end

@implementation FLAttributedString
@synthesize string = _string;
@synthesize textStyle = _textStyle;

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
    [_textStyle release];
    [_string release];
    [super dealloc];
}
#endif

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

- (NSAttributedString*) buildAttributedString {
    return [self.string attributedStringWithTextStyle:self.textStyle];
}
@end

@implementation NSString (FLAttributedString)

- (NSAttributedString*) attributedStringWithTextStyle:(FLTextStyle*) textStyle {

    FLAssertNotNil_v(textStyle, @"no text style attributed string");
    NSMutableAttributedString* string =
        FLAutorelease([[NSMutableAttributedString alloc] initWithString:self]);

    [string setTextStyle:textStyle forRange:string.entireRange];
    return string;
}

@end

@implementation NSAttributedString (FLAdditions)
- (NSRange) entireRange {
    return NSMakeRange(0, self.length);
}
@end

@implementation NSMutableAttributedString (FLAdditions)


- (void) setTextStyle:(FLTextStyle*) style forRange:(NSRange) range {
    if(style.textFont) {
        [self setFont:style.textFont forRange:range];
    }
    if(style.textColor) {
        [self setColor:style.textColor forRange:range];
    }
    if(style.shadowColor) {
        [self setShadowColor:style.shadowColor forRange:range];
    }
    if(style.isUnderlined) {
        [self setUnderlined:YES forRange:range];
    }
    [self addAttribute:@"com.fishlamp.string" value:self range:range];
}

- (void) setAttribute:(id) object forName:(NSString*) name forRange:(NSRange) range {
    if(object) {
        [self addAttribute:name value:object range:range];
    }
    else {
        [self removeAttribute:name range:range];
    }
}

- (void) setFont:(NSFont*) font forRange:(NSRange) range {
    FLAssertNotNil_(font); 
    
    CTFontRef fontRef = CTFontCreateWithName(bridge_(CFStringRef, font.fontName), font.pointSize, NULL);
    FLAssertIsNotNil_(fontRef);
    
    if(fontRef) {
        [self setAttribute:bridge_(id, fontRef) forName:(NSString*) kCTFontAttributeName forRange:range];
    
//        [self addAttribute:(NSString*) kCTFontAttributeName
//            value:bridge_(id, fontRef) 
//            range:range];

        CFRelease(fontRef);
    }
}

- (void) setColor:(NSColor*) color forRange:(NSRange) range{

    [self setAttribute:color forName:(NSString*) kCTForegroundColorAttributeName forRange:range];

//    if(color) {
//        [self addAttribute:(NSString*) kCTForegroundColorAttributeName 
//        value:bridge_(id, [NSColor NSColorToCGColor:color])
//        range:range];
//    }
//    else {
//    
//    }
}

- (void) setShadowColor:(NSColor*) color forRange:(NSRange) range {

    [self setAttribute:color forName:(NSString*) NSShadowAttributeName forRange:range];

//    if(color) {
//        [self addAttribute:(NSString*) NSShadowAttributeName 
//        value:bridge_(id, [NSColor NSColorToCGColor:color])
//        range:range];
//    }
//    else {
//        [self removeAttribute:(NSString*) NSShadowAttributeName forRange:range];
//    }
}

- (void) setUnderlined:(BOOL) underlined forRange:(NSRange) range {

    [self setAttribute:underlined ? [NSNumber numberWithBool:YES] : nil forName:(NSString*) NSUnderlineStyleAttributeName  forRange:range];


//    [self addAttribute:(NSString*) NSUnderlineStyleAttributeName 
//        value:[NSNumber numberWithBool:YES]
//        range:range];
}

- (void) setURL:(NSURL*) url forRange:(NSRange) range {
    [self setAttribute:url forName:(NSString*) NSLinkAttributeName forRange:range];
}

+ (id) mutableAttributedString {
    return FLAutorelease([[[self class] alloc] init]);
}
+ (id) mutableAttributedString:(NSString*) string {
    return FLAutorelease([[[self class] alloc] initWithString:string]);
}

- (id) initWithString:(NSString*) string url:(NSURL*) url color:(NSColor*) color underline:(BOOL) underline {
    self = [self initWithString:string];
    if(self) {
        NSRange range = self.entireRange;
        [self setURL:url forRange:range];
        [self setColor:color forRange:range];
        [self setUnderlined:underline forRange:range];
    }
    return self;
}

+ (id) mutableAttributedString:(NSString*) string url:(NSURL*) url color:(NSColor*) color underline:(BOOL) underline {
    return FLAutorelease([[[self class] alloc] initWithString:string url:url color:color underline:underline]);
}

@end