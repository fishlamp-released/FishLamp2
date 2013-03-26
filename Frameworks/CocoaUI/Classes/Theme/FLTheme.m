//
//  FLTheme.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTheme.h"
#import "FLThemeManager.h"
#import "NSObject+FLTheme.h"

@implementation FLTheme
@synthesize themeName = _themeName;
@synthesize applicationTextStyle = _applicationTextStyle;

+ (FLTheme*) currentTheme {
    return [[FLThemeManager instance] currentTheme];
}

#if FL_MRC
- (void) dealloc {
    [_applicationTextStyle release];
    [_themeName release];
	[super dealloc];
}
#endif

- (void) applyThemeToObject:(id) object {
    SEL themeSelector = [object themeSelector];
    if(themeSelector) {
    
        themeSelector = [object willApplyTheme:self withSelector:themeSelector];
        
        if(themeSelector) {
            [self performSelector:themeSelector withObject:object];
        }
    }
}


@end
