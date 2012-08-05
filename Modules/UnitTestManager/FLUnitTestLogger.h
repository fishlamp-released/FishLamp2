//
//  FLUnitTestLoggable.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

@class FLUnitTestManager;

@interface FLUnitTestLogger : NSObject {
@private
    __weak FLUnitTestManager* _manager;
}

@property (readonly, assign, nonatomic) FLUnitTestManager* unitTestManager;

- (void) log:(NSString*) string, ...;

@end
