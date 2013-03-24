//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApi1_6Enums.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApi1_6Enums.h"
@implementation ZFApi1_6EnumLookup
FLSynthesizeSingleton(ZFApi1_6EnumLookup);
- (id) init {
	if((self = [super init])) {
		_strings = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:ZFAccessTypePrivate], kZenfolioAccessTypePrivate, 
			[NSNumber numberWithInt:ZFAccessTypeUserList], kZenfolioAccessTypeUserList, 
			[NSNumber numberWithInt:ZFAccessTypePassword], kZenfolioAccessTypePassword, 
			[NSNumber numberWithInt:ZFAccessTypePublic], kZenfolioAccessTypePublic, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectAll], kZenfolioApiAccessMaskProtectAll, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoCollections], kZenfolioApiAccessMaskNoCollections, 
			[NSNumber numberWithInt:ZFApiAccessMaskNone], kZenfolioApiAccessMaskNone, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPrivateSearch], kZenfolioApiAccessMaskNoPrivateSearch, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPublicSearch], kZenfolioApiAccessMaskNoPublicSearch, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoRecentList], kZenfolioApiAccessMaskNoRecentList, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideDateCreated], kZenfolioApiAccessMaskHideDateCreated, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideDateModified], kZenfolioApiAccessMaskHideDateModified, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideDateTaken], kZenfolioApiAccessMaskHideDateTaken, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectExif], kZenfolioApiAccessMaskProtectExif, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectExtraLarge], kZenfolioApiAccessMaskProtectExtraLarge, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectLarge], kZenfolioApiAccessMaskProtectLarge, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectMedium], kZenfolioApiAccessMaskProtectMedium, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideMetaData], kZenfolioApiAccessMaskHideMetaData, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectOriginals], kZenfolioApiAccessMaskProtectOriginals, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideUserStats], kZenfolioApiAccessMaskHideUserStats, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideVisits], kZenfolioApiAccessMaskHideVisits, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPublicGuestbookPosts], kZenfolioApiAccessMaskNoPublicGuestbookPosts, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPrivateGuestbookPosts], kZenfolioApiAccessMaskNoPrivateGuestbookPosts, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoAnonymousGuestbookPosts], kZenfolioApiAccessMaskNoAnonymousGuestbookPosts, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPublicComments], kZenfolioApiAccessMaskNoPublicComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPrivateComments], kZenfolioApiAccessMaskNoPrivateComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoAnonymousComments], kZenfolioApiAccessMaskNoAnonymousComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectGuestbook], kZenfolioApiAccessMaskProtectGuestbook, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectComments], kZenfolioApiAccessMaskProtectComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskPasswordProtectOriginals], kZenfolioApiAccessMaskPasswordProtectOriginals, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectXXLarge], kZenfolioApiAccessMaskProtectXXLarge, 
			[NSNumber numberWithInt:ZFApiAccessMaskUnprotectCover], kZenfolioApiAccessMaskUnprotectCover, 
			[NSNumber numberWithInt:ZFPhotoRotationNone], kZenfolioPhotoRotationNone, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate90], kZenfolioPhotoRotationRotate90, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate180], kZenfolioPhotoRotationRotate180, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate270], kZenfolioPhotoRotationRotate270, 
			[NSNumber numberWithInt:ZFPhotoRotationFlip], kZenfolioPhotoRotationFlip, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate90Flip], kZenfolioPhotoRotationRotate90Flip, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate180Flip], kZenfolioPhotoRotationRotate180Flip, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate270Flip], kZenfolioPhotoRotationRotate270Flip, 
			[NSNumber numberWithInt:ZFPhotoFlagsNone], kZenfolioPhotoFlagsNone, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasTitle], kZenfolioPhotoFlagsHasTitle, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasCaption], kZenfolioPhotoFlagsHasCaption, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasKeywords], kZenfolioPhotoFlagsHasKeywords, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasCategories], kZenfolioPhotoFlagsHasCategories, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasExif], kZenfolioPhotoFlagsHasExif, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasComments], kZenfolioPhotoFlagsHasComments, 
			[NSNumber numberWithInt:ZFPhotoSetTypeGallery], kZenfolioPhotoSetTypeGallery, 
			[NSNumber numberWithInt:ZFPhotoSetTypeCollection], kZenfolioPhotoSetTypeCollection, 
			[NSNumber numberWithInt:ZFInformatonLevelLevel1], kZenfolioInformatonLevelLevel1, 
			[NSNumber numberWithInt:ZFInformatonLevelLevel2], kZenfolioInformatonLevelLevel2, 
			[NSNumber numberWithInt:ZFInformatonLevelFull], kZenfolioInformatonLevelFull, 
			[NSNumber numberWithInt:ZFSortOrderDate], kZenfolioSortOrderDate, 
			[NSNumber numberWithInt:ZFSortOrderPopularity], kZenfolioSortOrderPopularity, 
			[NSNumber numberWithInt:ZFSortOrderRank], kZenfolioSortOrderRank, 
			[NSNumber numberWithInt:ZFShiftOrderCreatedAsc], kZenfolioShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:ZFShiftOrderCreatedDesc], kZenfolioShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:ZFShiftOrderTakenAsc], kZenfolioShiftOrderTakenAsc, 
			[NSNumber numberWithInt:ZFShiftOrderTakenDesc], kZenfolioShiftOrderTakenDesc, 
			[NSNumber numberWithInt:ZFShiftOrderTitleAsc], kZenfolioShiftOrderTitleAsc, 
			[NSNumber numberWithInt:ZFShiftOrderTitleDesc], kZenfolioShiftOrderTitleDesc, 
			[NSNumber numberWithInt:ZFShiftOrderSizeAsc], kZenfolioShiftOrderSizeAsc, 
			[NSNumber numberWithInt:ZFShiftOrderSizeDesc], kZenfolioShiftOrderSizeDesc, 
			[NSNumber numberWithInt:ZFShiftOrderFileNameAsc], kZenfolioShiftOrderFileNameAsc, 
			[NSNumber numberWithInt:ZFShiftOrderFileNameDesc], kZenfolioShiftOrderFileNameDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderCreatedAsc], kZenfolioGroupShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderCreatedDesc], kZenfolioGroupShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderModifiedAsc], kZenfolioGroupShiftOrderModifiedAsc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderModifiedDesc], kZenfolioGroupShiftOrderModifiedDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderTitleAsc], kZenfolioGroupShiftOrderTitleAsc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderTitleDesc], kZenfolioGroupShiftOrderTitleDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderGroupsTop], kZenfolioGroupShiftOrderGroupsTop, 
			[NSNumber numberWithInt:ZFGroupShiftOrderGroupsBottom], kZenfolioGroupShiftOrderGroupsBottom, 
			[NSNumber numberWithInt:ZFVideoPlaybackModeiOS], kZenfolioVideoPlaybackModeiOS, 
			[NSNumber numberWithInt:ZFVideoPlaybackModeFlash], kZenfolioVideoPlaybackModeFlash, 
			[NSNumber numberWithInt:ZFVideoPlaybackModeHttp], kZenfolioVideoPlaybackModeHttp, 
		 nil];
	}
	return self;
}

