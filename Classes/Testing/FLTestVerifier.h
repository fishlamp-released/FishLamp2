//
//  FLTestVerifier.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    FLTestResultPass,
//    FLTestResultDuplicateExpected,
//    FLTestResultDuplicateResult,
//    FLTestResultCollision,
//    FLTestResultNotExpected,
//    FLTestResultExpectedResultNotReceived,
//    FLTestException
//} FLTestResultEnum;
//
//
//@interface FLTestResult : NSObject {
//@private
//    int _result;
//    id _what;
//}
//@property (readwrite, strong) id what;
//@property (readwrite, assign) int result;
//@property (readwrite, strong) NSString* comment;
//
//- (id) initWithResult:(int) result what:(id) what comment:(NSString*) comment;
//+ (id) testResult:(int) result what:(id) what comment:(NSString*) comment;
//@end

//@protocol FLTestResults <NSObject>
//- (void) addTestResult:(FLTestResult*) result;
//@property (readonly, assign) BOOL testPassed;
//@property (readonly, strong) NSArray* testResults;
//- (void) reset;
//- (void) clear;
//@end


@interface FLTestVerifier : NSObject {
@private
    NSMutableSet* _expected;
    NSMutableSet* _handled;
    NSMutableArray* _results;
}
@property (readonly, strong) NSArray* testResults;
- (void) reset;
- (void) clear;

- (void) addExpectedSelector:(SEL) selector;
- (void) addExpectedResult:(id) expected;

- (void) addHandledResult:(id) result;
- (void) addHandledSelector:(SEL) selector;

- (BOOL) checkResults;

@end
