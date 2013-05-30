// 
// ZFPhotoRotation.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFPhotoRotation.h"

NSString* ZFPhotoRotationStringFromEnum(ZFPhotoRotation theEnum) {
    switch(theEnum) {
        case ZFPhotoRotationNone:{
            return kZFPhotoRotationNone;
        }
        break;
        case ZFPhotoRotationRotate90:{
            return kZFPhotoRotationRotate90;
        }
        break;
        case ZFPhotoRotationRotate90Flip:{
            return kZFPhotoRotationRotate90Flip;
        }
        break;
        case ZFPhotoRotationRotate270:{
            return kZFPhotoRotationRotate270;
        }
        break;
        case ZFPhotoRotationRotate180Flip:{
            return kZFPhotoRotationRotate180Flip;
        }
        break;
        case ZFPhotoRotationRotate180:{
            return kZFPhotoRotationRotate180;
        }
        break;
        case ZFPhotoRotationFlip:{
            return kZFPhotoRotationFlip;
        }
        break;
        case ZFPhotoRotationRotate270Flip:{
            return kZFPhotoRotationRotate270Flip;
        }
        break;
    }
    FLAssertFailedWithComment(@"Unknown enum value %d", theEnum);
    return nil;
}

ZFPhotoRotation ZFPhotoRotationEnumFromString(NSString* theString) {
    static NSDictionary* s_enumLookup = nil;
    static dispatch_once_t s_lookupPredicate = 0;
    dispatch_once(&s_lookupPredicate, ^{
        s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInteger:ZFPhotoRotationNone], [kZFPhotoRotationNone lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoRotationRotate90], [kZFPhotoRotationRotate90 lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoRotationRotate90Flip], [kZFPhotoRotationRotate90Flip lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoRotationRotate270], [kZFPhotoRotationRotate270 lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoRotationRotate180Flip], [kZFPhotoRotationRotate180Flip lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoRotationRotate180], [kZFPhotoRotationRotate180 lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoRotationFlip], [kZFPhotoRotationFlip lowercaseString],
            [NSNumber numberWithInteger:ZFPhotoRotationRotate270Flip], [kZFPhotoRotationRotate270Flip lowercaseString],
            nil ];
    });
    return [[s_enumLookup objectForKey:[theString lowercaseString]] integerValue];
}
