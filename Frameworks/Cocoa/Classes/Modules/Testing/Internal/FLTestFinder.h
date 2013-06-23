//
//  FLUnitTestMethodDiscovery.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#import "FLObjcRuntime.h"

@protocol FLTestFinder <NSObject>
- (void) addPossibleUnitTestClass:(FLRuntimeInfo) info;
- (void) addPossibleTestMethod:(FLRuntimeInfo) info;
@end
