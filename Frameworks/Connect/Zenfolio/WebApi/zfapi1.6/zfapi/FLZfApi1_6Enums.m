//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApi1_6Enums.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfApi1_6Enums.h"
@implementation FLZfApi1_6EnumLookup
FLSynthesizeSingleton(FLZfApi1_6EnumLookup);
- (id) init {
	if((self = [super init])) {
		_strings = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:FLZfAccessTypePrivate], kZfAccessTypePrivate, 
			[NSNumber numberWithInt:FLZfAccessTypeUserList], kZfAccessTypeUserList, 
			[NSNumber numberWithInt:FLZfAccessTypePassword], kZfAccessTypePassword, 
			[NSNumber numberWithInt:FLZfAccessTypePublic], kZfAccessTypePublic, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectAll], kZfApiAccessMaskProtectAll, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoCollections], kZfApiAccessMaskNoCollections, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNone], kZfApiAccessMaskNone, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoPrivateSearch], kZfApiAccessMaskNoPrivateSearch, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoPublicSearch], kZfApiAccessMaskNoPublicSearch, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoRecentList], kZfApiAccessMaskNoRecentList, 
			[NSNumber numberWithInt:FLZfApiAccessMaskHideDateCreated], kZfApiAccessMaskHideDateCreated, 
			[NSNumber numberWithInt:FLZfApiAccessMaskHideDateModified], kZfApiAccessMaskHideDateModified, 
			[NSNumber numberWithInt:FLZfApiAccessMaskHideDateTaken], kZfApiAccessMaskHideDateTaken, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectExif], kZfApiAccessMaskProtectExif, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectExtraLarge], kZfApiAccessMaskProtectExtraLarge, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectLarge], kZfApiAccessMaskProtectLarge, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectMedium], kZfApiAccessMaskProtectMedium, 
			[NSNumber numberWithInt:FLZfApiAccessMaskHideMetaData], kZfApiAccessMaskHideMetaData, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectOriginals], kZfApiAccessMaskProtectOriginals, 
			[NSNumber numberWithInt:FLZfApiAccessMaskHideUserStats], kZfApiAccessMaskHideUserStats, 
			[NSNumber numberWithInt:FLZfApiAccessMaskHideVisits], kZfApiAccessMaskHideVisits, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoPublicGuestbookPosts], kZfApiAccessMaskNoPublicGuestbookPosts, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoPrivateGuestbookPosts], kZfApiAccessMaskNoPrivateGuestbookPosts, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoAnonymousGuestbookPosts], kZfApiAccessMaskNoAnonymousGuestbookPosts, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoPublicComments], kZfApiAccessMaskNoPublicComments, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoPrivateComments], kZfApiAccessMaskNoPrivateComments, 
			[NSNumber numberWithInt:FLZfApiAccessMaskNoAnonymousComments], kZfApiAccessMaskNoAnonymousComments, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectGuestbook], kZfApiAccessMaskProtectGuestbook, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectComments], kZfApiAccessMaskProtectComments, 
			[NSNumber numberWithInt:FLZfApiAccessMaskPasswordProtectOriginals], kZfApiAccessMaskPasswordProtectOriginals, 
			[NSNumber numberWithInt:FLZfApiAccessMaskProtectXXLarge], kZfApiAccessMaskProtectXXLarge, 
			[NSNumber numberWithInt:FLZfApiAccessMaskUnprotectCover], kZfApiAccessMaskUnprotectCover, 
			[NSNumber numberWithInt:FLZfPhotoRotationNone], kZfPhotoRotationNone, 
			[NSNumber numberWithInt:FLZfPhotoRotationRotate90], kZfPhotoRotationRotate90, 
			[NSNumber numberWithInt:FLZfPhotoRotationRotate180], kZfPhotoRotationRotate180, 
			[NSNumber numberWithInt:FLZfPhotoRotationRotate270], kZfPhotoRotationRotate270, 
			[NSNumber numberWithInt:FLZfPhotoRotationFlip], kZfPhotoRotationFlip, 
			[NSNumber numberWithInt:FLZfPhotoRotationRotate90Flip], kZfPhotoRotationRotate90Flip, 
			[NSNumber numberWithInt:FLZfPhotoRotationRotate180Flip], kZfPhotoRotationRotate180Flip, 
			[NSNumber numberWithInt:FLZfPhotoRotationRotate270Flip], kZfPhotoRotationRotate270Flip, 
			[NSNumber numberWithInt:FLZfPhotoFlagsNone], kZfPhotoFlagsNone, 
			[NSNumber numberWithInt:FLZfPhotoFlagsHasTitle], kZfPhotoFlagsHasTitle, 
			[NSNumber numberWithInt:FLZfPhotoFlagsHasCaption], kZfPhotoFlagsHasCaption, 
			[NSNumber numberWithInt:FLZfPhotoFlagsHasKeywords], kZfPhotoFlagsHasKeywords, 
			[NSNumber numberWithInt:FLZfPhotoFlagsHasCategories], kZfPhotoFlagsHasCategories, 
			[NSNumber numberWithInt:FLZfPhotoFlagsHasExif], kZfPhotoFlagsHasExif, 
			[NSNumber numberWithInt:FLZfPhotoFlagsHasComments], kZfPhotoFlagsHasComments, 
			[NSNumber numberWithInt:FLZfPhotoSetTypeGallery], kZfPhotoSetTypeGallery, 
			[NSNumber numberWithInt:FLZfPhotoSetTypeCollection], kZfPhotoSetTypeCollection, 
			[NSNumber numberWithInt:FLZfInformatonLevelLevel1], kZfInformatonLevelLevel1, 
			[NSNumber numberWithInt:FLZfInformatonLevelLevel2], kZfInformatonLevelLevel2, 
			[NSNumber numberWithInt:FLZfInformatonLevelFull], kZfInformatonLevelFull, 
			[NSNumber numberWithInt:FLZfSortOrderDate], kZfSortOrderDate, 
			[NSNumber numberWithInt:FLZfSortOrderPopularity], kZfSortOrderPopularity, 
			[NSNumber numberWithInt:FLZfSortOrderRank], kZfSortOrderRank, 
			[NSNumber numberWithInt:FLZfShiftOrderCreatedAsc], kZfShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:FLZfShiftOrderCreatedDesc], kZfShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:FLZfShiftOrderTakenAsc], kZfShiftOrderTakenAsc, 
			[NSNumber numberWithInt:FLZfShiftOrderTakenDesc], kZfShiftOrderTakenDesc, 
			[NSNumber numberWithInt:FLZfShiftOrderTitleAsc], kZfShiftOrderTitleAsc, 
			[NSNumber numberWithInt:FLZfShiftOrderTitleDesc], kZfShiftOrderTitleDesc, 
			[NSNumber numberWithInt:FLZfShiftOrderSizeAsc], kZfShiftOrderSizeAsc, 
			[NSNumber numberWithInt:FLZfShiftOrderSizeDesc], kZfShiftOrderSizeDesc, 
			[NSNumber numberWithInt:FLZfShiftOrderFileNameAsc], kZfShiftOrderFileNameAsc, 
			[NSNumber numberWithInt:FLZfShiftOrderFileNameDesc], kZfShiftOrderFileNameDesc, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderCreatedAsc], kZfGroupShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderCreatedDesc], kZfGroupShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderModifiedAsc], kZfGroupShiftOrderModifiedAsc, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderModifiedDesc], kZfGroupShiftOrderModifiedDesc, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderTitleAsc], kZfGroupShiftOrderTitleAsc, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderTitleDesc], kZfGroupShiftOrderTitleDesc, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderGroupsTop], kZfGroupShiftOrderGroupsTop, 
			[NSNumber numberWithInt:FLZfGroupShiftOrderGroupsBottom], kZfGroupShiftOrderGroupsBottom, 
			[NSNumber numberWithInt:FLZfVideoPlaybackModeiOS], kZfVideoPlaybackModeiOS, 
			[NSNumber numberWithInt:FLZfVideoPlaybackModeFlash], kZfVideoPlaybackModeFlash, 
			[NSNumber numberWithInt:FLZfVideoPlaybackModeHttp], kZfVideoPlaybackModeHttp, 
		 nil];
	}
	return self;
}

