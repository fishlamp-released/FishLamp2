//
//	FLUnitTestGroup.m
//	PackMule
//
//	Created by Mike Fullerton on 4/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLUnitTestGroup.h"
#import "FLUnitTest.h"
#import "_FLUnitTestGroup.h"
#import "_FLUnitTest.h"

@implementation FLUnitTestGroup

@synthesize unitTests = _unitTests;
@synthesize groupName = _groupName;

- (id) initWithClass:(Class) aClass {
	if((self = [super init])) {
		_class = aClass;
		_unitTests = [[NSMutableArray alloc] init];
        self.groupName = NSStringFromClass(aClass);
    }
	
	return self;
}

+ (FLUnitTestGroup*) unitTestGroup:(Class) aClass {
    return FLReturnAutoreleased([[FLUnitTestGroup alloc] initWithClass:aClass]);
}

- (void) dealloc {
    FLReleaseWithNil(_groupName);
	FLReleaseWithNil(_data);
	FLReleaseWithNil(_unitTests);
	FLSuperDealloc();
}

- (void) setup {

    @try {
        for(FLUnitTest* test in _unitTests) {
            test.testState = FLUnitTestStateNone;
        }
        if([_class respondsToSelector:@selector(_willStartUnitTestsForGroup:)]) {
            [_class performSelector:@selector(_willStartUnitTestsForGroup:) withObject:self];
        }
    } 
    @catch(NSException* ex) {
        for(FLUnitTest* test in _unitTests) {
            [test setFailed:@"Test setup failed: %@", [ex description]];
        }
    }
    
}

- (void) tearDown {
	if([_class respondsToSelector:@selector(_didFinishUnitTestsForGroup:)]) {
		[_class performSelector:@selector(_didFinishUnitTestsForGroup:) withObject:self];
	}
	
	FLReleaseWithNil(_data);
}

NSInteger CompareUnitTests(FLUnitTest* lhs, FLUnitTest* rhs, void* state) {

    return [lhs.testName compare:rhs.testName]; 
}

- (void) addUnitTest:(FLUnitTest*) test {
	[_unitTests addObject:test];
	[_unitTests sortUsingFunction:CompareUnitTests context:nil];
}

- (void) setObject:(id) object forKey:(id) key {
    @synchronized(self) {
        if(!_data) {
            _data = [[NSMutableDictionary alloc] init];
        }
        
        [_data setObject:object forKey:key];
    }
}

- (id) objectForKey:(id) key {
    @synchronized(self) {
        return [_data objectForKey:key];
    }
    return nil;
}


@end
