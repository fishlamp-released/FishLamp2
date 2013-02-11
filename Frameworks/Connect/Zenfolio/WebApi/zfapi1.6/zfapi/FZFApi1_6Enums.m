//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApi1_6Enums.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioApi1_6Enums.h"
@implementation FLZenfolioApi1_6EnumLookup
FLSynthesizeSingleton(FLZenfolioApi1_6EnumLookup);
- (id) init {
	if((self = [super init])) {
		_strings = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:FLZenfolioAccessTypePrivate], kZenfolioAccessTypePrivate, 
			[NSNumber numberWithInt:FLZenfolioAccessTypeUserList], kZenfolioAccessTypeUserList, 
			[NSNumber numberWithInt:FLZenfolioAccessTypePassword], kZenfolioAccessTypePassword, 
			[NSNumber numberWithInt:FLZenfolioAccessTypePublic], kZenfolioAccessTypePublic, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectAll], kZenfolioApiAccessMaskProtectAll, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoCollections], kZenfolioApiAccessMaskNoCollections, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNone], kZenfolioApiAccessMaskNone, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoPrivateSearch], kZenfolioApiAccessMaskNoPrivateSearch, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoPublicSearch], kZenfolioApiAccessMaskNoPublicSearch, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoRecentList], kZenfolioApiAccessMaskNoRecentList, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskHideDateCreated], kZenfolioApiAccessMaskHideDateCreated, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskHideDateModified], kZenfolioApiAccessMaskHideDateModified, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskHideDateTaken], kZenfolioApiAccessMaskHideDateTaken, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectExif], kZenfolioApiAccessMaskProtectExif, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectExtraLarge], kZenfolioApiAccessMaskProtectExtraLarge, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectLarge], kZenfolioApiAccessMaskProtectLarge, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectMedium], kZenfolioApiAccessMaskProtectMedium, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskHideMetaData], kZenfolioApiAccessMaskHideMetaData, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectOriginals], kZenfolioApiAccessMaskProtectOriginals, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskHideUserStats], kZenfolioApiAccessMaskHideUserStats, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskHideVisits], kZenfolioApiAccessMaskHideVisits, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoPublicGuestbookPosts], kZenfolioApiAccessMaskNoPublicGuestbookPosts, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoPrivateGuestbookPosts], kZenfolioApiAccessMaskNoPrivateGuestbookPosts, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoAnonymousGuestbookPosts], kZenfolioApiAccessMaskNoAnonymousGuestbookPosts, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoPublicComments], kZenfolioApiAccessMaskNoPublicComments, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoPrivateComments], kZenfolioApiAccessMaskNoPrivateComments, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskNoAnonymousComments], kZenfolioApiAccessMaskNoAnonymousComments, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectGuestbook], kZenfolioApiAccessMaskProtectGuestbook, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectComments], kZenfolioApiAccessMaskProtectComments, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskPasswordProtectOriginals], kZenfolioApiAccessMaskPasswordProtectOriginals, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskProtectXXLarge], kZenfolioApiAccessMaskProtectXXLarge, 
			[NSNumber numberWithInt:FLZenfolioApiAccessMaskUnprotectCover], kZenfolioApiAccessMaskUnprotectCover, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationNone], kZenfolioPhotoRotationNone, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationRotate90], kZenfolioPhotoRotationRotate90, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationRotate180], kZenfolioPhotoRotationRotate180, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationRotate270], kZenfolioPhotoRotationRotate270, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationFlip], kZenfolioPhotoRotationFlip, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationRotate90Flip], kZenfolioPhotoRotationRotate90Flip, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationRotate180Flip], kZenfolioPhotoRotationRotate180Flip, 
			[NSNumber numberWithInt:FLZenfolioPhotoRotationRotate270Flip], kZenfolioPhotoRotationRotate270Flip, 
			[NSNumber numberWithInt:FLZenfolioPhotoFlagsNone], kZenfolioPhotoFlagsNone, 
			[NSNumber numberWithInt:FLZenfolioPhotoFlagsHasTitle], kZenfolioPhotoFlagsHasTitle, 
			[NSNumber numberWithInt:FLZenfolioPhotoFlagsHasCaption], kZenfolioPhotoFlagsHasCaption, 
			[NSNumber numberWithInt:FLZenfolioPhotoFlagsHasKeywords], kZenfolioPhotoFlagsHasKeywords, 
			[NSNumber numberWithInt:FLZenfolioPhotoFlagsHasCategories], kZenfolioPhotoFlagsHasCategories, 
			[NSNumber numberWithInt:FLZenfolioPhotoFlagsHasExif], kZenfolioPhotoFlagsHasExif, 
			[NSNumber numberWithInt:FLZenfolioPhotoFlagsHasComments], kZenfolioPhotoFlagsHasComments, 
			[NSNumber numberWithInt:FLZenfolioPhotoSetTypeGallery], kZenfolioPhotoSetTypeGallery, 
			[NSNumber numberWithInt:FLZenfolioPhotoSetTypeCollection], kZenfolioPhotoSetTypeCollection, 
			[NSNumber numberWithInt:FLZenfolioInformatonLevelLevel1], kZenfolioInformatonLevelLevel1, 
			[NSNumber numberWithInt:FLZenfolioInformatonLevelLevel2], kZenfolioInformatonLevelLevel2, 
			[NSNumber numberWithInt:FLZenfolioInformatonLevelFull], kZenfolioInformatonLevelFull, 
			[NSNumber numberWithInt:FLZenfolioSortOrderDate], kZenfolioSortOrderDate, 
			[NSNumber numberWithInt:FLZenfolioSortOrderPopularity], kZenfolioSortOrderPopularity, 
			[NSNumber numberWithInt:FLZenfolioSortOrderRank], kZenfolioSortOrderRank, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderCreatedAsc], kZenfolioShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderCreatedDesc], kZenfolioShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderTakenAsc], kZenfolioShiftOrderTakenAsc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderTakenDesc], kZenfolioShiftOrderTakenDesc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderTitleAsc], kZenfolioShiftOrderTitleAsc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderTitleDesc], kZenfolioShiftOrderTitleDesc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderSizeAsc], kZenfolioShiftOrderSizeAsc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderSizeDesc], kZenfolioShiftOrderSizeDesc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderFileNameAsc], kZenfolioShiftOrderFileNameAsc, 
			[NSNumber numberWithInt:FLZenfolioShiftOrderFileNameDesc], kZenfolioShiftOrderFileNameDesc, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderCreatedAsc], kZenfolioGroupShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderCreatedDesc], kZenfolioGroupShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderModifiedAsc], kZenfolioGroupShiftOrderModifiedAsc, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderModifiedDesc], kZenfolioGroupShiftOrderModifiedDesc, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderTitleAsc], kZenfolioGroupShiftOrderTitleAsc, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderTitleDesc], kZenfolioGroupShiftOrderTitleDesc, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderGroupsTop], kZenfolioGroupShiftOrderGroupsTop, 
			[NSNumber numberWithInt:FLZenfolioGroupShiftOrderGroupsBottom], kZenfolioGroupShiftOrderGroupsBottom, 
			[NSNumber numberWithInt:FLZenfolioVideoPlaybackModeiOS], kZenfolioVideoPlaybackModeiOS, 
			[NSNumber numberWithInt:FLZenfolioVideoPlaybackModeFlash], kZenfolioVideoPlaybackModeFlash, 
			[NSNumber numberWithInt:FLZenfolioVideoPlaybackModeHttp], kZenfolioVideoPlaybackModeHttp, 
		 nil];
	}
	return self;
}

