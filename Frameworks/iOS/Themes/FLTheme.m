// [Generated]
//
// FLTheme.m
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "FLTheme.h"
#import "FLDefaultTheme.h"

//static FLTheme* s_theme = nil;

#define kButtonHeight 40.0f

@implementation FLTheme

@synthesize alertViewThemeApplicator = _alertStyleHandler;

- (void) dealloc {
    FLRelease(_alertStyleHandler);
    super_dealloc_();
}

+ (FLTheme*) currentTheme {
    return [FLDefaultTheme instance];

//    return s_theme;
}

+ (void) setCurrentTheme:(FLTheme*) theme {
//    FLSetObjectWithRetain(s_theme, theme);
//    [s_theme wasSetToCurrentTheme];
}

- (void) wasSetToCurrentTheme {

//    if(nil == self.defaultGradient)  {
//        if(FLStringIsNotEmpty(self.defaultGradientName)) {
//            self.defaultGradient = [FLColorRange colorRangeWithColorRangeName:self.defaultGradientNameValue];
//        }
//    }

}




@end
