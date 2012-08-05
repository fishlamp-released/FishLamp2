

#import "FLUnitTest.h"
#import "_FLUnitTestLogger.h"

@interface FLUnitTest ()
@property (readwrite, assign, nonatomic) FLUnitTestState testState;
@property (readwrite, assign, nonatomic) FLUnitTestGroup* unitTestGroup;
@property (readonly, strong, nonatomic) id testCase;

- (id) initWithTestCase:(id) testCase;
+ (FLUnitTest*) unitTest:(id) testCase;

- (void) runTest;

@end

