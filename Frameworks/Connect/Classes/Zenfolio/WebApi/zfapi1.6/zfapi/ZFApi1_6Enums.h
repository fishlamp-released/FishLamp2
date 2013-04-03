//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApi1_6Enums.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#define ZFApiVersion1_6 1 
#define ZFApiVersion1_6 1 

#define kZenfolioAccessTypePrivate @"Private"
#define kZenfolioAccessTypeUserList @"UserList"
#define kZenfolioAccessTypePassword @"Password"
#define kZenfolioAccessTypePublic @"Public"
#define kZenfolioApiAccessMaskProtectAll @"ProtectAll"
#define kZenfolioApiAccessMaskNoCollections @"NoCollections"
#define kZenfolioApiAccessMaskNone @"None"
#define kZenfolioApiAccessMaskNoPrivateSearch @"NoPrivateSearch"
#define kZenfolioApiAccessMaskNoPublicSearch @"NoPublicSearch"
#define kZenfolioApiAccessMaskNoRecentList @"NoRecentList"
#define kZenfolioApiAccessMaskHideDateCreated @"HideDateCreated"
#define kZenfolioApiAccessMaskHideDateModified @"HideDateModified"
#define kZenfolioApiAccessMaskHideDateTaken @"HideDateTaken"
#define kZenfolioApiAccessMaskProtectExif @"ProtectExif"
#define kZenfolioApiAccessMaskProtectExtraLarge @"ProtectExtraLarge"
#define kZenfolioApiAccessMaskProtectLarge @"ProtectLarge"
#define kZenfolioApiAccessMaskProtectMedium @"ProtectMedium"
#define kZenfolioApiAccessMaskHideMetaData @"HideMetaData"
#define kZenfolioApiAccessMaskProtectOriginals @"ProtectOriginals"
#define kZenfolioApiAccessMaskHideUserStats @"HideUserStats"
#define kZenfolioApiAccessMaskHideVisits @"HideVisits"
#define kZenfolioApiAccessMaskNoPublicGuestbookPosts @"NoPublicGuestbookPosts"
#define kZenfolioApiAccessMaskNoPrivateGuestbookPosts @"NoPrivateGuestbookPosts"
#define kZenfolioApiAccessMaskNoAnonymousGuestbookPosts @"NoAnonymousGuestbookPosts"
#define kZenfolioApiAccessMaskNoPublicComments @"NoPublicComments"
#define kZenfolioApiAccessMaskNoPrivateComments @"NoPrivateComments"
#define kZenfolioApiAccessMaskNoAnonymousComments @"NoAnonymousComments"
#define kZenfolioApiAccessMaskProtectGuestbook @"ProtectGuestbook"
#define kZenfolioApiAccessMaskProtectComments @"ProtectComments"
#define kZenfolioApiAccessMaskPasswordProtectOriginals @"PasswordProtectOriginals"
#define kZenfolioApiAccessMaskProtectXXLarge @"ProtectXXLarge"
#define kZenfolioApiAccessMaskUnprotectCover @"UnprotectCover"
#define kZenfolioPhotoRotationNone @"None"
#define kZenfolioPhotoRotationRotate90 @"Rotate90"
#define kZenfolioPhotoRotationRotate180 @"Rotate180"
#define kZenfolioPhotoRotationRotate270 @"Rotate270"
#define kZenfolioPhotoRotationFlip @"Flip"
#define kZenfolioPhotoRotationRotate90Flip @"Rotate90Flip"
#define kZenfolioPhotoRotationRotate180Flip @"Rotate180Flip"
#define kZenfolioPhotoRotationRotate270Flip @"Rotate270Flip"
#define kZenfolioPhotoFlagsNone @"None"
#define kZenfolioPhotoFlagsHasTitle @"HasTitle"
#define kZenfolioPhotoFlagsHasCaption @"HasCaption"
#define kZenfolioPhotoFlagsHasKeywords @"HasKeywords"
#define kZenfolioPhotoFlagsHasCategories @"HasCategories"
#define kZenfolioPhotoFlagsHasExif @"HasExif"
#define kZenfolioPhotoFlagsHasComments @"HasComments"
#define kZenfolioPhotoSetTypeGallery @"Gallery"
#define kZenfolioPhotoSetTypeCollection @"Collection"
#define kZenfolioInformatonLevelLevel1 @"Level1"
#define kZenfolioInformatonLevelLevel2 @"Level2"
#define kZenfolioInformatonLevelFull @"Full"
#define kZenfolioSortOrderDate @"Date"
#define kZenfolioSortOrderPopularity @"Popularity"
#define kZenfolioSortOrderRank @"Rank"
#define kZenfolioShiftOrderCreatedAsc @"CreatedAsc"
#define kZenfolioShiftOrderCreatedDesc @"CreatedDesc"
#define kZenfolioShiftOrderTakenAsc @"TakenAsc"
#define kZenfolioShiftOrderTakenDesc @"TakenDesc"
#define kZenfolioShiftOrderTitleAsc @"TitleAsc"
#define kZenfolioShiftOrderTitleDesc @"TitleDesc"
#define kZenfolioShiftOrderSizeAsc @"SizeAsc"
#define kZenfolioShiftOrderSizeDesc @"SizeDesc"
#define kZenfolioShiftOrderFileNameAsc @"FileNameAsc"
#define kZenfolioShiftOrderFileNameDesc @"FileNameDesc"
#define kZenfolioGroupShiftOrderCreatedAsc @"CreatedAsc"
#define kZenfolioGroupShiftOrderCreatedDesc @"CreatedDesc"
#define kZenfolioGroupShiftOrderModifiedAsc @"ModifiedAsc"
#define kZenfolioGroupShiftOrderModifiedDesc @"ModifiedDesc"
#define kZenfolioGroupShiftOrderTitleAsc @"TitleAsc"
#define kZenfolioGroupShiftOrderTitleDesc @"TitleDesc"
#define kZenfolioGroupShiftOrderGroupsTop @"GroupsTop"
#define kZenfolioGroupShiftOrderGroupsBottom @"GroupsBottom"
#define kZenfolioVideoPlaybackModeiOS @"iOS"
#define kZenfolioVideoPlaybackModeFlash @"Flash"
#define kZenfolioVideoPlaybackModeHttp @"Http"

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
