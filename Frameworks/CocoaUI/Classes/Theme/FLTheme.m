//
//  FLTheme.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTheme.h"
#import "FLThemeManager.h"

@implementation FLTheme
@synthesize themeName = _themeName;

+ (FLTheme*) currentTheme {
    return [[FLThemeManager instance] currentTheme];
}

#if FL_MRC
- (void) dealloc {
	[_themeName release];
	[super dealloc];
}
#endif

@end