- (NSInteger) lookupString:(NSString*) inString {
	NSNumber* num = [_strings objectForKey:inString];
	if(!num) { return NSNotFound; } 
	return [num intValue];
}

- (NSString*) stringFromAccessType:(FLZfAccessType) inEnum {
	switch(inEnum) {
		case FLZfAccessTypePrivate: return kZfAccessTypePrivate;
		case FLZfAccessTypeUserList: return kZfAccessTypeUserList;
		case FLZfAccessTypePassword: return kZfAccessTypePassword;
		case FLZfAccessTypePublic: return kZfAccessTypePublic;
	}
	return nil;
}

- (FLZfAccessType) accessTypeFromString:(NSString*) inString {
	return (FLZfAccessType) [self lookupString:inString];
}


- (NSString*) stringFromApiAccessMask:(FLZfApiAccessMask) inEnum {
	switch(inEnum) {
		case FLZfApiAccessMaskProtectAll: return kZfApiAccessMaskProtectAll;
		case FLZfApiAccessMaskNoCollections: return kZfApiAccessMaskNoCollections;
		case FLZfApiAccessMaskNone: return kZfApiAccessMaskNone;
		case FLZfApiAccessMaskNoPrivateSearch: return kZfApiAccessMaskNoPrivateSearch;
		case FLZfApiAccessMaskNoPublicSearch: return kZfApiAccessMaskNoPublicSearch;
		case FLZfApiAccessMaskNoRecentList: return kZfApiAccessMaskNoRecentList;
		case FLZfApiAccessMaskHideDateCreated: return kZfApiAccessMaskHideDateCreated;
		case FLZfApiAccessMaskHideDateModified: return kZfApiAccessMaskHideDateModified;
		case FLZfApiAccessMaskHideDateTaken: return kZfApiAccessMaskHideDateTaken;
		case FLZfApiAccessMaskProtectExif: return kZfApiAccessMaskProtectExif;
		case FLZfApiAccessMaskProtectExtraLarge: return kZfApiAccessMaskProtectExtraLarge;
		case FLZfApiAccessMaskProtectLarge: return kZfApiAccessMaskProtectLarge;
		case FLZfApiAccessMaskProtectMedium: return kZfApiAccessMaskProtectMedium;
		case FLZfApiAccessMaskHideMetaData: return kZfApiAccessMaskHideMetaData;
		case FLZfApiAccessMaskProtectOriginals: return kZfApiAccessMaskProtectOriginals;
		case FLZfApiAccessMaskHideUserStats: return kZfApiAccessMaskHideUserStats;
		case FLZfApiAccessMaskHideVisits: return kZfApiAccessMaskHideVisits;
		case FLZfApiAccessMaskNoPublicGuestbookPosts: return kZfApiAccessMaskNoPublicGuestbookPosts;
		case FLZfApiAccessMaskNoPrivateGuestbookPosts: return kZfApiAccessMaskNoPrivateGuestbookPosts;
		case FLZfApiAccessMaskNoAnonymousGuestbookPosts: return kZfApiAccessMaskNoAnonymousGuestbookPosts;
		case FLZfApiAccessMaskNoPublicComments: return kZfApiAccessMaskNoPublicComments;
		case FLZfApiAccessMaskNoPrivateComments: return kZfApiAccessMaskNoPrivateComments;
		case FLZfApiAccessMaskNoAnonymousComments: return kZfApiAccessMaskNoAnonymousComments;
		case FLZfApiAccessMaskProtectGuestbook: return kZfApiAccessMaskProtectGuestbook;
		case FLZfApiAccessMaskProtectComments: return kZfApiAccessMaskProtectComments;
		case FLZfApiAccessMaskPasswordProtectOriginals: return kZfApiAccessMaskPasswordProtectOriginals;
		case FLZfApiAccessMaskProtectXXLarge: return kZfApiAccessMaskProtectXXLarge;
		case FLZfApiAccessMaskUnprotectCover: return kZfApiAccessMaskUnprotectCover;
	}
	return nil;
}

