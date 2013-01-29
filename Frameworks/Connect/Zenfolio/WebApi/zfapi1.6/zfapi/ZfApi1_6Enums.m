//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApi1_6Enums.m
//	Project: myZenfolio WebAPI
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
			[NSNumber numberWithInt:ZFAccessTypePrivate], kZfAccessTypePrivate, 
			[NSNumber numberWithInt:ZFAccessTypeUserList], kZfAccessTypeUserList, 
			[NSNumber numberWithInt:ZFAccessTypePassword], kZfAccessTypePassword, 
			[NSNumber numberWithInt:ZFAccessTypePublic], kZfAccessTypePublic, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectAll], kZfApiAccessMaskProtectAll, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoCollections], kZfApiAccessMaskNoCollections, 
			[NSNumber numberWithInt:ZFApiAccessMaskNone], kZfApiAccessMaskNone, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPrivateSearch], kZfApiAccessMaskNoPrivateSearch, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPublicSearch], kZfApiAccessMaskNoPublicSearch, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoRecentList], kZfApiAccessMaskNoRecentList, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideDateCreated], kZfApiAccessMaskHideDateCreated, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideDateModified], kZfApiAccessMaskHideDateModified, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideDateTaken], kZfApiAccessMaskHideDateTaken, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectExif], kZfApiAccessMaskProtectExif, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectExtraLarge], kZfApiAccessMaskProtectExtraLarge, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectLarge], kZfApiAccessMaskProtectLarge, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectMedium], kZfApiAccessMaskProtectMedium, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideMetaData], kZfApiAccessMaskHideMetaData, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectOriginals], kZfApiAccessMaskProtectOriginals, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideUserStats], kZfApiAccessMaskHideUserStats, 
			[NSNumber numberWithInt:ZFApiAccessMaskHideVisits], kZfApiAccessMaskHideVisits, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPublicGuestbookPosts], kZfApiAccessMaskNoPublicGuestbookPosts, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPrivateGuestbookPosts], kZfApiAccessMaskNoPrivateGuestbookPosts, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoAnonymousGuestbookPosts], kZfApiAccessMaskNoAnonymousGuestbookPosts, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPublicComments], kZfApiAccessMaskNoPublicComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoPrivateComments], kZfApiAccessMaskNoPrivateComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskNoAnonymousComments], kZfApiAccessMaskNoAnonymousComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectGuestbook], kZfApiAccessMaskProtectGuestbook, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectComments], kZfApiAccessMaskProtectComments, 
			[NSNumber numberWithInt:ZFApiAccessMaskPasswordProtectOriginals], kZfApiAccessMaskPasswordProtectOriginals, 
			[NSNumber numberWithInt:ZFApiAccessMaskProtectXXLarge], kZfApiAccessMaskProtectXXLarge, 
			[NSNumber numberWithInt:ZFApiAccessMaskUnprotectCover], kZfApiAccessMaskUnprotectCover, 
			[NSNumber numberWithInt:ZFPhotoRotationNone], kZfPhotoRotationNone, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate90], kZfPhotoRotationRotate90, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate180], kZfPhotoRotationRotate180, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate270], kZfPhotoRotationRotate270, 
			[NSNumber numberWithInt:ZFPhotoRotationFlip], kZfPhotoRotationFlip, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate90Flip], kZfPhotoRotationRotate90Flip, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate180Flip], kZfPhotoRotationRotate180Flip, 
			[NSNumber numberWithInt:ZFPhotoRotationRotate270Flip], kZfPhotoRotationRotate270Flip, 
			[NSNumber numberWithInt:ZFPhotoFlagsNone], kZfPhotoFlagsNone, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasTitle], kZfPhotoFlagsHasTitle, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasCaption], kZfPhotoFlagsHasCaption, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasKeywords], kZfPhotoFlagsHasKeywords, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasCategories], kZfPhotoFlagsHasCategories, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasExif], kZfPhotoFlagsHasExif, 
			[NSNumber numberWithInt:ZFPhotoFlagsHasComments], kZfPhotoFlagsHasComments, 
			[NSNumber numberWithInt:ZFPhotoSetTypeGallery], kZfPhotoSetTypeGallery, 
			[NSNumber numberWithInt:ZFPhotoSetTypeCollection], kZfPhotoSetTypeCollection, 
			[NSNumber numberWithInt:ZFInformatonLevelLevel1], kZfInformatonLevelLevel1, 
			[NSNumber numberWithInt:ZFInformatonLevelLevel2], kZfInformatonLevelLevel2, 
			[NSNumber numberWithInt:ZFInformatonLevelFull], kZfInformatonLevelFull, 
			[NSNumber numberWithInt:ZFSortOrderDate], kZfSortOrderDate, 
			[NSNumber numberWithInt:ZFSortOrderPopularity], kZfSortOrderPopularity, 
			[NSNumber numberWithInt:ZFSortOrderRank], kZfSortOrderRank, 
			[NSNumber numberWithInt:ZFShiftOrderCreatedAsc], kZfShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:ZFShiftOrderCreatedDesc], kZfShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:ZFShiftOrderTakenAsc], kZfShiftOrderTakenAsc, 
			[NSNumber numberWithInt:ZFShiftOrderTakenDesc], kZfShiftOrderTakenDesc, 
			[NSNumber numberWithInt:ZFShiftOrderTitleAsc], kZfShiftOrderTitleAsc, 
			[NSNumber numberWithInt:ZFShiftOrderTitleDesc], kZfShiftOrderTitleDesc, 
			[NSNumber numberWithInt:ZFShiftOrderSizeAsc], kZfShiftOrderSizeAsc, 
			[NSNumber numberWithInt:ZFShiftOrderSizeDesc], kZfShiftOrderSizeDesc, 
			[NSNumber numberWithInt:ZFShiftOrderFileNameAsc], kZfShiftOrderFileNameAsc, 
			[NSNumber numberWithInt:ZFShiftOrderFileNameDesc], kZfShiftOrderFileNameDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderCreatedAsc], kZfGroupShiftOrderCreatedAsc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderCreatedDesc], kZfGroupShiftOrderCreatedDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderModifiedAsc], kZfGroupShiftOrderModifiedAsc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderModifiedDesc], kZfGroupShiftOrderModifiedDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderTitleAsc], kZfGroupShiftOrderTitleAsc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderTitleDesc], kZfGroupShiftOrderTitleDesc, 
			[NSNumber numberWithInt:ZFGroupShiftOrderGroupsTop], kZfGroupShiftOrderGroupsTop, 
			[NSNumber numberWithInt:ZFGroupShiftOrderGroupsBottom], kZfGroupShiftOrderGroupsBottom, 
			[NSNumber numberWithInt:ZFVideoPlaybackModeiOS], kZfVideoPlaybackModeiOS, 
			[NSNumber numberWithInt:ZFVideoPlaybackModeFlash], kZfVideoPlaybackModeFlash, 
			[NSNumber numberWithInt:ZFVideoPlaybackModeHttp], kZfVideoPlaybackModeHttp, 
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
		case ZFAccessTypePrivate: return kZfAccessTypePrivate;
		case ZFAccessTypeUserList: return kZfAccessTypeUserList;
		case ZFAccessTypePassword: return kZfAccessTypePassword;
		case ZFAccessTypePublic: return kZfAccessTypePublic;
	}
	return nil;
}

