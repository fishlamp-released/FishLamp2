//
//	GtThemeManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "NSObject+GtTheme.h"

@class GtTheme;
@class GtSavedThemeInfo;

extern NSString* const GtThemeDidChangeNotification;

@interface GtThemeManager : NSObject {
}

- (void) setTheme:(GtTheme*) theme;

+ (id) theme;

+ (BOOL) applyThemeToObject:(id) object themeAction:(SEL) themeAction;
+ (id) queryTheme:(SEL) themeQuery;

GtSingletonProperty(GtThemeManager);

- (void) beginListeningToSessionChanges;

- (GtSavedThemeInfo*) loadSavedThemeInfo;

- (void) saveThemeInfo:(GtSavedThemeInfo*) themeInfo;

- (void) setThemeWithThemeInfo:(GtSavedThemeInfo*) themeInfo;

- (void) loadThemeList;

@end

