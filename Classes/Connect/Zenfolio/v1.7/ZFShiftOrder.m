// 
// ZFShiftOrder.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 6:24 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFShiftOrder.h"

NSString* ZFShiftOrderStringFromEnum(ZFShiftOrder theEnum) {
    switch(theEnum) {
        case ZFShiftOrderTitleAsc:{
            return kZFShiftOrderTitleAsc;
        }
        break;
        case ZFShiftOrderCreatedAsc:{
            return kZFShiftOrderCreatedAsc;
        }
        break;
        case ZFShiftOrderSizeAsc:{
            return kZFShiftOrderSizeAsc;
        }
        break;
        case ZFShiftOrderSizeDesc:{
            return kZFShiftOrderSizeDesc;
        }
        break;
        case ZFShiftOrderTakenAsc:{
            return kZFShiftOrderTakenAsc;
        }
        break;
        case ZFShiftOrderTitleDesc:{
            return kZFShiftOrderTitleDesc;
        }
        break;
        case ZFShiftOrderTakenDesc:{
            return kZFShiftOrderTakenDesc;
        }
        break;
        case ZFShiftOrderFileNameAsc:{
            return kZFShiftOrderFileNameAsc;
        }
        break;
        case ZFShiftOrderCreatedDesc:{
            return kZFShiftOrderCreatedDesc;
        }
        break;
        case ZFShiftOrderFileNameDesc:{
            return kZFShiftOrderFileNameDesc;
        }
        break;
    }
    return nil;
}

ZFShiftOrder ZFShiftOrderEnumFromString(NSString* theString) {
    static NSDictionary* s_enumLookup = nil;
    static dispatch_once_t s_lookupPredicate = 0;
    dispatch_once(&s_lookupPredicate, ^{
        s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInteger:ZFShiftOrderTitleAsc], [kZFShiftOrderTitleAsc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderCreatedAsc], [kZFShiftOrderCreatedAsc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderSizeAsc], [kZFShiftOrderSizeAsc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderSizeDesc], [kZFShiftOrderSizeDesc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderTakenAsc], [kZFShiftOrderTakenAsc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderTitleDesc], [kZFShiftOrderTitleDesc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderTakenDesc], [kZFShiftOrderTakenDesc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderFileNameAsc], [kZFShiftOrderFileNameAsc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderCreatedDesc], [kZFShiftOrderCreatedDesc lowercaseString],
            [NSNumber numberWithInteger:ZFShiftOrderFileNameDesc], [kZFShiftOrderFileNameDesc lowercaseString],
            nil ];
    });
    NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];
    return value == nil ? NSNotFound : [value integerValue];
}

@implementation ZFShiftOrderEnumSet
+ (id) enumSet{
    return FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  ZFShiftOrderEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) ZFShiftOrderStringFromEnum]);
}
@end