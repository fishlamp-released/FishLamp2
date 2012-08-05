// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLViewColors.h
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLViewColors
// --------------------------------------------------------------------
@interface FLViewColors : NSObject<NSCopying, NSCoding>{ 
@private
    CocoaColor* __normalColor;
    CocoaColor* __selectedColor;
    CocoaColor* __highlightedColor;
    CocoaColor* __disabledColor;
} 


@property (readwrite, strong, nonatomic) CocoaColor* disabledColor;

@property (readwrite, strong, nonatomic) CocoaColor* highlightedColor;

@property (readwrite, strong, nonatomic) CocoaColor* normalColor;

@property (readwrite, strong, nonatomic) CocoaColor* selectedColor;

+ (NSString*) disabledColorKey;

+ (NSString*) highlightedColorKey;

+ (NSString*) normalColorKey;

+ (NSString*) selectedColorKey;

+ (FLViewColors*) viewColors; 

@end

@interface FLViewColors (ValueProperties) 
@end

// [/Generated]
