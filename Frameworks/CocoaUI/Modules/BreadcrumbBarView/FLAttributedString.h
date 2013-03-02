//
//  FLAttributedString.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaUIRequired.h"
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
- (NSAttributedString*) buildAttributedStringWithTextStyle:(FLTextStyle*) textStyle;
@end