- (NSInteger) lookupString:(NSString*) inString {
	NSNumber* num = [_strings objectForKey:inString];
	if(!num) { return NSNotFound; } 
	return [num intValue];
}

- (NSString*) stringFromAccessType:(ZFAccessType) inEnum {
	switch(inEnum) {
		case ZFAccessTypePrivate: return kZenfolioAccessTypePrivate;
		case ZFAccessTypeUserList: return kZenfolioAccessTypeUserList;
		case ZFAccessTypePassword: return kZenfolioAccessTypePassword;
		case ZFAccessTypePublic: return kZenfolioAccessTypePublic;
	}
	return nil;
}

- (ZFAccessType) accessTypeFromString:(NSString*) inString {
	return (ZFAccessType) [self lookupString:inString];
}


- (NSString*) stringFromApiAccessMask:(ZFApiAccessMask) inEnum {
	switch(inEnum) {
		case ZFApiAccessMaskProtectAll: return kZenfolioApiAccessMaskProtectAll;
		case ZFApiAccessMaskNoCollections: return kZenfolioApiAccessMaskNoCollections;
		case ZFApiAccessMaskNone: return kZenfolioApiAccessMaskNone;
		case ZFApiAccessMaskNoPrivateSearch: return kZenfolioApiAccessMaskNoPrivateSearch;
		case ZFApiAccessMaskNoPublicSearch: return kZenfolioApiAccessMaskNoPublicSearch;
		case ZFApiAccessMaskNoRecentList: return kZenfolioApiAccessMaskNoRecentList;
		case ZFApiAccessMaskHideDateCreated: return kZenfolioApiAccessMaskHideDateCreated;
		case ZFApiAccessMaskHideDateModified: return kZenfolioApiAccessMaskHideDateModified;
		case ZFApiAccessMaskHideDateTaken: return kZenfolioApiAccessMaskHideDateTaken;
		case ZFApiAccessMaskProtectExif: return kZenfolioApiAccessMaskProtectExif;
		case ZFApiAccessMaskProtectExtraLarge: return kZenfolioApiAccessMaskProtectExtraLarge;
		case ZFApiAccessMaskProtectLarge: return kZenfolioApiAccessMaskProtectLarge;
		case ZFApiAccessMaskProtectMedium: return kZenfolioApiAccessMaskProtectMedium;
		case ZFApiAccessMaskHideMetaData: return kZenfolioApiAccessMaskHideMetaData;
		case ZFApiAccessMaskProtectOriginals: return kZenfolioApiAccessMaskProtectOriginals;
		case ZFApiAccessMaskHideUserStats: return kZenfolioApiAccessMaskHideUserStats;
		case ZFApiAccessMaskHideVisits: return kZenfolioApiAccessMaskHideVisits;
		case ZFApiAccessMaskNoPublicGuestbookPosts: return kZenfolioApiAccessMaskNoPublicGuestbookPosts;
		case ZFApiAccessMaskNoPrivateGuestbookPosts: return kZenfolioApiAccessMaskNoPrivateGuestbookPosts;
		case ZFApiAccessMaskNoAnonymousGuestbookPosts: return kZenfolioApiAccessMaskNoAnonymousGuestbookPosts;
		case ZFApiAccessMaskNoPublicComments: return kZenfolioApiAccessMaskNoPublicComments;
		case ZFApiAccessMaskNoPrivateComments: return kZenfolioApiAccessMaskNoPrivateComments;
		case ZFApiAccessMaskNoAnonymousComments: return kZenfolioApiAccessMaskNoAnonymousComments;
		case ZFApiAccessMaskProtectGuestbook: return kZenfolioApiAccessMaskProtectGuestbook;
		case ZFApiAccessMaskProtectComments: return kZenfolioApiAccessMaskProtectComments;
		case ZFApiAccessMaskPasswordProtectOriginals: return kZenfolioApiAccessMaskPasswordProtectOriginals;
		case ZFApiAccessMaskProtectXXLarge: return kZenfolioApiAccessMaskProtectXXLarge;
		case ZFApiAccessMaskUnprotectCover: return kZenfolioApiAccessMaskUnprotectCover;
	}
	return nil;
}

