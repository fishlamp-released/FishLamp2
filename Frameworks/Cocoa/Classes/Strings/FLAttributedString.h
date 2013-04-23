//
//  FLAttributedString.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCocoa.h"
#import "FLObjectDescriber.h"
#import "FLModelObject.h"

@class FLAttributedString;

@interface FLTextStyle : FLModelObject {
@private
    SDKColor* _textColor;
    SDKColor* _shadowColor;
    SDKFont* _textFont;
    BOOL _underlined;
}
@property (readwrite, assign, nonatomic, getter=isUnderlined) BOOL underlined;
@property (readwrite, strong, nonatomic) SDKFont* textFont;
@property (readwrite, strong, nonatomic) SDKColor* textColor;
@property (readwrite, strong, nonatomic) SDKColor* shadowColor;

- (id) initWithTextColor:(SDKColor*) textColor shadowColor:(SDKColor*) shadowColor;

+ (id) textStyle:(SDKColor*) textColor shadowColor:(SDKColor*) shadowColor;
+ (id) textStyle;

@end

@interface FLStringDisplayStyle : FLModelObject {
@private
    FLTextStyle* _selectedStyle;
    FLTextStyle* _enabledStyle;
    FLTextStyle* _disabledStyle;
    FLTextStyle* _highlightedStyle;
    FLTextStyle* _emphasizedStyle;
    FLTextStyle* _hoveringStyle;
    SDKFont* _textFont;
}
@property (readwrite, strong, nonatomic) SDKFont* textFont;

@property (readwrite, copy, nonatomic) FLTextStyle* selectedStyle;
@property (readwrite, copy, nonatomic) FLTextStyle* enabledStyle;
@property (readwrite, copy, nonatomic) FLTextStyle* disabledStyle;
@property (readwrite, copy, nonatomic) FLTextStyle* highlightedStyle;
@property (readwrite, copy, nonatomic) FLTextStyle* emphasizedStyle;
@property (readwrite, copy, nonatomic) FLTextStyle* hoveringStyle;

- (void) visitStyles:(void (^)(FLTextStyle* style)) visitor;

- (void) setToControlDefaults;

+ (id) stringDisplayStyle;

@end

@interface NSAttributedString (FLAdditions)
+ (id) attributedStringWithString:(NSString*) string withTextStyle:(FLTextStyle*) style;

- (NSRange) entireRange;

- (CGColorRef) colorForRange:(NSRange) range;
- (CTFontRef) fontForRange:(NSRange) range;

@end

@interface NSMutableAttributedString (FLAdditions)

- (void) setAttribute:(id) object forName:(NSString*) name forRange:(NSRange) range; // nil ojbect removes it.

- (void) setFont:(SDKFont*) font forRange:(NSRange) range;
- (void) setColor:(NSColor*) color forRange:(NSRange) range;
- (void) setShadowColor:(NSColor*) color forRange:(NSRange) range;
- (void) setUnderlined:(BOOL) underlined forRange:(NSRange) range;
- (void) setTextStyle:(FLTextStyle*) style forRange:(NSRange) range;
- (void) setURL:(NSURL*) url forRange:(NSRange) range;

+ (id) mutableAttributedString;
+ (id) mutableAttributedString:(NSString*) string;


// makes a link
- (id) initWithString:(NSString*) string url:(NSURL*) url color:(NSColor*) color underline:(BOOL) underline;
+ (id) mutableAttributedString:(NSString*) string url:(NSURL*) url color:(NSColor*) color underline:(BOOL) underline;

@end



