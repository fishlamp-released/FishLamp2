// 
// ZFApiAccessMask.h
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

#import "FLTypeSpecificEnumSet.h"

typedef enum {
    ZFApiAccessMaskProtectAll = 0,
    ZFApiAccessMaskNoCollections = 1,
    ZFApiAccessMaskNone = 2,
    ZFApiAccessMaskNoPrivateSearch = 3,
    ZFApiAccessMaskNoPublicSearch = 4,
    ZFApiAccessMaskNoRecentList = 5,
    ZFApiAccessMaskHideDateCreated = 6,
    ZFApiAccessMaskHideDateModified = 7,
    ZFApiAccessMaskHideDateTaken = 8,
    ZFApiAccessMaskProtectExif = 9,
    ZFApiAccessMaskProtectExtraLarge = 10,
    ZFApiAccessMaskProtectLarge = 11,
    ZFApiAccessMaskProtectMedium = 12,
    ZFApiAccessMaskHideMetaData = 13,
    ZFApiAccessMaskProtectOriginals = 14,
    ZFApiAccessMaskHideUserStats = 15,
    ZFApiAccessMaskHideVisits = 16,
    ZFApiAccessMaskNoPublicGuestbookPosts = 17,
    ZFApiAccessMaskNoPrivateGuestbookPosts = 18,
    ZFApiAccessMaskNoAnonymousGuestbookPosts = 19,
    ZFApiAccessMaskNoPublicComments = 20,
    ZFApiAccessMaskNoPrivateComments = 21,
    ZFApiAccessMaskNoAnonymousComments = 22,
    ZFApiAccessMaskProtectGuestbook = 23,
    ZFApiAccessMaskProtectComments = 24,
    ZFApiAccessMaskPasswordProtectOriginals = 25,
    ZFApiAccessMaskProtectXXLarge = 26,
    ZFApiAccessMaskUnprotectCover = 27,
} ZFApiAccessMask;

#define kZFApiAccessMaskNoCollections @"NoCollections"
#define kZFApiAccessMaskNoAnonymousComments @"NoAnonymousComments"
#define kZFApiAccessMaskProtectGuestbook @"ProtectGuestbook"
#define kZFApiAccessMaskProtectOriginals @"ProtectOriginals"
#define kZFApiAccessMaskProtectLarge @"ProtectLarge"
#define kZFApiAccessMaskNoRecentList @"NoRecentList"
#define kZFApiAccessMaskNoAnonymousGuestbookPosts @"NoAnonymousGuestbookPosts"
#define kZFApiAccessMaskProtectAll @"ProtectAll"
#define kZFApiAccessMaskHideDateCreated @"HideDateCreated"
#define kZFApiAccessMaskNoPublicComments @"NoPublicComments"
#define kZFApiAccessMaskPasswordProtectOriginals @"PasswordProtectOriginals"
#define kZFApiAccessMaskProtectXXLarge @"ProtectXXLarge"
#define kZFApiAccessMaskHideDateModified @"HideDateModified"
#define kZFApiAccessMaskNoPublicSearch @"NoPublicSearch"
#define kZFApiAccessMaskNone @"None"
#define kZFApiAccessMaskProtectExtraLarge @"ProtectExtraLarge"
#define kZFApiAccessMaskProtectComments @"ProtectComments"
#define kZFApiAccessMaskNoPrivateSearch @"NoPrivateSearch"
#define kZFApiAccessMaskHideMetaData @"HideMetaData"
#define kZFApiAccessMaskProtectExif @"ProtectExif"
#define kZFApiAccessMaskProtectMedium @"ProtectMedium"
#define kZFApiAccessMaskHideVisits @"HideVisits"
#define kZFApiAccessMaskHideDateTaken @"HideDateTaken"
#define kZFApiAccessMaskNoPrivateGuestbookPosts @"NoPrivateGuestbookPosts"
#define kZFApiAccessMaskHideUserStats @"HideUserStats"
#define kZFApiAccessMaskNoPublicGuestbookPosts @"NoPublicGuestbookPosts"
#define kZFApiAccessMaskNoPrivateComments @"NoPrivateComments"
#define kZFApiAccessMaskUnprotectCover @"UnprotectCover"

extern NSString* ZFApiAccessMaskStringFromEnum(ZFApiAccessMask theEnum);
extern ZFApiAccessMask ZFApiAccessMaskEnumFromString(NSString* theString);

@interface ZFApiAccessMaskEnumSet : FLTypeSpecificEnumSet
+ (id) enumSet;
+ (id) enumSet:(NSString*) concatenatedEnumString;
@end
