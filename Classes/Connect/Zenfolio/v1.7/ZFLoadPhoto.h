// 
// ZFLoadPhoto.h
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

#import "FLModelObject.h"
#import "ZFInformationLevel.h"

@class ZFInformationLevelEnumSet;

@interface ZFLoadPhoto : FLModelObject {
@private
    long _photoId;
    NSString* _level;
}

@property (readwrite, strong, nonatomic) NSString* level;
@property (readwrite, assign, nonatomic) ZFInformationLevel levelEnum;
@property (readwrite, strong, nonatomic) ZFInformationLevelEnumSet* levelEnumSet;
@property (readwrite, assign, nonatomic) long photoId;

+ (ZFLoadPhoto*) loadPhoto;

@end
