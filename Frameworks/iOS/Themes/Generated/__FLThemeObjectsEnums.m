// [Generated]
//
// This file was generated at 5/29/12 8:27 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLThemeObjectsEnums.m
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLThemeObjectsEnums.h"
@implementation FLThemeObjectsEnumLookup
FLSynthesizeSingleton(FLThemeObjectsEnumLookup);
- (id) init {
    if((self = [super init])) {
        _strings = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:FLFontFaceNormal], kFLFontFaceNormal, 
            [NSNumber numberWithInt:FLFontFaceBold], kFLFontFaceBold, 
            [NSNumber numberWithInt:FLFontFaceItalic], kFLFontFaceItalic, 
            [NSNumber numberWithInt:FLFontFaceUnderline], kFLFontFaceUnderline, 
            [NSNumber numberWithInt:FLFontFaceAllCaps], kFLFontFaceAllCaps, 
            [NSNumber numberWithInt:FLFontSizeSystem], kFLFontSizeSystem, 
            [NSNumber numberWithInt:FLFontSizeButton], kFLFontSizeButton, 
            [NSNumber numberWithInt:FLFontSizeSmall], kFLFontSizeSmall, 
            [NSNumber numberWithInt:FLFontNameDefault], kFLFontNameDefault, 
            [NSNumber numberWithInt:FLColorRangeEnumNone], kFLColorRangeEnumNone, 
            [NSNumber numberWithInt:FLColorRangeEnumIPhoneBlue], kFLColorRangeEnumIPhoneBlue, 
            [NSNumber numberWithInt:FLColorRangeEnumRed], kFLColorRangeEnumRed, 
            [NSNumber numberWithInt:FLColorRangeEnumPaleBlue], kFLColorRangeEnumPaleBlue, 
            [NSNumber numberWithInt:FLColorRangeEnumBrightBlue], kFLColorRangeEnumBrightBlue, 
            [NSNumber numberWithInt:FLColorRangeEnumDarkGray], kFLColorRangeEnumDarkGray, 
            [NSNumber numberWithInt:FLColorRangeEnumDarkGrayWithBlueTint], kFLColorRangeEnumDarkGrayWithBlueTint, 
            [NSNumber numberWithInt:FLColorRangeEnumBlack], kFLColorRangeEnumBlack, 
            [NSNumber numberWithInt:FLColorRangeEnumGray], kFLColorRangeEnumGray, 
            [NSNumber numberWithInt:FLColorRangeEnumLightGray], kFLColorRangeEnumLightGray, 
            [NSNumber numberWithInt:FLColorRangeEnumLightLightGray], kFLColorRangeEnumLightLightGray, 
         nil];
    }
    return self;
}

- (NSInteger) lookupString:(NSString*) inString {
    NSNumber* num = [_strings objectForKey:inString];
    if(!num) { FLThrowErrorCodeWithComment(FLErrorDomainName, FLErrorUnknownEnumValue, [NSString stringWithFormat:(NSLocalizedString(@"Unknown enum value (case sensitive): %@", nil)), inString]); } 
    return [num intValue];
}

- (NSString*) stringFromFontFace:(FLFontFace) inEnum {
    switch(inEnum) {
        case FLFontFaceNormal: return kFLFontFaceNormal;
        case FLFontFaceBold: return kFLFontFaceBold;
        case FLFontFaceItalic: return kFLFontFaceItalic;
        case FLFontFaceUnderline: return kFLFontFaceUnderline;
        case FLFontFaceAllCaps: return kFLFontFaceAllCaps;
    }
    return nil;
}

- (FLFontFace) fontFaceFromString:(NSString*) inString {
    return (FLFontFace) [self lookupString:inString];
}


- (NSString*) stringFromFontSize:(FLFontSize) inEnum {
    switch(inEnum) {
        case FLFontSizeSystem: return kFLFontSizeSystem;
        case FLFontSizeButton: return kFLFontSizeButton;
        case FLFontSizeSmall: return kFLFontSizeSmall;
    }
    return nil;
}

- (FLFontSize) fontSizeFromString:(NSString*) inString {
    return (FLFontSize) [self lookupString:inString];
}


- (NSString*) stringFromFontName:(FLFontName) inEnum {
    switch(inEnum) {
        case FLFontNameDefault: return kFLFontNameDefault;
    }
    return nil;
}

- (FLFontName) fontNameFromString:(NSString*) inString {
    return (FLFontName) [self lookupString:inString];
}


- (NSString*) stringFromColorRangeEnum:(FLColorRangeEnum) inEnum {
    switch(inEnum) {
        case FLColorRangeEnumNone: return kFLColorRangeEnumNone;
        case FLColorRangeEnumIPhoneBlue: return kFLColorRangeEnumIPhoneBlue;
        case FLColorRangeEnumRed: return kFLColorRangeEnumRed;
        case FLColorRangeEnumPaleBlue: return kFLColorRangeEnumPaleBlue;
        case FLColorRangeEnumBrightBlue: return kFLColorRangeEnumBrightBlue;
        case FLColorRangeEnumDarkGray: return kFLColorRangeEnumDarkGray;
        case FLColorRangeEnumDarkGrayWithBlueTint: return kFLColorRangeEnumDarkGrayWithBlueTint;
        case FLColorRangeEnumBlack: return kFLColorRangeEnumBlack;
        case FLColorRangeEnumGray: return kFLColorRangeEnumGray;
        case FLColorRangeEnumLightGray: return kFLColorRangeEnumLightGray;
        case FLColorRangeEnumLightLightGray: return kFLColorRangeEnumLightLightGray;
    }
    return nil;
}

- (FLColorRangeEnum) colorRangeEnumFromString:(NSString*) inString {
    return (FLColorRangeEnum) [self lookupString:inString];
}

@end
// [/Generated]
