//
//  FLUnitTestMethodDiscovery.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObjcRuntime.h"
@protocol FLUnitTestDiscovery <NSObject>
- (void) addPossibleUnitTestClass:(FLRuntimeInfo) info;
- (void) addPossibleTestMethod:(FLRuntimeInfo) info;
@end
