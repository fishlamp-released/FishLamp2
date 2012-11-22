// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLViewGradients.h
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "__FLThemeObjectsEnums.h"
@class FLColorRange;

// --------------------------------------------------------------------
// FLViewGradients
// --------------------------------------------------------------------
@interface FLViewGradients : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __normalGradientEnum;
    NSString* __selectedGradientEnum;
    NSString* __highlightedGradientEnum;
    NSString* __disabledGradientEnum;
    FLColorRange* __normalGradient;
    FLColorRange* __selectedGradient;
    FLColorRange* __highlightedGradient;
    FLColorRange* __disabledGradient;
} 


@property (readwrite, strong, nonatomic) FLColorRange* disabledGradient;

@property (readwrite, strong, nonatomic) NSString* disabledGradientEnum;

@property (readwrite, strong, nonatomic) FLColorRange* highlightedGradient;

@property (readwrite, strong, nonatomic) NSString* highlightedGradientEnum;

@property (readwrite, strong, nonatomic) FLColorRange* normalGradient;

@property (readwrite, strong, nonatomic) NSString* normalGradientEnum;

@property (readwrite, strong, nonatomic) FLColorRange* selectedGradient;

@property (readwrite, strong, nonatomic) NSString* selectedGradientEnum;

+ (NSString*) disabledGradientEnumKey;

+ (NSString*) disabledGradientKey;

+ (NSString*) highlightedGradientEnumKey;

+ (NSString*) highlightedGradientKey;

+ (NSString*) normalGradientEnumKey;

+ (NSString*) normalGradientKey;

+ (NSString*) selectedGradientEnumKey;

+ (NSString*) selectedGradientKey;

+ (FLViewGradients*) viewGradients; 

@end

@interface FLViewGradients (ValueProperties) 

@property (readwrite, assign, nonatomic) FLColorRangeEnum normalGradientEnumValue;

@property (readwrite, assign, nonatomic) FLColorRangeEnum selectedGradientEnumValue;

@property (readwrite, assign, nonatomic) FLColorRangeEnum highlightedGradientEnumValue;

@property (readwrite, assign, nonatomic) FLColorRangeEnum disabledGradientEnumValue;
@end

// [/Generated]