- (NSInteger) lookupString:(NSString*) inString {
	NSNumber* num = [_strings objectForKey:inString];
	if(!num) { return NSNotFound; } 
	return [num intValue];
}

- (NSString*) stringFromAccessType:(FLZenfolioAccessType) inEnum {
	switch(inEnum) {
		case FLZenfolioAccessTypePrivate: return kZenfolioAccessTypePrivate;
		case FLZenfolioAccessTypeUserList: return kZenfolioAccessTypeUserList;
		case FLZenfolioAccessTypePassword: return kZenfolioAccessTypePassword;
		case FLZenfolioAccessTypePublic: return kZenfolioAccessTypePublic;
	}
	return nil;
}

- (FLZenfolioAccessType) accessTypeFromString:(NSString*) inString {
	return (FLZenfolioAccessType) [self lookupString:inString];
}


- (NSString*) stringFromApiAccessMask:(FLZenfolioApiAccessMask) inEnum {
	switch(inEnum) {
		case FLZenfolioApiAccessMaskProtectAll: return kZenfolioApiAccessMaskProtectAll;
		case FLZenfolioApiAccessMaskNoCollections: return kZenfolioApiAccessMaskNoCollections;
		case FLZenfolioApiAccessMaskNone: return kZenfolioApiAccessMaskNone;
		case FLZenfolioApiAccessMaskNoPrivateSearch: return kZenfolioApiAccessMaskNoPrivateSearch;
		case FLZenfolioApiAccessMaskNoPublicSearch: return kZenfolioApiAccessMaskNoPublicSearch;
		case FLZenfolioApiAccessMaskNoRecentList: return kZenfolioApiAccessMaskNoRecentList;
		case FLZenfolioApiAccessMaskHideDateCreated: return kZenfolioApiAccessMaskHideDateCreated;
		case FLZenfolioApiAccessMaskHideDateModified: return kZenfolioApiAccessMaskHideDateModified;
		case FLZenfolioApiAccessMaskHideDateTaken: return kZenfolioApiAccessMaskHideDateTaken;
		case FLZenfolioApiAccessMaskProtectExif: return kZenfolioApiAccessMaskProtectExif;
		case FLZenfolioApiAccessMaskProtectExtraLarge: return kZenfolioApiAccessMaskProtectExtraLarge;
		case FLZenfolioApiAccessMaskProtectLarge: return kZenfolioApiAccessMaskProtectLarge;
		case FLZenfolioApiAccessMaskProtectMedium: return kZenfolioApiAccessMaskProtectMedium;
		case FLZenfolioApiAccessMaskHideMetaData: return kZenfolioApiAccessMaskHideMetaData;
		case FLZenfolioApiAccessMaskProtectOriginals: return kZenfolioApiAccessMaskProtectOriginals;
		case FLZenfolioApiAccessMaskHideUserStats: return kZenfolioApiAccessMaskHideUserStats;
		case FLZenfolioApiAccessMaskHideVisits: return kZenfolioApiAccessMaskHideVisits;
		case FLZenfolioApiAccessMaskNoPublicGuestbookPosts: return kZenfolioApiAccessMaskNoPublicGuestbookPosts;
		case FLZenfolioApiAccessMaskNoPrivateGuestbookPosts: return kZenfolioApiAccessMaskNoPrivateGuestbookPosts;
		case FLZenfolioApiAccessMaskNoAnonymousGuestbookPosts: return kZenfolioApiAccessMaskNoAnonymousGuestbookPosts;
		case FLZenfolioApiAccessMaskNoPublicComments: return kZenfolioApiAccessMaskNoPublicComments;
		case FLZenfolioApiAccessMaskNoPrivateComments: return kZenfolioApiAccessMaskNoPrivateComments;
		case FLZenfolioApiAccessMaskNoAnonymousComments: return kZenfolioApiAccessMaskNoAnonymousComments;
		case FLZenfolioApiAccessMaskProtectGuestbook: return kZenfolioApiAccessMaskProtectGuestbook;
		case FLZenfolioApiAccessMaskProtectComments: return kZenfolioApiAccessMaskProtectComments;
		case FLZenfolioApiAccessMaskPasswordProtectOriginals: return kZenfolioApiAccessMaskPasswordProtectOriginals;
		case FLZenfolioApiAccessMaskProtectXXLarge: return kZenfolioApiAccessMaskProtectXXLarge;
		case FLZenfolioApiAccessMaskUnprotectCover: return kZenfolioApiAccessMaskUnprotectCover;
	}
	return nil;
}

