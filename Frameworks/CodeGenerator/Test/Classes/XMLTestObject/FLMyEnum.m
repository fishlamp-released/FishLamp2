// 
// FLMyEnum.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/19/13 4:22 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp
// 
// Organization: GreenTongue Software, LLC (http://www.greentongue.com)
// Copyright 2013 (c) GreenTongue Software, LLC
// Individual licensees only
// 

#import "FLMyEnum.h"

NSString* FLMyEnumStringFromEnum(FLMyEnum theEnum) {
    switch(theEnum) {
        case FLMyEnumFoobar:{
            return kFLMyEnumFoobar;
        }
        break;
        case FLMyEnumFoo:{
            return kFLMyEnumFoo;
        }
        break;
        case FLMyEnumBar:{
            return kFLMyEnumBar;
        }
        break;
    }
    return nil;
}

FLMyEnum FLMyEnumEnumFromString(NSString* theString) {
    static NSDictionary* s_enumLookup = nil;
    static dispatch_once_t s_lookupPredicate = 0;
    dispatch_once(&s_lookupPredicate, ^{
        s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInteger:FLMyEnumFoobar], [kFLMyEnumFoobar lowercaseString],
            [NSNumber numberWithInteger:FLMyEnumFoo], [kFLMyEnumFoo lowercaseString],
            [NSNumber numberWithInteger:FLMyEnumBar], [kFLMyEnumBar lowercaseString],
            nil ];
    });
    NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];
    return value == nil ? NSNotFound : [value integerValue];
}

@implementation FLMyEnumEnumSet
+ (id) enumSet{
    return FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  FLMyEnumEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) FLMyEnumStringFromEnum]);
}
+ (id) enumSet:(NSString*) concatenatedEnumString {
    FLMyEnumEnumSet* outObject = FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  FLMyEnumEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) FLMyEnumStringFromEnum]);
    [outObject setConcatenatedString:concatenatedEnumString];
    return outObject;
}
@end
