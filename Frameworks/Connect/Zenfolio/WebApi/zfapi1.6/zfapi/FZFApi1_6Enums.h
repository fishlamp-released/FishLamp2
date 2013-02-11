//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApi1_6Enums.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#define FLZenfolioApiVersion1_6 1 
#define FLZenfolioApiVersion1_6 1 

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
	FLZenfolioAccessTypePrivate,
	FLZenfolioAccessTypeUserList,
	FLZenfolioAccessTypePassword,
	FLZenfolioAccessTypePublic,
} FLZenfolioAccessType;

typedef enum {
	FLZenfolioApiAccessMaskProtectAll,
	FLZenfolioApiAccessMaskNoCollections,
	FLZenfolioApiAccessMaskNone,
	FLZenfolioApiAccessMaskNoPrivateSearch,
	FLZenfolioApiAccessMaskNoPublicSearch,
	FLZenfolioApiAccessMaskNoRecentList,
	FLZenfolioApiAccessMaskHideDateCreated,
	FLZenfolioApiAccessMaskHideDateModified,
	FLZenfolioApiAccessMaskHideDateTaken,
	FLZenfolioApiAccessMaskProtectExif,
	FLZenfolioApiAccessMaskProtectExtraLarge,
	FLZenfolioApiAccessMaskProtectLarge,
	FLZenfolioApiAccessMaskProtectMedium,
	FLZenfolioApiAccessMaskHideMetaData,
	FLZenfolioApiAccessMaskProtectOriginals,
	FLZenfolioApiAccessMaskHideUserStats,
	FLZenfolioApiAccessMaskHideVisits,
	FLZenfolioApiAccessMaskNoPublicGuestbookPosts,
	FLZenfolioApiAccessMaskNoPrivateGuestbookPosts,
	FLZenfolioApiAccessMaskNoAnonymousGuestbookPosts,
	FLZenfolioApiAccessMaskNoPublicComments,
	FLZenfolioApiAccessMaskNoPrivateComments,
	FLZenfolioApiAccessMaskNoAnonymousComments,
	FLZenfolioApiAccessMaskProtectGuestbook,
	FLZenfolioApiAccessMaskProtectComments,
	FLZenfolioApiAccessMaskPasswordProtectOriginals,
	FLZenfolioApiAccessMaskProtectXXLarge,
	FLZenfolioApiAccessMaskUnprotectCover,
} FLZenfolioApiAccessMask;

typedef enum {
	FLZenfolioPhotoRotationNone,
	FLZenfolioPhotoRotationRotate90,
	FLZenfolioPhotoRotationRotate180,
	FLZenfolioPhotoRotationRotate270,
	FLZenfolioPhotoRotationFlip,
	FLZenfolioPhotoRotationRotate90Flip,
	FLZenfolioPhotoRotationRotate180Flip,
	FLZenfolioPhotoRotationRotate270Flip,
} FLZenfolioPhotoRotation;

typedef enum {
	FLZenfolioPhotoFlagsNone,
	FLZenfolioPhotoFlagsHasTitle,
	FLZenfolioPhotoFlagsHasCaption,
	FLZenfolioPhotoFlagsHasKeywords,
	FLZenfolioPhotoFlagsHasCategories,
	FLZenfolioPhotoFlagsHasExif,
	FLZenfolioPhotoFlagsHasComments,
} FLZenfolioPhotoFlags;

typedef enum {
	FLZenfolioPhotoSetTypeGallery,
	FLZenfolioPhotoSetTypeCollection,
} FLZenfolioPhotoSetType;

typedef enum {
	FLZenfolioInformatonLevelLevel1,
	FLZenfolioInformatonLevelLevel2,
	FLZenfolioInformatonLevelFull,
} FLZenfolioInformatonLevel;

typedef enum {
	FLZenfolioSortOrderDate,
	FLZenfolioSortOrderPopularity,
	FLZenfolioSortOrderRank,
} FLZenfolioSortOrder;

typedef enum {
	FLZenfolioShiftOrderCreatedAsc,
	FLZenfolioShiftOrderCreatedDesc,
	FLZenfolioShiftOrderTakenAsc,
	FLZenfolioShiftOrderTakenDesc,
	FLZenfolioShiftOrderTitleAsc,
	FLZenfolioShiftOrderTitleDesc,
	FLZenfolioShiftOrderSizeAsc,
	FLZenfolioShiftOrderSizeDesc,
	FLZenfolioShiftOrderFileNameAsc,
	FLZenfolioShiftOrderFileNameDesc,
} FLZenfolioShiftOrder;

typedef enum {
	FLZenfolioGroupShiftOrderCreatedAsc,
	FLZenfolioGroupShiftOrderCreatedDesc,
	FLZenfolioGroupShiftOrderModifiedAsc,
	FLZenfolioGroupShiftOrderModifiedDesc,
	FLZenfolioGroupShiftOrderTitleAsc,
	FLZenfolioGroupShiftOrderTitleDesc,
	FLZenfolioGroupShiftOrderGroupsTop,
	FLZenfolioGroupShiftOrderGroupsBottom,
} FLZenfolioGroupShiftOrder;

typedef enum {
	FLZenfolioVideoPlaybackModeiOS,
	FLZenfolioVideoPlaybackModeFlash,
	FLZenfolioVideoPlaybackModeHttp,
} FLZenfolioVideoPlaybackMode;


@interface FLZenfolioApi1_6EnumLookup : NSObject {
	NSDictionary* _strings;
}
FLSingletonProperty(FLZenfolioApi1_6EnumLookup);
- (NSString*) stringFromAccessType:(FLZenfolioAccessType) inEnum;
- (FLZenfolioAccessType) accessTypeFromString:(NSString*) inString;
- (NSString*) stringFromApiAccessMask:(FLZenfolioApiAccessMask) inEnum;
- (FLZenfolioApiAccessMask) apiAccessMaskFromString:(NSString*) inString;
- (NSString*) stringFromPhotoRotation:(FLZenfolioPhotoRotation) inEnum;
- (FLZenfolioPhotoRotation) photoRotationFromString:(NSString*) inString;
- (NSString*) stringFromPhotoFlags:(FLZenfolioPhotoFlags) inEnum;
- (FLZenfolioPhotoFlags) photoFlagsFromString:(NSString*) inString;
- (NSString*) stringFromPhotoSetType:(FLZenfolioPhotoSetType) inEnum;
- (FLZenfolioPhotoSetType) photoSetTypeFromString:(NSString*) inString;
- (NSString*) stringFromInformatonLevel:(FLZenfolioInformatonLevel) inEnum;
- (FLZenfolioInformatonLevel) informatonLevelFromString:(NSString*) inString;
- (NSString*) stringFromSortOrder:(FLZenfolioSortOrder) inEnum;
- (FLZenfolioSortOrder) sortOrderFromString:(NSString*) inString;
- (NSString*) stringFromShiftOrder:(FLZenfolioShiftOrder) inEnum;
- (FLZenfolioShiftOrder) shiftOrderFromString:(NSString*) inString;
- (NSString*) stringFromGroupShiftOrder:(FLZenfolioGroupShiftOrder) inEnum;
- (FLZenfolioGroupShiftOrder) groupShiftOrderFromString:(NSString*) inString;
- (NSString*) stringFromVideoPlaybackMode:(FLZenfolioVideoPlaybackMode) inEnum;
- (FLZenfolioVideoPlaybackMode) videoPlaybackModeFromString:(NSString*) inString;
@end