- (FLZenfolioApiAccessMask) apiAccessMaskFromString:(NSString*) inString {
	return (FLZenfolioApiAccessMask) [self lookupString:inString];
}


- (NSString*) stringFromPhotoRotation:(FLZenfolioPhotoRotation) inEnum {
	switch(inEnum) {
		case FLZenfolioPhotoRotationNone: return kZenfolioPhotoRotationNone;
		case FLZenfolioPhotoRotationRotate90: return kZenfolioPhotoRotationRotate90;
		case FLZenfolioPhotoRotationRotate180: return kZenfolioPhotoRotationRotate180;
		case FLZenfolioPhotoRotationRotate270: return kZenfolioPhotoRotationRotate270;
		case FLZenfolioPhotoRotationFlip: return kZenfolioPhotoRotationFlip;
		case FLZenfolioPhotoRotationRotate90Flip: return kZenfolioPhotoRotationRotate90Flip;
		case FLZenfolioPhotoRotationRotate180Flip: return kZenfolioPhotoRotationRotate180Flip;
		case FLZenfolioPhotoRotationRotate270Flip: return kZenfolioPhotoRotationRotate270Flip;
	}
	return nil;
}

- (FLZenfolioPhotoRotation) photoRotationFromString:(NSString*) inString {
	return (FLZenfolioPhotoRotation) [self lookupString:inString];
}


