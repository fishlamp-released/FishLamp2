//
//	FLUnitTestGroup.h
//	PackMule
//
//	Created by Mike Fullerton on 4/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@class FLUnitTestManager;
#import "FLUnitTest.h"
#import "FLUnitTestLogger.h"

@interface FLUnitTestGroup : FLUnitTestLogger {
@private
	NSMutableArray* _unitTests;
    NSMutableArray* _testRun;
	Class _class;
    NSMutableDictionary* _data;
	NSString* _groupName;
}

@property (readonly, retain, nonatomic) NSString* groupName;

- (void) setObject:(id) object forKey:(id) key;
- (id) objectForKey:(id) key;
@end
