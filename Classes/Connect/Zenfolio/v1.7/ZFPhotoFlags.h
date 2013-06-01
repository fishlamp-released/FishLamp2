// 
// ZFPhotoFlags.h
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
    ZFPhotoFlagsNone = 0,
    ZFPhotoFlagsHasTitle = 1,
    ZFPhotoFlagsHasCaption = 2,
    ZFPhotoFlagsHasKeywords = 3,
    ZFPhotoFlagsHasCategories = 4,
    ZFPhotoFlagsHasExif = 5,
    ZFPhotoFlagsHasComments = 6,
} ZFPhotoFlags;

#define kZFPhotoFlagsHasExif @"HasExif"
#define kZFPhotoFlagsHasCategories @"HasCategories"
#define kZFPhotoFlagsHasTitle @"HasTitle"
#define kZFPhotoFlagsHasCaption @"HasCaption"
#define kZFPhotoFlagsNone @"None"
#define kZFPhotoFlagsHasComments @"HasComments"
#define kZFPhotoFlagsHasKeywords @"HasKeywords"

extern NSString* ZFPhotoFlagsStringFromEnum(ZFPhotoFlags theEnum);
extern ZFPhotoFlags ZFPhotoFlagsEnumFromString(NSString* theString);

@interface ZFPhotoFlagsEnumSet : FLTypeSpecificEnumSet
+ (id) enumSet;
@end
