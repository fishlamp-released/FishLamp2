//
//	GtUnitTestGroup.h
//	PackMule
//
//	Created by Mike Fullerton on 4/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if UNIT_TESTS
#import <Foundation/Foundation.h>

@class GtUnitTestManager;
#import "GtUnitTest.h"

@interface GtUnitTestGroup : NSObject {
	NSMutableArray* m_unitTests;
	Class m_class;
	id m_userData;
	NSString* m_domain;
	GtUnitTestManager* m_manager;
	
}


- (id) initWithClass:(Class) aClass;

@property (readwrite, retain, nonatomic) id userData;
@property (readonly, retain, nonatomic) NSMutableArray* unitTests;
@property (readonly, assign, nonatomic) GtUnitTestManager* manager;
@property (readwrite, retain, nonatomic) NSString* domain;

- (void) addUnitTest:(GtUnitTest*) test;

- (void) setup;
- (void) tearDown;

- (void) runTests;

@end
#endif