//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApi1_6Enums.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#define ZFApiVersion1_6 1 
#define ZFApiVersion1_6 1 

#define kZfAccessTypePrivate @"Private"
#define kZfAccessTypeUserList @"UserList"
#define kZfAccessTypePassword @"Password"
#define kZfAccessTypePublic @"Public"
#define kZfApiAccessMaskProtectAll @"ProtectAll"
#define kZfApiAccessMaskNoCollections @"NoCollections"
#define kZfApiAccessMaskNone @"None"
#define kZfApiAccessMaskNoPrivateSearch @"NoPrivateSearch"
#define kZfApiAccessMaskNoPublicSearch @"NoPublicSearch"
#define kZfApiAccessMaskNoRecentList @"NoRecentList"
#define kZfApiAccessMaskHideDateCreated @"HideDateCreated"
#define kZfApiAccessMaskHideDateModified @"HideDateModified"
#define kZfApiAccessMaskHideDateTaken @"HideDateTaken"
#define kZfApiAccessMaskProtectExif @"ProtectExif"
#define kZfApiAccessMaskProtectExtraLarge @"ProtectExtraLarge"
#define kZfApiAccessMaskProtectLarge @"ProtectLarge"
#define kZfApiAccessMaskProtectMedium @"ProtectMedium"
#define kZfApiAccessMaskHideMetaData @"HideMetaData"
#define kZfApiAccessMaskProtectOriginals @"ProtectOriginals"
#define kZfApiAccessMaskHideUserStats @"HideUserStats"
#define kZfApiAccessMaskHideVisits @"HideVisits"
#define kZfApiAccessMaskNoPublicGuestbookPosts @"NoPublicGuestbookPosts"
#define kZfApiAccessMaskNoPrivateGuestbookPosts @"NoPrivateGuestbookPosts"
#define kZfApiAccessMaskNoAnonymousGuestbookPosts @"NoAnonymousGuestbookPosts"
#define kZfApiAccessMaskNoPublicComments @"NoPublicComments"
#define kZfApiAccessMaskNoPrivateComments @"NoPrivateComments"
#define kZfApiAccessMaskNoAnonymousComments @"NoAnonymousComments"
#define kZfApiAccessMaskProtectGuestbook @"ProtectGuestbook"
#define kZfApiAccessMaskProtectComments @"ProtectComments"
#define kZfApiAccessMaskPasswordProtectOriginals @"PasswordProtectOriginals"
#define kZfApiAccessMaskProtectXXLarge @"ProtectXXLarge"
#define kZfApiAccessMaskUnprotectCover @"UnprotectCover"
#define kZfPhotoRotationNone @"None"
#define kZfPhotoRotationRotate90 @"Rotate90"
#define kZfPhotoRotationRotate180 @"Rotate180"
#define kZfPhotoRotationRotate270 @"Rotate270"
#define kZfPhotoRotationFlip @"Flip"
#define kZfPhotoRotationRotate90Flip @"Rotate90Flip"
#define kZfPhotoRotationRotate180Flip @"Rotate180Flip"
#define kZfPhotoRotationRotate270Flip @"Rotate270Flip"
#define kZfPhotoFlagsNone @"None"
#define kZfPhotoFlagsHasTitle @"HasTitle"
#define kZfPhotoFlagsHasCaption @"HasCaption"
#define kZfPhotoFlagsHasKeywords @"HasKeywords"
#define kZfPhotoFlagsHasCategories @"HasCategories"
#define kZfPhotoFlagsHasExif @"HasExif"
#define kZfPhotoFlagsHasComments @"HasComments"
#define kZfPhotoSetTypeGallery @"Gallery"
#define kZfPhotoSetTypeCollection @"Collection"
#define kZfInformatonLevelLevel1 @"Level1"
#define kZfInformatonLevelLevel2 @"Level2"
#define kZfInformatonLevelFull @"Full"
#define kZfSortOrderDate @"Date"
#define kZfSortOrderPopularity @"Popularity"
#define kZfSortOrderRank @"Rank"
#define kZfShiftOrderCreatedAsc @"CreatedAsc"
#define kZfShiftOrderCreatedDesc @"CreatedDesc"
#define kZfShiftOrderTakenAsc @"TakenAsc"
#define kZfShiftOrderTakenDesc @"TakenDesc"
#define kZfShiftOrderTitleAsc @"TitleAsc"
#define kZfShiftOrderTitleDesc @"TitleDesc"
#define kZfShiftOrderSizeAsc @"SizeAsc"
#define kZfShiftOrderSizeDesc @"SizeDesc"
#define kZfShiftOrderFileNameAsc @"FileNameAsc"
#define kZfShiftOrderFileNameDesc @"FileNameDesc"
#define kZfGroupShiftOrderCreatedAsc @"CreatedAsc"
#define kZfGroupShiftOrderCreatedDesc @"CreatedDesc"
#define kZfGroupShiftOrderModifiedAsc @"ModifiedAsc"
#define kZfGroupShiftOrderModifiedDesc @"ModifiedDesc"
#define kZfGroupShiftOrderTitleAsc @"TitleAsc"
#define kZfGroupShiftOrderTitleDesc @"TitleDesc"
#define kZfGroupShiftOrderGroupsTop @"GroupsTop"
#define kZfGroupShiftOrderGroupsBottom @"GroupsBottom"
#define kZfVideoPlaybackModeiOS @"iOS"
#define kZfVideoPlaybackModeFlash @"Flash"
#define kZfVideoPlaybackModeHttp @"Http"