- (NSString*) stringFromPhotoFlags:(FLZenfolioPhotoFlags) inEnum {
	switch(inEnum) {
		case FLZenfolioPhotoFlagsNone: return kZenfolioPhotoFlagsNone;
		case FLZenfolioPhotoFlagsHasTitle: return kZenfolioPhotoFlagsHasTitle;
		case FLZenfolioPhotoFlagsHasCaption: return kZenfolioPhotoFlagsHasCaption;
		case FLZenfolioPhotoFlagsHasKeywords: return kZenfolioPhotoFlagsHasKeywords;
		case FLZenfolioPhotoFlagsHasCategories: return kZenfolioPhotoFlagsHasCategories;
		case FLZenfolioPhotoFlagsHasExif: return kZenfolioPhotoFlagsHasExif;
		case FLZenfolioPhotoFlagsHasComments: return kZenfolioPhotoFlagsHasComments;
	}
	return nil;
}

- (FLZenfolioPhotoFlags) photoFlagsFromString:(NSString*) inString {
	return (FLZenfolioPhotoFlags) [self lookupString:inString];
}


- (NSString*) stringFromPhotoSetType:(FLZenfolioPhotoSetType) inEnum {
	switch(inEnum) {
		case FLZenfolioPhotoSetTypeGallery: return kZenfolioPhotoSetTypeGallery;
		case FLZenfolioPhotoSetTypeCollection: return kZenfolioPhotoSetTypeCollection;
	}
	return nil;
}

- (FLZenfolioPhotoSetType) photoSetTypeFromString:(NSString*) inString {
	return (FLZenfolioPhotoSetType) [self lookupString:inString];
}


- (NSString*) stringFromInformatonLevel:(FLZenfolioInformatonLevel) inEnum {
	switch(inEnum) {
		case FLZenfolioInformatonLevelLevel1: return kZenfolioInformatonLevelLevel1;
		case FLZenfolioInformatonLevelLevel2: return kZenfolioInformatonLevelLevel2;
		case FLZenfolioInformatonLevelFull: return kZenfolioInformatonLevelFull;
	}
	return nil;
}

- (FLZenfolioInformatonLevel) informatonLevelFromString:(NSString*) inString {
	return (FLZenfolioInformatonLevel) [self lookupString:inString];
}


