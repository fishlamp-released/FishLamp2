//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApi1_6Enums.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#define FLZfApiVersion1_6 1 
#define FLZfApiVersion1_6 1 

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
	FLZfAccessTypePrivate,
	FLZfAccessTypeUserList,
	FLZfAccessTypePassword,
	FLZfAccessTypePublic,
} FLZfAccessType;

typedef enum {
	FLZfApiAccessMaskProtectAll,
	FLZfApiAccessMaskNoCollections,
	FLZfApiAccessMaskNone,
	FLZfApiAccessMaskNoPrivateSearch,
	FLZfApiAccessMaskNoPublicSearch,
	FLZfApiAccessMaskNoRecentList,
	FLZfApiAccessMaskHideDateCreated,
	FLZfApiAccessMaskHideDateModified,
	FLZfApiAccessMaskHideDateTaken,
	FLZfApiAccessMaskProtectExif,
	FLZfApiAccessMaskProtectExtraLarge,
	FLZfApiAccessMaskProtectLarge,
	FLZfApiAccessMaskProtectMedium,
	FLZfApiAccessMaskHideMetaData,
	FLZfApiAccessMaskProtectOriginals,
	FLZfApiAccessMaskHideUserStats,
	FLZfApiAccessMaskHideVisits,
	FLZfApiAccessMaskNoPublicGuestbookPosts,
	FLZfApiAccessMaskNoPrivateGuestbookPosts,
	FLZfApiAccessMaskNoAnonymousGuestbookPosts,
	FLZfApiAccessMaskNoPublicComments,
	FLZfApiAccessMaskNoPrivateComments,
	FLZfApiAccessMaskNoAnonymousComments,
	FLZfApiAccessMaskProtectGuestbook,
	FLZfApiAccessMaskProtectComments,
	FLZfApiAccessMaskPasswordProtectOriginals,
	FLZfApiAccessMaskProtectXXLarge,
	FLZfApiAccessMaskUnprotectCover,
} FLZfApiAccessMask;

typedef enum {
	FLZfPhotoRotationNone,
	FLZfPhotoRotationRotate90,
	FLZfPhotoRotationRotate180,
	FLZfPhotoRotationRotate270,
	FLZfPhotoRotationFlip,
	FLZfPhotoRotationRotate90Flip,
	FLZfPhotoRotationRotate180Flip,
	FLZfPhotoRotationRotate270Flip,
} FLZfPhotoRotation;

typedef enum {
	FLZfPhotoFlagsNone,
	FLZfPhotoFlagsHasTitle,
	FLZfPhotoFlagsHasCaption,
	FLZfPhotoFlagsHasKeywords,
	FLZfPhotoFlagsHasCategories,
	FLZfPhotoFlagsHasExif,
	FLZfPhotoFlagsHasComments,
} FLZfPhotoFlags;

typedef enum {
	FLZfPhotoSetTypeGallery,
	FLZfPhotoSetTypeCollection,
} FLZfPhotoSetType;

typedef enum {
	FLZfInformatonLevelLevel1,
	FLZfInformatonLevelLevel2,
	FLZfInformatonLevelFull,
} FLZfInformatonLevel;

typedef enum {
	FLZfSortOrderDate,
	FLZfSortOrderPopularity,
	FLZfSortOrderRank,
} FLZfSortOrder;

typedef enum {
	FLZfShiftOrderCreatedAsc,
	FLZfShiftOrderCreatedDesc,
	FLZfShiftOrderTakenAsc,
	FLZfShiftOrderTakenDesc,
	FLZfShiftOrderTitleAsc,
	FLZfShiftOrderTitleDesc,
	FLZfShiftOrderSizeAsc,
	FLZfShiftOrderSizeDesc,
	FLZfShiftOrderFileNameAsc,
	FLZfShiftOrderFileNameDesc,
} FLZfShiftOrder;

typedef enum {
	FLZfGroupShiftOrderCreatedAsc,
	FLZfGroupShiftOrderCreatedDesc,
	FLZfGroupShiftOrderModifiedAsc,
	FLZfGroupShiftOrderModifiedDesc,
	FLZfGroupShiftOrderTitleAsc,
	FLZfGroupShiftOrderTitleDesc,
	FLZfGroupShiftOrderGroupsTop,
	FLZfGroupShiftOrderGroupsBottom,
} FLZfGroupShiftOrder;

typedef enum {
	FLZfVideoPlaybackModeiOS,
	FLZfVideoPlaybackModeFlash,
	FLZfVideoPlaybackModeHttp,
} FLZfVideoPlaybackMode;


@interface FLZfApi1_6EnumLookup : NSObject {
	NSDictionary* _strings;
}
FLSingletonProperty(FLZfApi1_6EnumLookup);
- (NSString*) stringFromAccessType:(FLZfAccessType) inEnum;
- (FLZfAccessType) accessTypeFromString:(NSString*) inString;
- (NSString*) stringFromApiAccessMask:(FLZfApiAccessMask) inEnum;
- (FLZfApiAccessMask) apiAccessMaskFromString:(NSString*) inString;
- (NSString*) stringFromPhotoRotation:(FLZfPhotoRotation) inEnum;
- (FLZfPhotoRotation) photoRotationFromString:(NSString*) inString;
- (NSString*) stringFromPhotoFlags:(FLZfPhotoFlags) inEnum;
- (FLZfPhotoFlags) photoFlagsFromString:(NSString*) inString;
- (NSString*) stringFromPhotoSetType:(FLZfPhotoSetType) inEnum;
- (FLZfPhotoSetType) photoSetTypeFromString:(NSString*) inString;
- (NSString*) stringFromInformatonLevel:(FLZfInformatonLevel) inEnum;
- (FLZfInformatonLevel) informatonLevelFromString:(NSString*) inString;
- (NSString*) stringFromSortOrder:(FLZfSortOrder) inEnum;
- (FLZfSortOrder) sortOrderFromString:(NSString*) inString;
- (NSString*) stringFromShiftOrder:(FLZfShiftOrder) inEnum;
- (FLZfShiftOrder) shiftOrderFromString:(NSString*) inString;
- (NSString*) stringFromGroupShiftOrder:(FLZfGroupShiftOrder) inEnum;
- (FLZfGroupShiftOrder) groupShiftOrderFromString:(NSString*) inString;
- (NSString*) stringFromVideoPlaybackMode:(FLZfVideoPlaybackMode) inEnum;
- (FLZfVideoPlaybackMode) videoPlaybackModeFromString:(NSString*) inString;
@end
