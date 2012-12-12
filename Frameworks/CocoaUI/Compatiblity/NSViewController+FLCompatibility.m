//
//  NSViewController+FLCompatibility.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSViewController+FLCompatibility.h"

#if OSX
@implementation NSViewController (FLCompatibility)
- (void) addChildViewController:(NSViewController*) viewController {
}
- (BOOL) isViewLoaded {
}
@end
#endif