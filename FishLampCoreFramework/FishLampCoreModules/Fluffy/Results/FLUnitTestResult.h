//
//  FLUnitTestResult.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestResultCollection.h"
@class FLUnitTest;

@interface FLUnitTestResult : FLTestResultCollection {
@private
    FLUnitTest* _unitTest;
}

@property (readonly, strong) FLUnitTest* unitTest;

@end