- (ZFAccessType) accessTypeFromString:(NSString*) inString {
	return (ZFAccessType) [self lookupString:inString];
}


- (NSString*) stringFromApiAccessMask:(ZFApiAccessMask) inEnum {
	switch(inEnum) {
		case ZFApiAccessMaskProtectAll: return kZfApiAccessMaskProtectAll;
		case ZFApiAccessMaskNoCollections: return kZfApiAccessMaskNoCollections;
		case ZFApiAccessMaskNone: return kZfApiAccessMaskNone;
		case ZFApiAccessMaskNoPrivateSearch: return kZfApiAccessMaskNoPrivateSearch;
		case ZFApiAccessMaskNoPublicSearch: return kZfApiAccessMaskNoPublicSearch;
		case ZFApiAccessMaskNoRecentList: return kZfApiAccessMaskNoRecentList;
		case ZFApiAccessMaskHideDateCreated: return kZfApiAccessMaskHideDateCreated;
		case ZFApiAccessMaskHideDateModified: return kZfApiAccessMaskHideDateModified;
		case ZFApiAccessMaskHideDateTaken: return kZfApiAccessMaskHideDateTaken;
		case ZFApiAccessMaskProtectExif: return kZfApiAccessMaskProtectExif;
		case ZFApiAccessMaskProtectExtraLarge: return kZfApiAccessMaskProtectExtraLarge;
		case ZFApiAccessMaskProtectLarge: return kZfApiAccessMaskProtectLarge;
		case ZFApiAccessMaskProtectMedium: return kZfApiAccessMaskProtectMedium;
		case ZFApiAccessMaskHideMetaData: return kZfApiAccessMaskHideMetaData;
		case ZFApiAccessMaskProtectOriginals: return kZfApiAccessMaskProtectOriginals;
		case ZFApiAccessMaskHideUserStats: return kZfApiAccessMaskHideUserStats;
		case ZFApiAccessMaskHideVisits: return kZfApiAccessMaskHideVisits;
		case ZFApiAccessMaskNoPublicGuestbookPosts: return kZfApiAccessMaskNoPublicGuestbookPosts;
		case ZFApiAccessMaskNoPrivateGuestbookPosts: return kZfApiAccessMaskNoPrivateGuestbookPosts;
		case ZFApiAccessMaskNoAnonymousGuestbookPosts: return kZfApiAccessMaskNoAnonymousGuestbookPosts;
		case ZFApiAccessMaskNoPublicComments: return kZfApiAccessMaskNoPublicComments;
		case ZFApiAccessMaskNoPrivateComments: return kZfApiAccessMaskNoPrivateComments;
		case ZFApiAccessMaskNoAnonymousComments: return kZfApiAccessMaskNoAnonymousComments;
		case ZFApiAccessMaskProtectGuestbook: return kZfApiAccessMaskProtectGuestbook;
		case ZFApiAccessMaskProtectComments: return kZfApiAccessMaskProtectComments;
		case ZFApiAccessMaskPasswordProtectOriginals: return kZfApiAccessMaskPasswordProtectOriginals;
		case ZFApiAccessMaskProtectXXLarge: return kZfApiAccessMaskProtectXXLarge;
		case ZFApiAccessMaskUnprotectCover: return kZfApiAccessMaskUnprotectCover;
	}
	return nil;
}

