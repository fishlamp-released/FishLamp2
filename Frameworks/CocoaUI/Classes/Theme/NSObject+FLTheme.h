//
//  NSObject+Theming.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLThemeChangedListener.h"

@interface NSObject (Themes)
@property (readonly, assign, nonatomic) BOOL isThemable;
@property (readwrite, strong, nonatomic) NSString* themeSelectorString;
@property (readwrite, assign, nonatomic) SEL themeSelector;

+ (SEL) themeSelector;

- (SEL) willApplyTheme:(id) theme withSelector:(SEL) selector;
- (void) themeDidChange:(id) theme;
@end
