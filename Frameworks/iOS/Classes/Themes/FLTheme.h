// FLTheme.h
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.

#import "FLThemeApplicator.h"

@interface FLTheme : NSObject {
@private
    id _alertStyleHandler;
}

+ (FLTheme*) currentTheme;
+ (void) setCurrentTheme:(FLTheme*) theme;

- (void) wasSetToCurrentTheme;

@property (readwrite, strong, nonatomic) id alertViewThemeApplicator;

@end