- (ZFApiAccessMask) apiAccessMaskFromString:(NSString*) inString {
	return (ZFApiAccessMask) [self lookupString:inString];
}


- (NSString*) stringFromPhotoRotation:(ZFPhotoRotation) inEnum {
	switch(inEnum) {
		case ZFPhotoRotationNone: return kZfPhotoRotationNone;
		case ZFPhotoRotationRotate90: return kZfPhotoRotationRotate90;
		case ZFPhotoRotationRotate180: return kZfPhotoRotationRotate180;
		case ZFPhotoRotationRotate270: return kZfPhotoRotationRotate270;
		case ZFPhotoRotationFlip: return kZfPhotoRotationFlip;
		case ZFPhotoRotationRotate90Flip: return kZfPhotoRotationRotate90Flip;
		case ZFPhotoRotationRotate180Flip: return kZfPhotoRotationRotate180Flip;
		case ZFPhotoRotationRotate270Flip: return kZfPhotoRotationRotate270Flip;
	}
	return nil;
}

- (ZFPhotoRotation) photoRotationFromString:(NSString*) inString {
	return (ZFPhotoRotation) [self lookupString:inString];
}


- (NSString*) stringFromPhotoFlags:(ZFPhotoFlags) inEnum {
	switch(inEnum) {
		case ZFPhotoFlagsNone: return kZfPhotoFlagsNone;
		case ZFPhotoFlagsHasTitle: return kZfPhotoFlagsHasTitle;
		case ZFPhotoFlagsHasCaption: return kZfPhotoFlagsHasCaption;
		case ZFPhotoFlagsHasKeywords: return kZfPhotoFlagsHasKeywords;
		case ZFPhotoFlagsHasCategories: return kZfPhotoFlagsHasCategories;
		case ZFPhotoFlagsHasExif: return kZfPhotoFlagsHasExif;
		case ZFPhotoFlagsHasComments: return kZfPhotoFlagsHasComments;
	}
	return nil;
}

- (ZFPhotoFlags) photoFlagsFromString:(NSString*) inString {
	return (ZFPhotoFlags) [self lookupString:inString];
}


