// [Generated]
//
// This file was generated at 5/29/12 8:27 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLThemeObjectsEnums.h
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#define kFLFontFaceNormal @"Normal"
#define kFLFontFaceBold @"Bold"
#define kFLFontFaceItalic @"Italic"
#define kFLFontFaceUnderline @"Underline"
#define kFLFontFaceAllCaps @"AllCaps"
#define kFLFontSizeSystem @"System"
#define kFLFontSizeButton @"Button"
#define kFLFontSizeSmall @"Small"
#define kFLFontNameDefault @"Default"
#define kFLColorRangeEnumNone @"None"
#define kFLColorRangeEnumIPhoneBlue @"IPhoneBlue"
#define kFLColorRangeEnumRed @"Red"
#define kFLColorRangeEnumPaleBlue @"PaleBlue"
#define kFLColorRangeEnumBrightBlue @"BrightBlue"
#define kFLColorRangeEnumDarkGray @"DarkGray"
#define kFLColorRangeEnumDarkGrayWithBlueTint @"DarkGrayWithBlueTint"
#define kFLColorRangeEnumBlack @"Black"
#define kFLColorRangeEnumGray @"Gray"
#define kFLColorRangeEnumLightGray @"LightGray"
#define kFLColorRangeEnumLightLightGray @"LightLightGray"

typedef enum {
    FLFontFaceNormal,
    FLFontFaceBold,
    FLFontFaceItalic,
    FLFontFaceUnderline,
    FLFontFaceAllCaps,
} FLFontFace;

typedef enum {
    FLFontSizeSystem,
    FLFontSizeButton,
    FLFontSizeSmall,
} FLFontSize;

typedef enum {
    FLFontNameDefault,
} FLFontName;

typedef enum {
    FLColorRangeEnumNone,
    FLColorRangeEnumIPhoneBlue,
    FLColorRangeEnumRed,
    FLColorRangeEnumPaleBlue,
    FLColorRangeEnumBrightBlue,
    FLColorRangeEnumDarkGray,
    FLColorRangeEnumDarkGrayWithBlueTint,
    FLColorRangeEnumBlack,
    FLColorRangeEnumGray,
    FLColorRangeEnumLightGray,
    FLColorRangeEnumLightLightGray,
} FLColorRangeEnum;


@interface FLThemeObjectsEnumLookup : NSObject {
	NSDictionary* _strings;
}
FLSingletonProperty(FLThemeObjectsEnumLookup);

- (NSString*) stringFromFontFace:(FLFontFace) inEnum;
- (FLFontFace) fontFaceFromString:(NSString*) inString;

- (NSString*) stringFromFontSize:(FLFontSize) inEnum;
- (FLFontSize) fontSizeFromString:(NSString*) inString;

- (NSString*) stringFromFontName:(FLFontName) inEnum;
- (FLFontName) fontNameFromString:(NSString*) inString;

- (NSString*) stringFromColorRangeEnum:(FLColorRangeEnum) inEnum;
- (FLColorRangeEnum) colorRangeEnumFromString:(NSString*) inString;
@end
// [/Generated]