- (NSString*) stringFromSortOrder:(FLZenfolioSortOrder) inEnum {
	switch(inEnum) {
		case FLZenfolioSortOrderDate: return kZenfolioSortOrderDate;
		case FLZenfolioSortOrderPopularity: return kZenfolioSortOrderPopularity;
		case FLZenfolioSortOrderRank: return kZenfolioSortOrderRank;
	}
	return nil;
}

- (FLZenfolioSortOrder) sortOrderFromString:(NSString*) inString {
	return (FLZenfolioSortOrder) [self lookupString:inString];
}


- (NSString*) stringFromShiftOrder:(FLZenfolioShiftOrder) inEnum {
	switch(inEnum) {
		case FLZenfolioShiftOrderCreatedAsc: return kZenfolioShiftOrderCreatedAsc;
		case FLZenfolioShiftOrderCreatedDesc: return kZenfolioShiftOrderCreatedDesc;
		case FLZenfolioShiftOrderTakenAsc: return kZenfolioShiftOrderTakenAsc;
		case FLZenfolioShiftOrderTakenDesc: return kZenfolioShiftOrderTakenDesc;
		case FLZenfolioShiftOrderTitleAsc: return kZenfolioShiftOrderTitleAsc;
		case FLZenfolioShiftOrderTitleDesc: return kZenfolioShiftOrderTitleDesc;
		case FLZenfolioShiftOrderSizeAsc: return kZenfolioShiftOrderSizeAsc;
		case FLZenfolioShiftOrderSizeDesc: return kZenfolioShiftOrderSizeDesc;
		case FLZenfolioShiftOrderFileNameAsc: return kZenfolioShiftOrderFileNameAsc;
		case FLZenfolioShiftOrderFileNameDesc: return kZenfolioShiftOrderFileNameDesc;
	}
	return nil;
}

- (FLZenfolioShiftOrder) shiftOrderFromString:(NSString*) inString {
	return (FLZenfolioShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromGroupShiftOrder:(FLZenfolioGroupShiftOrder) inEnum {
	switch(inEnum) {
		case FLZenfolioGroupShiftOrderCreatedAsc: return kZenfolioGroupShiftOrderCreatedAsc;
		case FLZenfolioGroupShiftOrderCreatedDesc: return kZenfolioGroupShiftOrderCreatedDesc;
		case FLZenfolioGroupShiftOrderModifiedAsc: return kZenfolioGroupShiftOrderModifiedAsc;
		case FLZenfolioGroupShiftOrderModifiedDesc: return kZenfolioGroupShiftOrderModifiedDesc;
		case FLZenfolioGroupShiftOrderTitleAsc: return kZenfolioGroupShiftOrderTitleAsc;
		case FLZenfolioGroupShiftOrderTitleDesc: return kZenfolioGroupShiftOrderTitleDesc;
		case FLZenfolioGroupShiftOrderGroupsTop: return kZenfolioGroupShiftOrderGroupsTop;
		case FLZenfolioGroupShiftOrderGroupsBottom: return kZenfolioGroupShiftOrderGroupsBottom;
	}
	return nil;
}

- (FLZenfolioGroupShiftOrder) groupShiftOrderFromString:(NSString*) inString {
	return (FLZenfolioGroupShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromVideoPlaybackMode:(FLZenfolioVideoPlaybackMode) inEnum {
	switch(inEnum) {
		case FLZenfolioVideoPlaybackModeiOS: return kZenfolioVideoPlaybackModeiOS;
		case FLZenfolioVideoPlaybackModeFlash: return kZenfolioVideoPlaybackModeFlash;
		case FLZenfolioVideoPlaybackModeHttp: return kZenfolioVideoPlaybackModeHttp;
	}
	return nil;
}

- (FLZenfolioVideoPlaybackMode) videoPlaybackModeFromString:(NSString*) inString {
	return (FLZenfolioVideoPlaybackMode) [self lookupString:inString];
}

@end
