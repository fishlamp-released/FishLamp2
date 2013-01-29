//
//  ZFPrefsService.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "ZFPreferences.h"
#import "ZFLocalPreferences.h"

@interface ZFPrefsService : FLService {
@private
    ZFPreferences* _prefs;
}

+ (id) prefsService;

- (ZFPreferences*) loadPreferences;
- (void) savePreferences:(ZFPreferences*) prefs;

- (ZFLocalPreferences*) loadLocalPreferences;
@end

FLPublishService(prefsService, ZFPrefsService*)