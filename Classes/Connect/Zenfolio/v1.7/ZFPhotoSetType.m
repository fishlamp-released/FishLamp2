// 
// ZFPhotoSetType.m
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

#import "ZFPhotoSetType.h"

NSString* ZFPhotoSetTypeStringFromEnum(ZFPhotoSetType theEnum) {
    switch(theEnum) {
        case ZFPhotoSetTypeGallery:{
            return kZFPhotoSetTypeGallery;
        }
        break;
        case ZFPhotoSetTypeCollection:{
            return kZFPhotoSetTypeCollection;
        }
        break;
    }
    return nil;
}

ZFPhotoSetType ZFPhotoSetTypeEnumFromString(NSString* theString) {
    static NSDictionary* s_enumLookup = nil;
    static dispatch_once_t s_lookupPredicate = 0;
    dispatch_once(&s_lookupPredicate, ^{
        s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInteger:ZFPhotoSetTypeGallery], [kZFPhotoSetTypeGallery lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoSetTypeCollection], [kZFPhotoSetTypeCollection lowercaseString],
            nil ];
    });
    NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];
    return value == nil ? NSNotFound : [value integerValue];
}

@implementation ZFPhotoSetTypeEnumSet
+ (id) enumSet{
    return FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  ZFPhotoSetTypeEnumFromString stringLookup:(FLEnumSetEnumStringLookup*) ZFPhotoSetTypeStringFromEnum]);
}
@end
