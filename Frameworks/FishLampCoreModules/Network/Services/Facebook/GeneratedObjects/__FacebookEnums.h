// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FacebookEnums.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#define kFLFacebookUserReadPermissionAboutMe @"user_about_me"
#define kFLFacebookUserReadPermissionActivities @"user_activities"
#define kFLFacebookUserReadPermissionBirthday @"user_birthday"
#define kFLFacebookUserReadPermissionCheckins @"user_checkins"
#define kFLFacebookUserReadPermissionEducationHistory @"user_education_history"
#define kFLFacebookUserReadPermissionEvents @"user_events"
#define kFLFacebookUserReadPermissionGroups @"user_groups"
#define kFLFacebookUserReadPermissionHometown @"user_hometown"
#define kFLFacebookUserReadPermissionInterests @"user_interests"
#define kFLFacebookUserReadPermissionLikes @"user_likes"
#define kFLFacebookUserReadPermissionLocation @"user_location"
#define kFLFacebookUserReadPermissionNotes @"user_notes"
#define kFLFacebookUserReadPermissionOnlinePresence @"user_online_presence"
#define kFLFacebookUserReadPermissionPhotoVideoTags @"user_photo_video_tags"
#define kFLFacebookUserReadPermissionPhotos @"user_photos"
#define kFLFacebookUserReadPermissionRelationships @"user_relationships"
#define kFLFacebookUserReadPermissionRelationshipDetails @"user_relationship_details"
#define kFLFacebookUserReadPermissionReligionPolitics @"user_religion_politics"
#define kFLFacebookUserReadPermissionStatus @"user_status"
#define kFLFacebookUserReadPermissionVideos @"user_videos"
#define kFLFacebookUserReadPermissionWebsite @"user_website"
#define kFLFacebookUserReadPermissionWorkHistory @"user_work_history"
#define kFLFacebookUserReadPermissionEmail @"email"
#define kFLFacebookUserReadPermissionFriendLists @"read_friendlists"
#define kFLFacebookUserReadPermissionInsights @"read_insights"
#define kFLFacebookUserReadPermissionMailbox @"read_mailbox"
#define kFLFacebookUserReadPermissionRequests @"read_requests"
#define kFLFacebookUserReadPermissionStream @"read_stream"
#define kFLFacebookUserReadPermissionXmppLogin @"xmpp_login"
#define kFLFacebookUserReadPermissionAdsManagement @"ads_management"
#define kFLFacebookUserWritePermissionPublishStream @"publish_stream"
#define kFLFacebookUserWritePermissionCreateEvent @"create_event"
#define kFLFacebookUserWritePermissionRsvpEvent @"rsvp_event"
#define kFLFacebookUserWritePermissionSms @"sms"
#define kFLFacebookUserWritePermissionOfflineAccess @"offline_access"
#define kFLFacebookUserWritePermissionPublishCheckins @"publish_checkins"
#define kFLFacebookUserWritePermissionManageFriedLists @"manage_friendlists"
#define kFLFacebookPictureSizeFLFacebookPictureSizeNormal @"normal"
#define kFLFacebookPictureSizeFLFacebookPictureSizeLarge @"large"
#define kFLFacebookPictureSizeFLFacebookPictureSizeSquare @"square"
#define kFLFacebookPictureSizeFLFacebookPictureSizeSmall @"small"

typedef enum {
    FLFacebookUserReadPermissionAboutMe,
    FLFacebookUserReadPermissionActivities,
    FLFacebookUserReadPermissionBirthday,
    FLFacebookUserReadPermissionCheckins,
    FLFacebookUserReadPermissionEducationHistory,
    FLFacebookUserReadPermissionEvents,
    FLFacebookUserReadPermissionGroups,
    FLFacebookUserReadPermissionHometown,
    FLFacebookUserReadPermissionInterests,
    FLFacebookUserReadPermissionLikes,
    FLFacebookUserReadPermissionLocation,
    FLFacebookUserReadPermissionNotes,
    FLFacebookUserReadPermissionOnlinePresence,
    FLFacebookUserReadPermissionPhotoVideoTags,
    FLFacebookUserReadPermissionPhotos,
    FLFacebookUserReadPermissionRelationships,
    FLFacebookUserReadPermissionRelationshipDetails,
    FLFacebookUserReadPermissionReligionPolitics,
    FLFacebookUserReadPermissionStatus,
    FLFacebookUserReadPermissionVideos,
    FLFacebookUserReadPermissionWebsite,
    FLFacebookUserReadPermissionWorkHistory,
    FLFacebookUserReadPermissionEmail,
    FLFacebookUserReadPermissionFriendLists,
    FLFacebookUserReadPermissionInsights,
    FLFacebookUserReadPermissionMailbox,
    FLFacebookUserReadPermissionRequests,
    FLFacebookUserReadPermissionStream,
    FLFacebookUserReadPermissionXmppLogin,
    FLFacebookUserReadPermissionAdsManagement,
} FLFacebookUserReadPermission;

typedef enum {
    FLFacebookUserWritePermissionPublishStream,
    FLFacebookUserWritePermissionCreateEvent,
    FLFacebookUserWritePermissionRsvpEvent,
    FLFacebookUserWritePermissionSms,
    FLFacebookUserWritePermissionOfflineAccess,
    FLFacebookUserWritePermissionPublishCheckins,
    FLFacebookUserWritePermissionManageFriedLists,
} FLFacebookUserWritePermission;

typedef enum {
    FLFacebookPictureSizeFLFacebookPictureSizeNormal,
    FLFacebookPictureSizeFLFacebookPictureSizeLarge,
    FLFacebookPictureSizeFLFacebookPictureSizeSquare,
    FLFacebookPictureSizeFLFacebookPictureSizeSmall,
} FLFacebookPictureSize;


@interface FLFacebookEnumLookup : NSObject {
	NSDictionary* _strings;
}
FLSingletonProperty(FLFacebookEnumLookup);

- (NSString*) stringFromFacebookUserReadPermission:(FLFacebookUserReadPermission) inEnum;
- (FLFacebookUserReadPermission) facebookUserReadPermissionFromString:(NSString*) inString;

- (NSString*) stringFromFacebookUserWritePermission:(FLFacebookUserWritePermission) inEnum;
- (FLFacebookUserWritePermission) facebookUserWritePermissionFromString:(NSString*) inString;

- (NSString*) stringFromFacebookPictureSize:(FLFacebookPictureSize) inEnum;
- (FLFacebookPictureSize) facebookPictureSizeFromString:(NSString*) inString;
@end
// [/Generated]
