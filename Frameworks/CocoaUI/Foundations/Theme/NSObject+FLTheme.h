//
//  NSObject+FLTheme.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

#if OSX
typedef id FLTheme;
@interface NSObject (FLThemeCompatibility)
- (void) applyThemeIfNeeded;
- (void) applyTheme:(FLTheme*) theme;
@end
#endif
