//
//  FLUnitTestGroup.h
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLUnitTestPriorityLow           0
#define FLUnitTestPriorityNormal        1000
#define FLUnitTestPriorityHigh          2000
#define FLUnitTestPriorityFramework     3000
#define FLUnitTestPrioritySanityCheck   4000

@interface FLUnitTestGroup : NSObject<NSCopying> {
@private
    NSString* _groupName;
    int32_t _groupPriority;
}

@property (readonly, strong) NSString* groupName;
@property (readonly, assign) int32_t groupPriority;

+ (id) unitTestGroup:(NSString*) name priority:(int32_t) priority;
- (id) initWithGroupName:(NSString*) name priority:(int32_t) priority;

+ (FLUnitTestGroup*) sanityTestGroup;
+ (FLUnitTestGroup*) frameworkTestGroup;
+ (FLUnitTestGroup*) importantTestGroup;
+ (FLUnitTestGroup*) defaultTestGroup;
+ (FLUnitTestGroup*) lastTestGroup;

@end
