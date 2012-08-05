//
//  FLUnitTestCase.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@class FLUnitTest;

@protocol FLUnitTestCase <NSObject> 
@property (readonly, strong, nonatomic) NSString* testName;
- (void) runTest:(FLUnitTest*) unitTest;
@end

@interface FLUnitTestCase : NSObject<FLUnitTestCase> {
@private
	Class _class;
	SEL _selector;
}
@property (readonly, assign, nonatomic) SEL selector;
@property (readonly, assign, nonatomic) Class testClass;

- (id) initWithTestClass:(Class) testClass selector:(SEL) selector;

+ (FLUnitTestCase*) unitTestCase:(Class) testClass selector:(SEL) selector;

@end
