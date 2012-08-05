// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FacebookEnums.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FacebookEnums.h"
@implementation FLFacebookEnumLookup
FLSynthesizeSingleton(FLFacebookEnumLookup);
- (id) init {
    if((self = [super init])) {
        _strings = [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithInt:FLFacebookUserReadPermissionAboutMe], kFLFacebookUserReadPermissionAboutMe, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionActivities], kFLFacebookUserReadPermissionActivities, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionBirthday], kFLFacebookUserReadPermissionBirthday, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionCheckins], kFLFacebookUserReadPermissionCheckins, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionEducationHistory], kFLFacebookUserReadPermissionEducationHistory, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionEvents], kFLFacebookUserReadPermissionEvents, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionGroups], kFLFacebookUserReadPermissionGroups, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionHometown], kFLFacebookUserReadPermissionHometown, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionInterests], kFLFacebookUserReadPermissionInterests, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionLikes], kFLFacebookUserReadPermissionLikes, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionLocation], kFLFacebookUserReadPermissionLocation, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionNotes], kFLFacebookUserReadPermissionNotes, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionOnlinePresence], kFLFacebookUserReadPermissionOnlinePresence, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionPhotoVideoTags], kFLFacebookUserReadPermissionPhotoVideoTags, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionPhotos], kFLFacebookUserReadPermissionPhotos, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionRelationships], kFLFacebookUserReadPermissionRelationships, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionRelationshipDetails], kFLFacebookUserReadPermissionRelationshipDetails, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionReligionPolitics], kFLFacebookUserReadPermissionReligionPolitics, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionStatus], kFLFacebookUserReadPermissionStatus, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionVideos], kFLFacebookUserReadPermissionVideos, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionWebsite], kFLFacebookUserReadPermissionWebsite, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionWorkHistory], kFLFacebookUserReadPermissionWorkHistory, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionEmail], kFLFacebookUserReadPermissionEmail, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionFriendLists], kFLFacebookUserReadPermissionFriendLists, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionInsights], kFLFacebookUserReadPermissionInsights, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionMailbox], kFLFacebookUserReadPermissionMailbox, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionRequests], kFLFacebookUserReadPermissionRequests, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionStream], kFLFacebookUserReadPermissionStream, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionXmppLogin], kFLFacebookUserReadPermissionXmppLogin, 
            [NSNumber numberWithInt:FLFacebookUserReadPermissionAdsManagement], kFLFacebookUserReadPermissionAdsManagement, 
            [NSNumber numberWithInt:FLFacebookUserWritePermissionPublishStream], kFLFacebookUserWritePermissionPublishStream, 
            [NSNumber numberWithInt:FLFacebookUserWritePermissionCreateEvent], kFLFacebookUserWritePermissionCreateEvent, 
            [NSNumber numberWithInt:FLFacebookUserWritePermissionRsvpEvent], kFLFacebookUserWritePermissionRsvpEvent, 
            [NSNumber numberWithInt:FLFacebookUserWritePermissionSms], kFLFacebookUserWritePermissionSms, 
            [NSNumber numberWithInt:FLFacebookUserWritePermissionOfflineAccess], kFLFacebookUserWritePermissionOfflineAccess, 
            [NSNumber numberWithInt:FLFacebookUserWritePermissionPublishCheckins], kFLFacebookUserWritePermissionPublishCheckins, 
            [NSNumber numberWithInt:FLFacebookUserWritePermissionManageFriedLists], kFLFacebookUserWritePermissionManageFriedLists, 
            [NSNumber numberWithInt:FLFacebookPictureSizeFLFacebookPictureSizeNormal], kFLFacebookPictureSizeFLFacebookPictureSizeNormal, 
            [NSNumber numberWithInt:FLFacebookPictureSizeFLFacebookPictureSizeLarge], kFLFacebookPictureSizeFLFacebookPictureSizeLarge, 
            [NSNumber numberWithInt:FLFacebookPictureSizeFLFacebookPictureSizeSquare], kFLFacebookPictureSizeFLFacebookPictureSizeSquare, 
            [NSNumber numberWithInt:FLFacebookPictureSizeFLFacebookPictureSizeSmall], kFLFacebookPictureSizeFLFacebookPictureSizeSmall, 
         nil];
    }
    return self;
}

- (NSInteger) lookupString:(NSString*) inString {
    NSNumber* num = [_strings objectForKey:inString];
    if(!num) { FLThrowErrorCode(FLErrorDomain, FLErrorUnknownEnumValue, [NSString stringWithFormat:(NSLocalizedString(@"Unknown enum value (case sensitive): %@", nil)), inString]); } 
    return [num intValue];
}

