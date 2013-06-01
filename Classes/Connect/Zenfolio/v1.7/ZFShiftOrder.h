// 
// ZFShiftOrder.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/31/13 7:38 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLTypeSpecificEnumSet.h"

typedef enum {
    ZFShiftOrderCreatedAsc = 0,
    ZFShiftOrderCreatedDesc = 1,
    ZFShiftOrderTakenAsc = 2,
    ZFShiftOrderTakenDesc = 3,
    ZFShiftOrderTitleAsc = 4,
    ZFShiftOrderTitleDesc = 5,
    ZFShiftOrderSizeAsc = 6,
    ZFShiftOrderSizeDesc = 7,
    ZFShiftOrderFileNameAsc = 8,
    ZFShiftOrderFileNameDesc = 9,
} ZFShiftOrder;

#define kZFShiftOrderTitleAsc @"TitleAsc"
#define kZFShiftOrderCreatedAsc @"CreatedAsc"
#define kZFShiftOrderSizeAsc @"SizeAsc"
#define kZFShiftOrderSizeDesc @"SizeDesc"
#define kZFShiftOrderTakenAsc @"TakenAsc"
#define kZFShiftOrderTitleDesc @"TitleDesc"
#define kZFShiftOrderTakenDesc @"TakenDesc"
#define kZFShiftOrderFileNameAsc @"FileNameAsc"
#define kZFShiftOrderCreatedDesc @"CreatedDesc"
#define kZFShiftOrderFileNameDesc @"FileNameDesc"

extern NSString* ZFShiftOrderStringFromEnum(ZFShiftOrder theEnum);
extern ZFShiftOrder ZFShiftOrderEnumFromString(NSString* theString);

@interface ZFShiftOrderEnumSet : FLTypeSpecificEnumSet
+ (id) enumSet;
@end
