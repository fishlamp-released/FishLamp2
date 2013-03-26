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
@private
    SEL _themeSelector;
}
@property (readwrite, assign, nonatomic) SEL targetThemeSelector;

- (id) initWithTarget:(id) target withSelector:(SEL) selector;
+ (id) themeChangedListener:(id) target withSelector:(SEL) selector;
@end

