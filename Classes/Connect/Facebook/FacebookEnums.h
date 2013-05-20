//	This file was generated at 7/20/11 6:50 PM by PackMule. DO NOT MODIFY!!
//
//	FacebookEnums.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#define kGtFacebookUserReadPermissionAboutMe @"user_about_me"
#define kGtFacebookUserReadPermissionActivities @"user_activities"
#define kGtFacebookUserReadPermissionBirthday @"user_birthday"
#define kGtFacebookUserReadPermissionCheckins @"user_checkins"
#define kGtFacebookUserReadPermissionEducationHistory @"user_education_history"
#define kGtFacebookUserReadPermissionEvents @"user_events"
#define kGtFacebookUserReadPermissionGroups @"user_groups"
#define kGtFacebookUserReadPermissionHometown @"user_hometown"
#define kGtFacebookUserReadPermissionInterests @"user_interests"
#define kGtFacebookUserReadPermissionLikes @"user_likes"
#define kGtFacebookUserReadPermissionLocation @"user_location"
#define kGtFacebookUserReadPermissionNotes @"user_notes"
#define kGtFacebookUserReadPermissionOnlinePresence @"user_online_presence"
#define kGtFacebookUserReadPermissionPhotoVideoTags @"user_photo_video_tags"
#define kGtFacebookUserReadPermissionPhotos @"user_photos"
#define kGtFacebookUserReadPermissionRelationships @"user_relationships"
#define kGtFacebookUserReadPermissionRelationshipDetails @"user_relationship_details"
#define kGtFacebookUserReadPermissionReligionPolitics @"user_religion_politics"
#define kGtFacebookUserReadPermissionStatus @"user_status"
#define kGtFacebookUserReadPermissionVideos @"user_videos"
#define kGtFacebookUserReadPermissionWebsite @"user_website"
#define kGtFacebookUserReadPermissionWorkHistory @"user_work_history"
#define kGtFacebookUserReadPermissionEmail @"email"
#define kGtFacebookUserReadPermissionFriendLists @"read_friendlists"
#define kGtFacebookUserReadPermissionInsights @"read_insights"
#define kGtFacebookUserReadPermissionMailbox @"read_mailbox"
#define kGtFacebookUserReadPermissionRequests @"read_requests"
#define kGtFacebookUserReadPermissionStream @"read_stream"
#define kGtFacebookUserReadPermissionXmppLogin @"xmpp_login"
#define kGtFacebookUserReadPermissionAdsManagement @"ads_management"
#define kGtFacebookUserWritePermissionPublishStream @"publish_stream"
#define kGtFacebookUserWritePermissionCreateEvent @"create_event"
#define kGtFacebookUserWritePermissionRsvpEvent @"rsvp_event"
#define kGtFacebookUserWritePermissionSms @"sms"
#define kGtFacebookUserWritePermissionOfflineAccess @"offline_access"
#define kGtFacebookUserWritePermissionPublishCheckins @"publish_checkins"
#define kGtFacebookUserWritePermissionManageFriedLists @"manage_friendlists"
#define kGtFacebookPictureSizeGtFacebookPictureSizeNormal @"normal"
#define kGtFacebookPictureSizeGtFacebookPictureSizeLarge @"large"
#define kGtFacebookPictureSizeGtFacebookPictureSizeSquare @"square"
#define kGtFacebookPictureSizeGtFacebookPictureSizeSmall @"small"

typedef enum {
	GtFacebookUserReadPermissionAboutMe,
	GtFacebookUserReadPermissionActivities,
	GtFacebookUserReadPermissionBirthday,
	GtFacebookUserReadPermissionCheckins,
	GtFacebookUserReadPermissionEducationHistory,
	GtFacebookUserReadPermissionEvents,
	GtFacebookUserReadPermissionGroups,
	GtFacebookUserReadPermissionHometown,
	GtFacebookUserReadPermissionInterests,
	GtFacebookUserReadPermissionLikes,
	GtFacebookUserReadPermissionLocation,
	GtFacebookUserReadPermissionNotes,
	GtFacebookUserReadPermissionOnlinePresence,
	GtFacebookUserReadPermissionPhotoVideoTags,
	GtFacebookUserReadPermissionPhotos,
	GtFacebookUserReadPermissionRelationships,
	GtFacebookUserReadPermissionRelationshipDetails,
	GtFacebookUserReadPermissionReligionPolitics,
	GtFacebookUserReadPermissionStatus,
	GtFacebookUserReadPermissionVideos,
	GtFacebookUserReadPermissionWebsite,
	GtFacebookUserReadPermissionWorkHistory,
	GtFacebookUserReadPermissionEmail,
	GtFacebookUserReadPermissionFriendLists,
	GtFacebookUserReadPermissionInsights,
	GtFacebookUserReadPermissionMailbox,
	GtFacebookUserReadPermissionRequests,
	GtFacebookUserReadPermissionStream,
	GtFacebookUserReadPermissionXmppLogin,
	GtFacebookUserReadPermissionAdsManagement,
} GtFacebookUserReadPermission;

typedef enum {
	GtFacebookUserWritePermissionPublishStream,
	GtFacebookUserWritePermissionCreateEvent,
	GtFacebookUserWritePermissionRsvpEvent,
	GtFacebookUserWritePermissionSms,
	GtFacebookUserWritePermissionOfflineAccess,
	GtFacebookUserWritePermissionPublishCheckins,
	GtFacebookUserWritePermissionManageFriedLists,
} GtFacebookUserWritePermission;

typedef enum {
	GtFacebookPictureSizeGtFacebookPictureSizeNormal,
	GtFacebookPictureSizeGtFacebookPictureSizeLarge,
	GtFacebookPictureSizeGtFacebookPictureSizeSquare,
	GtFacebookPictureSizeGtFacebookPictureSizeSmall,
} GtFacebookPictureSize;


@interface GtFacebookEnumLookup : NSObject {
	NSDictionary* m_strings;
}
GtSingletonProperty(GtFacebookEnumLookup);
- (NSString*) stringFromFacebookUserReadPermission:(GtFacebookUserReadPermission) inEnum;
- (GtFacebookUserReadPermission) facebookUserReadPermissionFromString:(NSString*) inString;
- (NSString*) stringFromFacebookUserWritePermission:(GtFacebookUserWritePermission) inEnum;
- (GtFacebookUserWritePermission) facebookUserWritePermissionFromString:(NSString*) inString;
- (NSString*) stringFromFacebookPictureSize:(GtFacebookPictureSize) inEnum;
- (GtFacebookPictureSize) facebookPictureSizeFromString:(NSString*) inString;
@end
