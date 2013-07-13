//
//  FLTestCaseList.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"

@class FLTestCase;

@interface FLTestCaseList : NSObject<NSFastEnumeration> {
@private
    NSMutableArray* _testCases;
}

+ (id) testCaseList;

- (void) addTestCase:(FLTestCase*) testCase;

- (FLTestCase*) findTestCaseForName:(NSString*) name;
- (FLTestCase*) findTestCaseForSelector:(SEL) selector;


@end