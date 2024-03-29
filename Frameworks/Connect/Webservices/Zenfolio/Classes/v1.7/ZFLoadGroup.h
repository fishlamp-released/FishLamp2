// 
// ZFLoadGroup.h
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

#import "FLModelObject.h"
#import "ZFInformationLevel.h"

@class ZFInformationLevelEnumSet;

@interface ZFLoadGroup : FLModelObject {
@private
    long _groupId;
    NSString* _level;
    BOOL _includeChildren;
}

@property (readwrite, assign, nonatomic) long groupId;
@property (readwrite, assign, nonatomic) BOOL includeChildren;
@property (readwrite, strong, nonatomic) NSString* level;
@property (readwrite, assign, nonatomic) ZFInformationLevel levelEnum;
@property (readwrite, strong, nonatomic) ZFInformationLevelEnumSet* levelEnumSet;

+ (ZFLoadGroup*) loadGroup;

@end
