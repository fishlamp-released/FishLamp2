// 
// ZFAccessType.m
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

#import "ZFAccessType.h"

NSString* ZFAccessTypeStringFromEnum(ZFAccessType theEnum) {
    switch(theEnum) {
        case ZFAccessTypePassword:{
            return kZFAccessTypePassword;
        }
        break;
        case ZFAccessTypeUserList:{
            return kZFAccessTypeUserList;
        }
        break;
        case ZFAccessTypePrivate:{
            return kZFAccessTypePrivate;
        }
        break;
        case ZFAccessTypePublic:{
            return kZFAccessTypePublic;
        }
        break;
    }
    return nil;
}

ZFAccessType ZFAccessTypeEnumFromString(NSString* theString) {
    static NSDictionary* s_enumLookup = nil;
    static dispatch_once_t s_lookupPredicate = 0;
    dispatch_once(&s_lookupPredicate, ^{
        s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInteger:ZFAccessTypePassword], [kZFAccessTypePassword lowercaseString],
            [NSNumber numberWithInteger:ZFAccessTypeUserList], [kZFAccessTypeUserList lowercaseString],
            [NSNumber numberWithInteger:ZFAccessTypePrivate], [kZFAccessTypePrivate lowercaseString],
            [NSNumber numberWithInteger:ZFAccessTypePublic], [kZFAccessTypePublic lowercaseString],
            nil ];
    });
    NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];
    return value == nil ? NSNotFound : [value integerValue];
}

@implementation ZFAccessTypeEnumSet
+ (id) enumSet{
    return FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  ZFAccessTypeEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) ZFAccessTypeStringFromEnum]);
}
@end