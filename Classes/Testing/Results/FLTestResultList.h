//
//  FLTestResultList.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTestResult.h"

@interface FLTestResultList : NSObject<FLTestResult> {
@private
    NSMutableArray* _results;
    NSInteger _failCount;
    NSInteger _runCount;
}

@property (readonly, assign, nonatomic) NSInteger runCount;
@property (readonly, assign, nonatomic) NSInteger failCount;
@property (readonly, strong, nonatomic) NSArray* results;

+ (FLTestResultList*) testResultList;

- (void) addTestResult:(id<FLTestResult>) result;

@end

