//
//	FLThemeManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTheme.h"
#import "NSObject+FLTheme.h"

@class FLSavedThemeInfo;

#define FLDefaultThemeFileName @"FLDarkTheme.flt"

extern NSString* const FLThemeDidChangeNotification;

@interface FLThemeManager : NSObject {
@private
    NSMutableArray* _themes;
}

FLSingletonProperty(FLThemeManager);

@property (readonly, strong, nonatomic) NSArray* themeFileNameList;

- (void) beginListeningToSessionChanges;

//- (FLSavedThemeInfo*) loadSavedThemeInfo;
//
//- (void) saveThemeInfo:(FLSavedThemeInfo*) themeInfo;
//
//- (void) setThemeWithThemeInfo:(FLSavedThemeInfo*) themeInfo;

- (void) loadThemeList;

- (NSString*) themePathForName:(NSString*) name;

- (void) setThemeWithFileName:(NSString*) themeName;

- (void) setDefaultTheme;

@end