- (FLZfApiAccessMask) apiAccessMaskFromString:(NSString*) inString {
	return (FLZfApiAccessMask) [self lookupString:inString];
}


- (NSString*) stringFromPhotoRotation:(FLZfPhotoRotation) inEnum {
	switch(inEnum) {
		case FLZfPhotoRotationNone: return kZfPhotoRotationNone;
		case FLZfPhotoRotationRotate90: return kZfPhotoRotationRotate90;
		case FLZfPhotoRotationRotate180: return kZfPhotoRotationRotate180;
		case FLZfPhotoRotationRotate270: return kZfPhotoRotationRotate270;
		case FLZfPhotoRotationFlip: return kZfPhotoRotationFlip;
		case FLZfPhotoRotationRotate90Flip: return kZfPhotoRotationRotate90Flip;
		case FLZfPhotoRotationRotate180Flip: return kZfPhotoRotationRotate180Flip;
		case FLZfPhotoRotationRotate270Flip: return kZfPhotoRotationRotate270Flip;
	}
	return nil;
}

- (FLZfPhotoRotation) photoRotationFromString:(NSString*) inString {
	return (FLZfPhotoRotation) [self lookupString:inString];
}


- (NSString*) stringFromPhotoFlags:(FLZfPhotoFlags) inEnum {
	switch(inEnum) {
		case FLZfPhotoFlagsNone: return kZfPhotoFlagsNone;
		case FLZfPhotoFlagsHasTitle: return kZfPhotoFlagsHasTitle;
		case FLZfPhotoFlagsHasCaption: return kZfPhotoFlagsHasCaption;
		case FLZfPhotoFlagsHasKeywords: return kZfPhotoFlagsHasKeywords;
		case FLZfPhotoFlagsHasCategories: return kZfPhotoFlagsHasCategories;
		case FLZfPhotoFlagsHasExif: return kZfPhotoFlagsHasExif;
		case FLZfPhotoFlagsHasComments: return kZfPhotoFlagsHasComments;
	}
	return nil;
}

