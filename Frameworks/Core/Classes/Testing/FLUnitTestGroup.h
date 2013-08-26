//
//  FLUnitTestGroup.h
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"

#define FLUnitTestPriorityLow           0
#define FLUnitTestPriorityNormal        1000
#define FLUnitTestPriorityHigh          2000
#define FLUnitTestPriorityFramework     3000
#define FLUnitTestPrioritySanityCheck   4000

@interface FLUnitTestGroup : NSObject<NSCopying> {
@private
    NSString* _groupName;
    SInt32 _groupPriority;
}

@property (readonly, strong) NSString* groupName;
@property (readonly, assign) SInt32 groupPriority;

+ (id) unitTestGroup:(NSString*) name priority:(SInt32) priority;

- (id) initWithGroupName:(NSString*) name priority:(SInt32) priority;

// default groups
+ (FLUnitTestGroup*) sanityCheckTestGroup;
+ (FLUnitTestGroup*) frameworkTestGroup;
+ (FLUnitTestGroup*) importantTestGroup;
+ (FLUnitTestGroup*) defaultTestGroup;
+ (FLUnitTestGroup*) lastTestGroup;

@end
