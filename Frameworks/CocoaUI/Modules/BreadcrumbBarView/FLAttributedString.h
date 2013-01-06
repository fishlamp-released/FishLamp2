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

@interface FLAttributedString : NSObject {
@private
    NSString* _string;
    
    UIColor* _enabledColor;
    UIColor* _disabledColor;
    UIColor* _highlightedColor;
    UIColor* _enabledShadowColor;
    UIColor* _disabledShadowColor;
    UIColor* _highlightedShadowColor;
    UIFont* _textFont;

    BOOL _highlighted;
    BOOL _touchable;
    BOOL _enabled;
    BOOL _hidden;
}

@property (readwrite, strong, nonatomic) UIColor* enabledColor;
@property (readwrite, strong, nonatomic) UIColor* disabledColor;
@property (readwrite, strong, nonatomic) UIColor* highlightedColor;

@property (readwrite, strong, nonatomic) UIColor* enabledShadowColor;
@property (readwrite, strong, nonatomic) UIColor* disabledShadowColor;
@property (readwrite, strong, nonatomic) UIColor* highlightedShadowColor;

@property (readonly, strong, nonatomic) UIColor* colorForState;
@property (readonly, strong, nonatomic) UIColor* shadowColorForState;

@property (readwrite, strong, nonatomic) UIFont* textFont;

// state
@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isTouchable) BOOL touchable;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;

// string
@property (readwrite, strong, nonatomic) NSString* string;

@property (readonly, strong, nonatomic) NSAttributedString* attributedString; 

- (id) initWithString:(NSString*) string;

+ (FLAttributedString*) attributedString;
+ (FLAttributedString*) attributedString:(NSString*) string;
@end

