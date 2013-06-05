// 
// ZFInformationLevel.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLTypeSpecificEnumSet.h"

typedef enum {
    ZFInformationLevelLevel1 = 0,
    ZFInformationLevelLevel2 = 1,
    ZFInformationLevelFull = 2,
} ZFInformationLevel;

#define kZFInformationLevelLevel1 @"Level1"
#define kZFInformationLevelFull @"Full"
#define kZFInformationLevelLevel2 @"Level2"

extern NSString* ZFInformationLevelStringFromEnum(ZFInformationLevel theEnum);
extern ZFInformationLevel ZFInformationLevelEnumFromString(NSString* theString);

@interface ZFInformationLevelEnumSet : FLTypeSpecificEnumSet
+ (id) enumSet;
+ (id) enumSet:(NSString*) concatenatedEnumString;
@end