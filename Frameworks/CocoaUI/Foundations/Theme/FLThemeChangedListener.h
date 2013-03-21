//
//  FLThemeChangedListener.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLNotificationListener.h"

@interface FLThemeChangedListener : FLNotificationListener {
}

- (id) init;
- (id) initWithTarget:(id) target;
+ (id) themeChangedListener:(id) target;
+ (id) themeChangedListener;
@end

@interface NSObject (FLTheme)
- (void) themeDidChange_fl:(id) theme;
@end

