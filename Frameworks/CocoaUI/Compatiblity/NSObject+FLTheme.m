//
//  NSObject+FLTheme.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSObject+FLTheme.h"

#if OSX
@implementation NSObject (FLThemeCompatibility)
- (void) applyThemeIfNeeded {
}
- (void) applyTheme:(FLTheme*) theme {
}

@end

#endif