- (FLZfPhotoFlags) photoFlagsFromString:(NSString*) inString {
	return (FLZfPhotoFlags) [self lookupString:inString];
}


- (NSString*) stringFromPhotoSetType:(FLZfPhotoSetType) inEnum {
	switch(inEnum) {
		case FLZfPhotoSetTypeGallery: return kZfPhotoSetTypeGallery;
		case FLZfPhotoSetTypeCollection: return kZfPhotoSetTypeCollection;
	}
	return nil;
}

- (FLZfPhotoSetType) photoSetTypeFromString:(NSString*) inString {
	return (FLZfPhotoSetType) [self lookupString:inString];
}


- (NSString*) stringFromInformatonLevel:(FLZfInformatonLevel) inEnum {
	switch(inEnum) {
		case FLZfInformatonLevelLevel1: return kZfInformatonLevelLevel1;
		case FLZfInformatonLevelLevel2: return kZfInformatonLevelLevel2;
		case FLZfInformatonLevelFull: return kZfInformatonLevelFull;
	}
	return nil;
}

- (FLZfInformatonLevel) informatonLevelFromString:(NSString*) inString {
	return (FLZfInformatonLevel) [self lookupString:inString];
}


- (NSString*) stringFromSortOrder:(FLZfSortOrder) inEnum {
	switch(inEnum) {
		case FLZfSortOrderDate: return kZfSortOrderDate;
		case FLZfSortOrderPopularity: return kZfSortOrderPopularity;
		case FLZfSortOrderRank: return kZfSortOrderRank;
	}
	return nil;
}

- (FLZfSortOrder) sortOrderFromString:(NSString*) inString {
	return (FLZfSortOrder) [self lookupString:inString];
}


- (NSString*) stringFromShiftOrder:(FLZfShiftOrder) inEnum {
	switch(inEnum) {
		case FLZfShiftOrderCreatedAsc: return kZfShiftOrderCreatedAsc;
		case FLZfShiftOrderCreatedDesc: return kZfShiftOrderCreatedDesc;
		case FLZfShiftOrderTakenAsc: return kZfShiftOrderTakenAsc;
		case FLZfShiftOrderTakenDesc: return kZfShiftOrderTakenDesc;
		case FLZfShiftOrderTitleAsc: return kZfShiftOrderTitleAsc;
		case FLZfShiftOrderTitleDesc: return kZfShiftOrderTitleDesc;
		case FLZfShiftOrderSizeAsc: return kZfShiftOrderSizeAsc;
		case FLZfShiftOrderSizeDesc: return kZfShiftOrderSizeDesc;
		case FLZfShiftOrderFileNameAsc: return kZfShiftOrderFileNameAsc;
		case FLZfShiftOrderFileNameDesc: return kZfShiftOrderFileNameDesc;
	}
	return nil;
}

- (FLZfShiftOrder) shiftOrderFromString:(NSString*) inString {
	return (FLZfShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromGroupShiftOrder:(FLZfGroupShiftOrder) inEnum {
	switch(inEnum) {
		case FLZfGroupShiftOrderCreatedAsc: return kZfGroupShiftOrderCreatedAsc;
		case FLZfGroupShiftOrderCreatedDesc: return kZfGroupShiftOrderCreatedDesc;
		case FLZfGroupShiftOrderModifiedAsc: return kZfGroupShiftOrderModifiedAsc;
		case FLZfGroupShiftOrderModifiedDesc: return kZfGroupShiftOrderModifiedDesc;
		case FLZfGroupShiftOrderTitleAsc: return kZfGroupShiftOrderTitleAsc;
		case FLZfGroupShiftOrderTitleDesc: return kZfGroupShiftOrderTitleDesc;
		case FLZfGroupShiftOrderGroupsTop: return kZfGroupShiftOrderGroupsTop;
		case FLZfGroupShiftOrderGroupsBottom: return kZfGroupShiftOrderGroupsBottom;
	}
	return nil;
}

- (FLZfGroupShiftOrder) groupShiftOrderFromString:(NSString*) inString {
	return (FLZfGroupShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromVideoPlaybackMode:(FLZfVideoPlaybackMode) inEnum {
	switch(inEnum) {
		case FLZfVideoPlaybackModeiOS: return kZfVideoPlaybackModeiOS;
		case FLZfVideoPlaybackModeFlash: return kZfVideoPlaybackModeFlash;
		case FLZfVideoPlaybackModeHttp: return kZfVideoPlaybackModeHttp;
	}
	return nil;
}

- (FLZfVideoPlaybackMode) videoPlaybackModeFromString:(NSString*) inString {
	return (FLZfVideoPlaybackMode) [self lookupString:inString];
}

@end