- (ZFApiAccessMask) apiAccessMaskFromString:(NSString*) inString {
	return (ZFApiAccessMask) [self lookupString:inString];
}


- (NSString*) stringFromPhotoRotation:(ZFPhotoRotation) inEnum {
	switch(inEnum) {
		case ZFPhotoRotationNone: return kZenfolioPhotoRotationNone;
		case ZFPhotoRotationRotate90: return kZenfolioPhotoRotationRotate90;
		case ZFPhotoRotationRotate180: return kZenfolioPhotoRotationRotate180;
		case ZFPhotoRotationRotate270: return kZenfolioPhotoRotationRotate270;
		case ZFPhotoRotationFlip: return kZenfolioPhotoRotationFlip;
		case ZFPhotoRotationRotate90Flip: return kZenfolioPhotoRotationRotate90Flip;
		case ZFPhotoRotationRotate180Flip: return kZenfolioPhotoRotationRotate180Flip;
		case ZFPhotoRotationRotate270Flip: return kZenfolioPhotoRotationRotate270Flip;
	}
	return nil;
}

- (ZFPhotoRotation) photoRotationFromString:(NSString*) inString {
	return (ZFPhotoRotation) [self lookupString:inString];
}


- (NSString*) stringFromPhotoFlags:(ZFPhotoFlags) inEnum {
	switch(inEnum) {
		case ZFPhotoFlagsNone: return kZenfolioPhotoFlagsNone;
		case ZFPhotoFlagsHasTitle: return kZenfolioPhotoFlagsHasTitle;
		case ZFPhotoFlagsHasCaption: return kZenfolioPhotoFlagsHasCaption;
		case ZFPhotoFlagsHasKeywords: return kZenfolioPhotoFlagsHasKeywords;
		case ZFPhotoFlagsHasCategories: return kZenfolioPhotoFlagsHasCategories;
		case ZFPhotoFlagsHasExif: return kZenfolioPhotoFlagsHasExif;
		case ZFPhotoFlagsHasComments: return kZenfolioPhotoFlagsHasComments;
	}
	return nil;
}

- (ZFPhotoFlags) photoFlagsFromString:(NSString*) inString {
	return (ZFPhotoFlags) [self lookupString:inString];
}


