//
//  FLTestResultCollection.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLTestResult.h"

@interface FLTestResultCollection : NSObject {
@private
    NSMutableDictionary* _results;
}
+ (id) testResultCollection;

@property (readonly, strong, nonatomic) NSDictionary* testResults;
@property (readonly, assign, nonatomic) NSArray* failedResults;

- (id) setTestResultForSelector:(SEL) selector;
- (id) setTestResultForNumber:(int) number;
- (id) setTestResultForKey:(id) key;

- (void) setTestResult:(id<FLTestResult>) result forKey:(id) key;

- (id) testResultForSelector:(SEL) selector;
- (id) testResultForNumber:(int) number;
- (id) testResultForKey:(id) key;

- (BOOL) hasTestResultForKey:(id) key;
- (BOOL) hasTestResultForNumber:(int) number;
- (BOOL) hasTestResultForSelector:(SEL) selector;

@end
