// 
// ZFSortOrder.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFSortOrder.h"

NSString* ZFSortOrderStringFromEnum(ZFSortOrder theEnum) {
    switch(theEnum) {
        case ZFSortOrderRank:{
            return kZFSortOrderRank;
        }
        break;
        case ZFSortOrderDate:{
            return kZFSortOrderDate;
        }
        break;
        case ZFSortOrderPopularity:{
            return kZFSortOrderPopularity;
        }
        break;
    }
    return nil;
}

ZFSortOrder ZFSortOrderEnumFromString(NSString* theString) {
    static NSDictionary* s_enumLookup = nil;
    static dispatch_once_t s_lookupPredicate = 0;
    dispatch_once(&s_lookupPredicate, ^{
        s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInteger:ZFSortOrderRank], [kZFSortOrderRank lowercaseString],
            [NSNumber numberWithInteger:ZFSortOrderDate], [kZFSortOrderDate lowercaseString],
            [NSNumber numberWithInteger:ZFSortOrderPopularity], [kZFSortOrderPopularity lowercaseString],
            nil ];
    });
    NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];
    return value == nil ? NSNotFound : [value integerValue];
}

@implementation ZFSortOrderEnumSet
+ (id) enumSet{
    return FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  ZFSortOrderEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) ZFSortOrderStringFromEnum]);
}
+ (id) enumSet:(NSString*) concatenatedEnumString {
    ZFSortOrderEnumSet* outObject = FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  ZFSortOrderEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) ZFSortOrderStringFromEnum]);
    [outObject setConcatenatedString:concatenatedEnumString];
    return outObject;
}
@end