- (NSString*) stringFromPhotoSetType:(ZFPhotoSetType) inEnum {
	switch(inEnum) {
		case ZFPhotoSetTypeGallery: return kZenfolioPhotoSetTypeGallery;
		case ZFPhotoSetTypeCollection: return kZenfolioPhotoSetTypeCollection;
	}
	return nil;
}

- (ZFPhotoSetType) photoSetTypeFromString:(NSString*) inString {
	return (ZFPhotoSetType) [self lookupString:inString];
}


- (NSString*) stringFromInformatonLevel:(ZFInformatonLevel) inEnum {
	switch(inEnum) {
		case ZFInformatonLevelLevel1: return kZenfolioInformatonLevelLevel1;
		case ZFInformatonLevelLevel2: return kZenfolioInformatonLevelLevel2;
		case ZFInformatonLevelFull: return kZenfolioInformatonLevelFull;
	}
	return nil;
}

- (ZFInformatonLevel) informatonLevelFromString:(NSString*) inString {
	return (ZFInformatonLevel) [self lookupString:inString];
}


- (NSString*) stringFromSortOrder:(ZFSortOrder) inEnum {
	switch(inEnum) {
		case ZFSortOrderDate: return kZenfolioSortOrderDate;
		case ZFSortOrderPopularity: return kZenfolioSortOrderPopularity;
		case ZFSortOrderRank: return kZenfolioSortOrderRank;
	}
	return nil;
}

- (ZFSortOrder) sortOrderFromString:(NSString*) inString {
	return (ZFSortOrder) [self lookupString:inString];
}


- (NSString*) stringFromShiftOrder:(ZFShiftOrder) inEnum {
	switch(inEnum) {
		case ZFShiftOrderCreatedAsc: return kZenfolioShiftOrderCreatedAsc;
		case ZFShiftOrderCreatedDesc: return kZenfolioShiftOrderCreatedDesc;
		case ZFShiftOrderTakenAsc: return kZenfolioShiftOrderTakenAsc;
		case ZFShiftOrderTakenDesc: return kZenfolioShiftOrderTakenDesc;
		case ZFShiftOrderTitleAsc: return kZenfolioShiftOrderTitleAsc;
		case ZFShiftOrderTitleDesc: return kZenfolioShiftOrderTitleDesc;
		case ZFShiftOrderSizeAsc: return kZenfolioShiftOrderSizeAsc;
		case ZFShiftOrderSizeDesc: return kZenfolioShiftOrderSizeDesc;
		case ZFShiftOrderFileNameAsc: return kZenfolioShiftOrderFileNameAsc;
		case ZFShiftOrderFileNameDesc: return kZenfolioShiftOrderFileNameDesc;
	}
	return nil;
}

- (ZFShiftOrder) shiftOrderFromString:(NSString*) inString {
	return (ZFShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromGroupShiftOrder:(ZFGroupShiftOrder) inEnum {
	switch(inEnum) {
		case ZFGroupShiftOrderCreatedAsc: return kZenfolioGroupShiftOrderCreatedAsc;
		case ZFGroupShiftOrderCreatedDesc: return kZenfolioGroupShiftOrderCreatedDesc;
		case ZFGroupShiftOrderModifiedAsc: return kZenfolioGroupShiftOrderModifiedAsc;
		case ZFGroupShiftOrderModifiedDesc: return kZenfolioGroupShiftOrderModifiedDesc;
		case ZFGroupShiftOrderTitleAsc: return kZenfolioGroupShiftOrderTitleAsc;
		case ZFGroupShiftOrderTitleDesc: return kZenfolioGroupShiftOrderTitleDesc;
		case ZFGroupShiftOrderGroupsTop: return kZenfolioGroupShiftOrderGroupsTop;
		case ZFGroupShiftOrderGroupsBottom: return kZenfolioGroupShiftOrderGroupsBottom;
	}
	return nil;
}

- (ZFGroupShiftOrder) groupShiftOrderFromString:(NSString*) inString {
	return (ZFGroupShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromVideoPlaybackMode:(ZFVideoPlaybackMode) inEnum {
	switch(inEnum) {
		case ZFVideoPlaybackModeiOS: return kZenfolioVideoPlaybackModeiOS;
		case ZFVideoPlaybackModeFlash: return kZenfolioVideoPlaybackModeFlash;
		case ZFVideoPlaybackModeHttp: return kZenfolioVideoPlaybackModeHttp;
	}
	return nil;
}

- (ZFVideoPlaybackMode) videoPlaybackModeFromString:(NSString*) inString {
	return (ZFVideoPlaybackMode) [self lookupString:inString];
}

@end
