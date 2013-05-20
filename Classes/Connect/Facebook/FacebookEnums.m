//	This file was generated at 7/1/11 1:52 PM by PackMule. DO NOT MODIFY!!
//
//	FacebookEnums.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FacebookEnums.h"
@implementation GtFacebookEnumLookup
GtSynthesizeSingleton(GtFacebookEnumLookup);
- (id) init {
	if((self = [super init])) {
		m_strings = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:GtFacebookUserReadPermissionAboutMe], kGtFacebookUserReadPermissionAboutMe, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionActivities], kGtFacebookUserReadPermissionActivities, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionBirthday], kGtFacebookUserReadPermissionBirthday, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionCheckins], kGtFacebookUserReadPermissionCheckins, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionEducationHistory], kGtFacebookUserReadPermissionEducationHistory, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionEvents], kGtFacebookUserReadPermissionEvents, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionGroups], kGtFacebookUserReadPermissionGroups, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionHometown], kGtFacebookUserReadPermissionHometown, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionInterests], kGtFacebookUserReadPermissionInterests, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionLikes], kGtFacebookUserReadPermissionLikes, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionLocation], kGtFacebookUserReadPermissionLocation, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionNotes], kGtFacebookUserReadPermissionNotes, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionOnlinePresence], kGtFacebookUserReadPermissionOnlinePresence, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionPhotoVideoTags], kGtFacebookUserReadPermissionPhotoVideoTags, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionPhotos], kGtFacebookUserReadPermissionPhotos, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionRelationships], kGtFacebookUserReadPermissionRelationships, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionRelationshipDetails], kGtFacebookUserReadPermissionRelationshipDetails, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionReligionPolitics], kGtFacebookUserReadPermissionReligionPolitics, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionStatus], kGtFacebookUserReadPermissionStatus, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionVideos], kGtFacebookUserReadPermissionVideos, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionWebsite], kGtFacebookUserReadPermissionWebsite, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionWorkHistory], kGtFacebookUserReadPermissionWorkHistory, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionEmail], kGtFacebookUserReadPermissionEmail, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionFriendLists], kGtFacebookUserReadPermissionFriendLists, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionInsights], kGtFacebookUserReadPermissionInsights, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionMailbox], kGtFacebookUserReadPermissionMailbox, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionRequests], kGtFacebookUserReadPermissionRequests, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionStream], kGtFacebookUserReadPermissionStream, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionXmppLogin], kGtFacebookUserReadPermissionXmppLogin, 
			[NSNumber numberWithInt:GtFacebookUserReadPermissionAdsManagement], kGtFacebookUserReadPermissionAdsManagement, 
			[NSNumber numberWithInt:GtFacebookUserWritePermissionPublishStream], kGtFacebookUserWritePermissionPublishStream, 
			[NSNumber numberWithInt:GtFacebookUserWritePermissionCreateEvent], kGtFacebookUserWritePermissionCreateEvent, 
			[NSNumber numberWithInt:GtFacebookUserWritePermissionRsvpEvent], kGtFacebookUserWritePermissionRsvpEvent, 
			[NSNumber numberWithInt:GtFacebookUserWritePermissionSms], kGtFacebookUserWritePermissionSms, 
			[NSNumber numberWithInt:GtFacebookUserWritePermissionOfflineAccess], kGtFacebookUserWritePermissionOfflineAccess, 
			[NSNumber numberWithInt:GtFacebookUserWritePermissionPublishCheckins], kGtFacebookUserWritePermissionPublishCheckins, 
			[NSNumber numberWithInt:GtFacebookUserWritePermissionManageFriedLists], kGtFacebookUserWritePermissionManageFriedLists, 
			[NSNumber numberWithInt:GtFacebookPictureSizeGtFacebookPictureSizeNormal], kGtFacebookPictureSizeGtFacebookPictureSizeNormal, 
			[NSNumber numberWithInt:GtFacebookPictureSizeGtFacebookPictureSizeLarge], kGtFacebookPictureSizeGtFacebookPictureSizeLarge, 
			[NSNumber numberWithInt:GtFacebookPictureSizeGtFacebookPictureSizeSquare], kGtFacebookPictureSizeGtFacebookPictureSizeSquare, 
			[NSNumber numberWithInt:GtFacebookPictureSizeGtFacebookPictureSizeSmall], kGtFacebookPictureSizeGtFacebookPictureSizeSmall, 
		 nil];
	}
	return self;
}

- (NSInteger) lookupString:(NSString*) inString {
	NSNumber* num = [m_strings objectForKey:inString];
	if(!num) { return NSNotFound; } 
	return [num intValue];
}

