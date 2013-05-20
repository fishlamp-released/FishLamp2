//
//	GtUnitTest.h
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if UNIT_TESTS

#import "GtCallback.h"

#define UTAssert(CONDITION_, REASONFORMAT_, ...) \
		if(!(CONDITION_)) GtThrow(([NSException exceptionWithName:@"Assertion Failed" reason:[NSString stringWithFormat:@"%s (%@)", (#CONDITION_), GtStringWithFormat(REASONFORMAT_, ##__VA_ARGS__)] userInfo:nil]))

/*
//#define UTAssert(CONDITION, REASONFORMAT, ...) \
//	do { \
//		if(!(CONDITION)) { \
//			NSString* reason = GtStringWithFormat(REASONFORMAT, ##__VA_ARGS__); \
//			GtThrow([NSException exceptionWithName:@"UNITTEST ASSERTION FAILED" \
//				reason:GtAutorelease(reason) userInfo:nil]); \
//		} \
//	} \
//	while(0)
	*/
	
#define UTAssertNotNil(PTR) UTAssert((PTR) != nil, @"unexpected nil pointer")
#define UTAssertNil(PTR) UTAssert((PTR) == nil, @"unexpected non-nil parameter:\'%@\'", @#PTR)
#define UTAssertIsValidString(STR) do { NSString* str = (STR); UTAssertNotNil(str); UTAssert(str.length > 0, @"String is empty"); } while(0)
#define UTFail(msg, ...) UTAssert(NO, (msg), ##__VA_ARGS__);
#define UTAssertEqualStrings(LHS, RHS, REASONFORMAT, ...) UTAssert([LHS isEqualToString:RHS], REASONFORMAT, ##__VA_ARGS__)
#define UTAssertExpectedRetainCount(OBJ, COUNT) UTAssert([OBJ retainCount] == COUNT, @"Retain count is wrong, expected: %d, got %d", COUNT, [OBJ retainCount])

#define UTLog GtLog

@class GtUnitTestGroup;

@interface GtUnitTest : NSObject {
	Class m_class;
	SEL m_selector;
	NSException* m_exception;
	GtUnitTestGroup* m_unitTestClass;
	NSString* m_name;
	GtCallback m_callback;
	NSConditionLock* m_lock;
}

- (id) initWithTestClassAndSelector:(Class) testClass selector:(SEL) selector;

@property (readonly, retain, nonatomic) NSConditionLock* asyncLock;
- (void) didCompleteAsyncTest;
- (void) blockUntilTestCompletes;

@property (readwrite, assign, nonatomic) GtUnitTestGroup* unitTestClass;
@property (readwrite, retain, nonatomic) NSException* exception;
@property (readwrite, retain, nonatomic) NSString* name;

@property (readonly, assign, nonatomic) SEL selector;
@property (readonly, assign, nonatomic) Class testClass;

- (void) execute;

+ (GtUnitTest*) currentTest;

@end

@protocol GtUnitTestsProtocol <NSObject>
@optional
- (void) configureUnitTests:(GtUnitTest*) unitTest;
- (void) setupUnitTests:(GtUnitTest*) unitTest;
- (void) tearDownUnitTests:(GtUnitTest*) unitTest;
@end


#endif