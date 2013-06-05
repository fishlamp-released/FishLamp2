// 
// ZFInformationLevel.m
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

#import "ZFInformationLevel.h"

NSString* ZFInformationLevelStringFromEnum(ZFInformationLevel theEnum) {
    switch(theEnum) {
        case ZFInformationLevelLevel1:{
            return kZFInformationLevelLevel1;
        }
        break;
        case ZFInformationLevelFull:{
            return kZFInformationLevelFull;
        }
        break;
        case ZFInformationLevelLevel2:{
            return kZFInformationLevelLevel2;
        }
        break;
    }
    return nil;
}

ZFInformationLevel ZFInformationLevelEnumFromString(NSString* theString) {
    static NSDictionary* s_enumLookup = nil;
    static dispatch_once_t s_lookupPredicate = 0;
    dispatch_once(&s_lookupPredicate, ^{
        s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInteger:ZFInformationLevelLevel1], [kZFInformationLevelLevel1 lowercaseString],
            [NSNumber numberWithInteger:ZFInformationLevelFull], [kZFInformationLevelFull lowercaseString],
            [NSNumber numberWithInteger:ZFInformationLevelLevel2], [kZFInformationLevelLevel2 lowercaseString],
            nil ];
    });
    NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];
    return value == nil ? NSNotFound : [value integerValue];
}

@implementation ZFInformationLevelEnumSet
+ (id) enumSet{
    return FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  ZFInformationLevelEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) ZFInformationLevelStringFromEnum]);
}
+ (id) enumSet:(NSString*) concatenatedEnumString {
    ZFInformationLevelEnumSet* outObject = FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  ZFInformationLevelEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) ZFInformationLevelStringFromEnum]);
    [outObject setConcatenatedString:concatenatedEnumString];
    return outObject;
}
@end