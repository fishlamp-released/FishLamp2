//
//  FLThemeManager.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLTheme.h"

extern NSString* FLThemeChangedNotificationKey;
extern NSString* FLCurrentThemeKey;

@interface FLThemeManager : NSObject{
@private
    id _currentTheme;
    NSMutableArray* _themes;
}

@property (readwrite, strong, nonatomic) id currentTheme;
@property (readonly, strong, nonatomic) NSArray* themes;

FLSingletonProperty(FLThemeManager);

- (void) addTheme:(FLTheme*) theme;
- (void) addThemesWithArray:(NSArray*) themes;

- (NSArray*) loadThemesFromBundleXmlFile:(NSString*) fileName  themeClass:(Class) themeClass;


@end