- (NSString*) stringFromFacebookUserReadPermission:(FLFacebookUserReadPermission) inEnum {
    switch(inEnum) {
        case FLFacebookUserReadPermissionAboutMe: return kFLFacebookUserReadPermissionAboutMe;
        case FLFacebookUserReadPermissionActivities: return kFLFacebookUserReadPermissionActivities;
        case FLFacebookUserReadPermissionBirthday: return kFLFacebookUserReadPermissionBirthday;
        case FLFacebookUserReadPermissionCheckins: return kFLFacebookUserReadPermissionCheckins;
        case FLFacebookUserReadPermissionEducationHistory: return kFLFacebookUserReadPermissionEducationHistory;
        case FLFacebookUserReadPermissionEvents: return kFLFacebookUserReadPermissionEvents;
        case FLFacebookUserReadPermissionGroups: return kFLFacebookUserReadPermissionGroups;
        case FLFacebookUserReadPermissionHometown: return kFLFacebookUserReadPermissionHometown;
        case FLFacebookUserReadPermissionInterests: return kFLFacebookUserReadPermissionInterests;
        case FLFacebookUserReadPermissionLikes: return kFLFacebookUserReadPermissionLikes;
        case FLFacebookUserReadPermissionLocation: return kFLFacebookUserReadPermissionLocation;
        case FLFacebookUserReadPermissionNotes: return kFLFacebookUserReadPermissionNotes;
        case FLFacebookUserReadPermissionOnlinePresence: return kFLFacebookUserReadPermissionOnlinePresence;
        case FLFacebookUserReadPermissionPhotoVideoTags: return kFLFacebookUserReadPermissionPhotoVideoTags;
        case FLFacebookUserReadPermissionPhotos: return kFLFacebookUserReadPermissionPhotos;
        case FLFacebookUserReadPermissionRelationships: return kFLFacebookUserReadPermissionRelationships;
        case FLFacebookUserReadPermissionRelationshipDetails: return kFLFacebookUserReadPermissionRelationshipDetails;
        case FLFacebookUserReadPermissionReligionPolitics: return kFLFacebookUserReadPermissionReligionPolitics;
        case FLFacebookUserReadPermissionStatus: return kFLFacebookUserReadPermissionStatus;
        case FLFacebookUserReadPermissionVideos: return kFLFacebookUserReadPermissionVideos;
        case FLFacebookUserReadPermissionWebsite: return kFLFacebookUserReadPermissionWebsite;
        case FLFacebookUserReadPermissionWorkHistory: return kFLFacebookUserReadPermissionWorkHistory;
        case FLFacebookUserReadPermissionEmail: return kFLFacebookUserReadPermissionEmail;
        case FLFacebookUserReadPermissionFriendLists: return kFLFacebookUserReadPermissionFriendLists;
        case FLFacebookUserReadPermissionInsights: return kFLFacebookUserReadPermissionInsights;
        case FLFacebookUserReadPermissionMailbox: return kFLFacebookUserReadPermissionMailbox;
        case FLFacebookUserReadPermissionRequests: return kFLFacebookUserReadPermissionRequests;
        case FLFacebookUserReadPermissionStream: return kFLFacebookUserReadPermissionStream;
        case FLFacebookUserReadPermissionXmppLogin: return kFLFacebookUserReadPermissionXmppLogin;
        case FLFacebookUserReadPermissionAdsManagement: return kFLFacebookUserReadPermissionAdsManagement;
    }
    return nil;
}

- (FLFacebookUserReadPermission) facebookUserReadPermissionFromString:(NSString*) inString {
    return (FLFacebookUserReadPermission) [self lookupString:inString];
}


- (NSString*) stringFromFacebookUserWritePermission:(FLFacebookUserWritePermission) inEnum {
    switch(inEnum) {
        case FLFacebookUserWritePermissionPublishStream: return kFLFacebookUserWritePermissionPublishStream;
        case FLFacebookUserWritePermissionCreateEvent: return kFLFacebookUserWritePermissionCreateEvent;
        case FLFacebookUserWritePermissionRsvpEvent: return kFLFacebookUserWritePermissionRsvpEvent;
        case FLFacebookUserWritePermissionSms: return kFLFacebookUserWritePermissionSms;
        case FLFacebookUserWritePermissionOfflineAccess: return kFLFacebookUserWritePermissionOfflineAccess;
        case FLFacebookUserWritePermissionPublishCheckins: return kFLFacebookUserWritePermissionPublishCheckins;
        case FLFacebookUserWritePermissionManageFriedLists: return kFLFacebookUserWritePermissionManageFriedLists;
    }
    return nil;
}

- (FLFacebookUserWritePermission) facebookUserWritePermissionFromString:(NSString*) inString {
    return (FLFacebookUserWritePermission) [self lookupString:inString];
}


- (NSString*) stringFromFacebookPictureSize:(FLFacebookPictureSize) inEnum {
    switch(inEnum) {
        case FLFacebookPictureSizeFLFacebookPictureSizeNormal: return kFLFacebookPictureSizeFLFacebookPictureSizeNormal;
        case FLFacebookPictureSizeFLFacebookPictureSizeLarge: return kFLFacebookPictureSizeFLFacebookPictureSizeLarge;
        case FLFacebookPictureSizeFLFacebookPictureSizeSquare: return kFLFacebookPictureSizeFLFacebookPictureSizeSquare;
        case FLFacebookPictureSizeFLFacebookPictureSizeSmall: return kFLFacebookPictureSizeFLFacebookPictureSizeSmall;
    }
    return nil;
}

- (FLFacebookPictureSize) facebookPictureSizeFromString:(NSString*) inString {
    return (FLFacebookPictureSize) [self lookupString:inString];
}

@end
// [/Generated]