typedef enum {
	ZFAccessTypePrivate,
	ZFAccessTypeUserList,
	ZFAccessTypePassword,
	ZFAccessTypePublic,
} ZFAccessType;

typedef enum {
	ZFApiAccessMaskProtectAll,
	ZFApiAccessMaskNoCollections,
	ZFApiAccessMaskNone,
	ZFApiAccessMaskNoPrivateSearch,
	ZFApiAccessMaskNoPublicSearch,
	ZFApiAccessMaskNoRecentList,
	ZFApiAccessMaskHideDateCreated,
	ZFApiAccessMaskHideDateModified,
	ZFApiAccessMaskHideDateTaken,
	ZFApiAccessMaskProtectExif,
	ZFApiAccessMaskProtectExtraLarge,
	ZFApiAccessMaskProtectLarge,
	ZFApiAccessMaskProtectMedium,
	ZFApiAccessMaskHideMetaData,
	ZFApiAccessMaskProtectOriginals,
	ZFApiAccessMaskHideUserStats,
	ZFApiAccessMaskHideVisits,
	ZFApiAccessMaskNoPublicGuestbookPosts,
	ZFApiAccessMaskNoPrivateGuestbookPosts,
	ZFApiAccessMaskNoAnonymousGuestbookPosts,
	ZFApiAccessMaskNoPublicComments,
	ZFApiAccessMaskNoPrivateComments,
	ZFApiAccessMaskNoAnonymousComments,
	ZFApiAccessMaskProtectGuestbook,
	ZFApiAccessMaskProtectComments,
	ZFApiAccessMaskPasswordProtectOriginals,
	ZFApiAccessMaskProtectXXLarge,
	ZFApiAccessMaskUnprotectCover,
} ZFApiAccessMask;

typedef enum {
	ZFPhotoRotationNone,
	ZFPhotoRotationRotate90,
	ZFPhotoRotationRotate180,
	ZFPhotoRotationRotate270,
	ZFPhotoRotationFlip,
	ZFPhotoRotationRotate90Flip,
	ZFPhotoRotationRotate180Flip,
	ZFPhotoRotationRotate270Flip,
} ZFPhotoRotation;