- (NSString*) stringFromFacebookUserReadPermission:(GtFacebookUserReadPermission) inEnum {
	switch(inEnum) {
		case GtFacebookUserReadPermissionAboutMe: return kGtFacebookUserReadPermissionAboutMe;
		case GtFacebookUserReadPermissionActivities: return kGtFacebookUserReadPermissionActivities;
		case GtFacebookUserReadPermissionBirthday: return kGtFacebookUserReadPermissionBirthday;
		case GtFacebookUserReadPermissionCheckins: return kGtFacebookUserReadPermissionCheckins;
		case GtFacebookUserReadPermissionEducationHistory: return kGtFacebookUserReadPermissionEducationHistory;
		case GtFacebookUserReadPermissionEvents: return kGtFacebookUserReadPermissionEvents;
		case GtFacebookUserReadPermissionGroups: return kGtFacebookUserReadPermissionGroups;
		case GtFacebookUserReadPermissionHometown: return kGtFacebookUserReadPermissionHometown;
		case GtFacebookUserReadPermissionInterests: return kGtFacebookUserReadPermissionInterests;
		case GtFacebookUserReadPermissionLikes: return kGtFacebookUserReadPermissionLikes;
		case GtFacebookUserReadPermissionLocation: return kGtFacebookUserReadPermissionLocation;
		case GtFacebookUserReadPermissionNotes: return kGtFacebookUserReadPermissionNotes;
		case GtFacebookUserReadPermissionOnlinePresence: return kGtFacebookUserReadPermissionOnlinePresence;
		case GtFacebookUserReadPermissionPhotoVideoTags: return kGtFacebookUserReadPermissionPhotoVideoTags;
		case GtFacebookUserReadPermissionPhotos: return kGtFacebookUserReadPermissionPhotos;
		case GtFacebookUserReadPermissionRelationships: return kGtFacebookUserReadPermissionRelationships;
		case GtFacebookUserReadPermissionRelationshipDetails: return kGtFacebookUserReadPermissionRelationshipDetails;
		case GtFacebookUserReadPermissionReligionPolitics: return kGtFacebookUserReadPermissionReligionPolitics;
		case GtFacebookUserReadPermissionStatus: return kGtFacebookUserReadPermissionStatus;
		case GtFacebookUserReadPermissionVideos: return kGtFacebookUserReadPermissionVideos;
		case GtFacebookUserReadPermissionWebsite: return kGtFacebookUserReadPermissionWebsite;
		case GtFacebookUserReadPermissionWorkHistory: return kGtFacebookUserReadPermissionWorkHistory;
		case GtFacebookUserReadPermissionEmail: return kGtFacebookUserReadPermissionEmail;
		case GtFacebookUserReadPermissionFriendLists: return kGtFacebookUserReadPermissionFriendLists;
		case GtFacebookUserReadPermissionInsights: return kGtFacebookUserReadPermissionInsights;
		case GtFacebookUserReadPermissionMailbox: return kGtFacebookUserReadPermissionMailbox;
		case GtFacebookUserReadPermissionRequests: return kGtFacebookUserReadPermissionRequests;
		case GtFacebookUserReadPermissionStream: return kGtFacebookUserReadPermissionStream;
		case GtFacebookUserReadPermissionXmppLogin: return kGtFacebookUserReadPermissionXmppLogin;
		case GtFacebookUserReadPermissionAdsManagement: return kGtFacebookUserReadPermissionAdsManagement;
	}
	return nil;
}

- (GtFacebookUserReadPermission) facebookUserReadPermissionFromString:(NSString*) inString {
	return (GtFacebookUserReadPermission) [self lookupString:inString];
}


- (NSString*) stringFromFacebookUserWritePermission:(GtFacebookUserWritePermission) inEnum {
	switch(inEnum) {
		case GtFacebookUserWritePermissionPublishStream: return kGtFacebookUserWritePermissionPublishStream;
		case GtFacebookUserWritePermissionCreateEvent: return kGtFacebookUserWritePermissionCreateEvent;
		case GtFacebookUserWritePermissionRsvpEvent: return kGtFacebookUserWritePermissionRsvpEvent;
		case GtFacebookUserWritePermissionSms: return kGtFacebookUserWritePermissionSms;
		case GtFacebookUserWritePermissionOfflineAccess: return kGtFacebookUserWritePermissionOfflineAccess;
		case GtFacebookUserWritePermissionPublishCheckins: return kGtFacebookUserWritePermissionPublishCheckins;
		case GtFacebookUserWritePermissionManageFriedLists: return kGtFacebookUserWritePermissionManageFriedLists;
	}
	return nil;
}

- (GtFacebookUserWritePermission) facebookUserWritePermissionFromString:(NSString*) inString {
	return (GtFacebookUserWritePermission) [self lookupString:inString];
}


- (NSString*) stringFromFacebookPictureSize:(GtFacebookPictureSize) inEnum {
	switch(inEnum) {
		case GtFacebookPictureSizeGtFacebookPictureSizeNormal: return kGtFacebookPictureSizeGtFacebookPictureSizeNormal;
		case GtFacebookPictureSizeGtFacebookPictureSizeLarge: return kGtFacebookPictureSizeGtFacebookPictureSizeLarge;
		case GtFacebookPictureSizeGtFacebookPictureSizeSquare: return kGtFacebookPictureSizeGtFacebookPictureSizeSquare;
		case GtFacebookPictureSizeGtFacebookPictureSizeSmall: return kGtFacebookPictureSizeGtFacebookPictureSizeSmall;
	}
	return nil;
}

- (GtFacebookPictureSize) facebookPictureSizeFromString:(NSString*) inString {
	return (GtFacebookPictureSize) [self lookupString:inString];
}

@end
