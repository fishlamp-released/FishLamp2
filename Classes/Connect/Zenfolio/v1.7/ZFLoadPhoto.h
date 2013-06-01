// 
// ZFLoadPhoto.h
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

#import "FLModelObject.h"
@class ZFInformationLevelEnumSet;
#import "ZFInformationLevel.h"
#import "ZFInformationLevel.h"
@interface ZFLoadPhoto : FLModelObject {
@private
    long _photoId;
    NSString* _level;
}

@property (readwrite, assign, nonatomic) ZFInformationLevel levelEnum;
@property (readwrite, assign, nonatomic) long photoId;
@property (readwrite, assign, nonatomic) NSString* level;
@property (readwrite, strong, nonatomic) ZFInformationLevelEnumSet* levelEnumSet;
+ (ZFLoadPhoto*) loadPhoto;
@end