typedef enum {
	ZFPhotoFlagsNone,
	ZFPhotoFlagsHasTitle,
	ZFPhotoFlagsHasCaption,
	ZFPhotoFlagsHasKeywords,
	ZFPhotoFlagsHasCategories,
	ZFPhotoFlagsHasExif,
	ZFPhotoFlagsHasComments,
} ZFPhotoFlags;

typedef enum {
	ZFPhotoSetTypeGallery,
	ZFPhotoSetTypeCollection,
} ZFPhotoSetType;

typedef enum {
	ZFInformatonLevelLevel1,
	ZFInformatonLevelLevel2,
	ZFInformatonLevelFull,
} ZFInformatonLevel;

typedef enum {
	ZFSortOrderDate,
	ZFSortOrderPopularity,
	ZFSortOrderRank,
} ZFSortOrder;

typedef enum {
	ZFShiftOrderCreatedAsc,
	ZFShiftOrderCreatedDesc,
	ZFShiftOrderTakenAsc,
	ZFShiftOrderTakenDesc,
	ZFShiftOrderTitleAsc,
	ZFShiftOrderTitleDesc,
	ZFShiftOrderSizeAsc,
	ZFShiftOrderSizeDesc,
	ZFShiftOrderFileNameAsc,
	ZFShiftOrderFileNameDesc,
} ZFShiftOrder;

typedef enum {
	ZFGroupShiftOrderCreatedAsc,
	ZFGroupShiftOrderCreatedDesc,
	ZFGroupShiftOrderModifiedAsc,
	ZFGroupShiftOrderModifiedDesc,
	ZFGroupShiftOrderTitleAsc,
	ZFGroupShiftOrderTitleDesc,
	ZFGroupShiftOrderGroupsTop,
	ZFGroupShiftOrderGroupsBottom,
} ZFGroupShiftOrder;

typedef enum {
	ZFVideoPlaybackModeiOS,
	ZFVideoPlaybackModeFlash,
	ZFVideoPlaybackModeHttp,
} ZFVideoPlaybackMode;


@interface ZFApi1_6EnumLookup : NSObject {
	NSDictionary* _strings;
}
FLSingletonProperty(ZFApi1_6EnumLookup);
- (NSString*) stringFromAccessType:(ZFAccessType) inEnum;
- (ZFAccessType) accessTypeFromString:(NSString*) inString;
- (NSString*) stringFromApiAccessMask:(ZFApiAccessMask) inEnum;
- (ZFApiAccessMask) apiAccessMaskFromString:(NSString*) inString;
- (NSString*) stringFromPhotoRotation:(ZFPhotoRotation) inEnum;
- (ZFPhotoRotation) photoRotationFromString:(NSString*) inString;
- (NSString*) stringFromPhotoFlags:(ZFPhotoFlags) inEnum;
- (ZFPhotoFlags) photoFlagsFromString:(NSString*) inString;
- (NSString*) stringFromPhotoSetType:(ZFPhotoSetType) inEnum;
- (ZFPhotoSetType) photoSetTypeFromString:(NSString*) inString;
- (NSString*) stringFromInformatonLevel:(ZFInformatonLevel) inEnum;
- (ZFInformatonLevel) informatonLevelFromString:(NSString*) inString;
- (NSString*) stringFromSortOrder:(ZFSortOrder) inEnum;
- (ZFSortOrder) sortOrderFromString:(NSString*) inString;
- (NSString*) stringFromShiftOrder:(ZFShiftOrder) inEnum;
- (ZFShiftOrder) shiftOrderFromString:(NSString*) inString;
- (NSString*) stringFromGroupShiftOrder:(ZFGroupShiftOrder) inEnum;
- (ZFGroupShiftOrder) groupShiftOrderFromString:(NSString*) inString;
- (NSString*) stringFromVideoPlaybackMode:(ZFVideoPlaybackMode) inEnum;
- (ZFVideoPlaybackMode) videoPlaybackModeFromString:(NSString*) inString;
@end
