//
//  FLUnitTestResult.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestResultList.h"
@class FLUnitTest;

@interface FLUnitTestResult : FLTestResultList {
@private
    FLUnitTest* _unitTest;
}

@property (readonly, strong) FLUnitTest* unitTest;

@end