- (NSString*) stringFromPhotoSetType:(ZFPhotoSetType) inEnum {
	switch(inEnum) {
		case ZFPhotoSetTypeGallery: return kZfPhotoSetTypeGallery;
		case ZFPhotoSetTypeCollection: return kZfPhotoSetTypeCollection;
	}
	return nil;
}

- (ZFPhotoSetType) photoSetTypeFromString:(NSString*) inString {
	return (ZFPhotoSetType) [self lookupString:inString];
}


- (NSString*) stringFromInformatonLevel:(ZFInformatonLevel) inEnum {
	switch(inEnum) {
		case ZFInformatonLevelLevel1: return kZfInformatonLevelLevel1;
		case ZFInformatonLevelLevel2: return kZfInformatonLevelLevel2;
		case ZFInformatonLevelFull: return kZfInformatonLevelFull;
	}
	return nil;
}

- (ZFInformatonLevel) informatonLevelFromString:(NSString*) inString {
	return (ZFInformatonLevel) [self lookupString:inString];
}


- (NSString*) stringFromSortOrder:(ZFSortOrder) inEnum {
	switch(inEnum) {
		case ZFSortOrderDate: return kZfSortOrderDate;
		case ZFSortOrderPopularity: return kZfSortOrderPopularity;
		case ZFSortOrderRank: return kZfSortOrderRank;
	}
	return nil;
}

- (ZFSortOrder) sortOrderFromString:(NSString*) inString {
	return (ZFSortOrder) [self lookupString:inString];
}


- (NSString*) stringFromShiftOrder:(ZFShiftOrder) inEnum {
	switch(inEnum) {
		case ZFShiftOrderCreatedAsc: return kZfShiftOrderCreatedAsc;
		case ZFShiftOrderCreatedDesc: return kZfShiftOrderCreatedDesc;
		case ZFShiftOrderTakenAsc: return kZfShiftOrderTakenAsc;
		case ZFShiftOrderTakenDesc: return kZfShiftOrderTakenDesc;
		case ZFShiftOrderTitleAsc: return kZfShiftOrderTitleAsc;
		case ZFShiftOrderTitleDesc: return kZfShiftOrderTitleDesc;
		case ZFShiftOrderSizeAsc: return kZfShiftOrderSizeAsc;
		case ZFShiftOrderSizeDesc: return kZfShiftOrderSizeDesc;
		case ZFShiftOrderFileNameAsc: return kZfShiftOrderFileNameAsc;
		case ZFShiftOrderFileNameDesc: return kZfShiftOrderFileNameDesc;
	}
	return nil;
}

- (ZFShiftOrder) shiftOrderFromString:(NSString*) inString {
	return (ZFShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromGroupShiftOrder:(ZFGroupShiftOrder) inEnum {
	switch(inEnum) {
		case ZFGroupShiftOrderCreatedAsc: return kZfGroupShiftOrderCreatedAsc;
		case ZFGroupShiftOrderCreatedDesc: return kZfGroupShiftOrderCreatedDesc;
		case ZFGroupShiftOrderModifiedAsc: return kZfGroupShiftOrderModifiedAsc;
		case ZFGroupShiftOrderModifiedDesc: return kZfGroupShiftOrderModifiedDesc;
		case ZFGroupShiftOrderTitleAsc: return kZfGroupShiftOrderTitleAsc;
		case ZFGroupShiftOrderTitleDesc: return kZfGroupShiftOrderTitleDesc;
		case ZFGroupShiftOrderGroupsTop: return kZfGroupShiftOrderGroupsTop;
		case ZFGroupShiftOrderGroupsBottom: return kZfGroupShiftOrderGroupsBottom;
	}
	return nil;
}

- (ZFGroupShiftOrder) groupShiftOrderFromString:(NSString*) inString {
	return (ZFGroupShiftOrder) [self lookupString:inString];
}


- (NSString*) stringFromVideoPlaybackMode:(ZFVideoPlaybackMode) inEnum {
	switch(inEnum) {
		case ZFVideoPlaybackModeiOS: return kZfVideoPlaybackModeiOS;
		case ZFVideoPlaybackModeFlash: return kZfVideoPlaybackModeFlash;
		case ZFVideoPlaybackModeHttp: return kZfVideoPlaybackModeHttp;
	}
	return nil;
}

- (ZFVideoPlaybackMode) videoPlaybackModeFromString:(NSString*) inString {
	return (ZFVideoPlaybackMode) [self lookupString:inString];
}

@end
