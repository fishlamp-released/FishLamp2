//
//  FLAttributedString.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCocoa.h"

@class FLAttributedString;

@interface FLTextStyle : NSObject<NSCopying> {
@private
    UIColor* _textColor;
    UIColor* _shadowColor;
    UIFont* _font;
    BOOL _underlined;
}
@property (readwrite, assign, nonatomic, getter=isUnderlined) BOOL underlined;
@property (readwrite, strong, nonatomic) UIFont* textFont;
@property (readwrite, strong, nonatomic) UIColor* textColor;
@property (readwrite, strong, nonatomic) UIColor* shadowColor;

- (id) initWithTextColor:(UIColor*) textColor shadowColor:(UIColor*) shadowColor;

+ (id) textStyle:(UIColor*) textColor shadowColor:(UIColor*) shadowColor;
+ (id) textStyle;

@end

@interface FLStringDisplayStyle : NSObject<NSCopying> {
@private
    FLTextStyle* _selectedStyle;
    FLTextStyle* _enabledStyle;
    FLTextStyle* _disabledStyle;
    FLTextStyle* _highlightedStyle;
    FLTextStyle* _emphasizedStyle;
    FLTextStyle* _hoveringStyle;
}
- (void) setTextFont:(UIFont*) font;

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


@interface FLAttributedString : NSObject {
@private
    NSString* _string;
    FLTextStyle* _style;
}

@property (readwrite, strong, nonatomic) FLTextStyle* textStyle;
@property (readwrite, strong, nonatomic) NSString* string;

- (id) initWithString:(NSString*) string;

+ (FLAttributedString*) attributedString;
+ (FLAttributedString*) attributedString:(NSString*) string;

- (NSAttributedString*) buildAttributedString;

@end

@interface NSString (FLAttributedString)
- (NSAttributedString*) attributedStringWithTextStyle:(FLTextStyle*) textStyle;
@end

@interface NSAttributedString (FLAdditions)
- (NSRange) entireRange;
@end

@interface NSMutableAttributedString (FLAdditions)

- (void) setAttribute:(id) object forName:(NSString*) name forRange:(NSRange) range; // nil ojbect removes it.

- (void) setFont:(NSFont*) font forRange:(NSRange) range;
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

