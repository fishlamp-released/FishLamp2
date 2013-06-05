// 
// ZFApiHttpGet.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFApiHttpGet.h"
#import "ZFApiHttpGetRotatePhoto.h"
#import "ZFApiHttpGetGetVisitorKey.h"
#import "ZFApiHttpGetResolveReference.h"
#import "ZFApiHttpGetCollectionRemovePhoto.h"
#import "ZFApiHttpGetGetChallenge.h"
#import "ZFApiHttpGetMovePhoto.h"
#import "ZFApiHttpGetDeleteMessage.h"
#import "ZFApiHttpGetSetPhotoSetTitlePhoto.h"
#import "ZFApiHttpGetKeyringAddKeyPlain.h"
#import "ZFApiHttpGetDeletePhoto.h"
#import "ZFApiHttpGetUndeleteMessage.h"
#import "ZFApiHttpGetLoadAccessRealm.h"
#import "ZFApiHttpGetGetVideoPlaybackUrl.h"
#import "ZFApiHttpGetGetPopularSets.h"
#import "ZFApiHttpGetGetRecentPhotos.h"
#import "ZFApiHttpGetMovePhotoSet.h"
#import "ZFApiHttpGetRemoveGroupTitlePhoto.h"
#import "ZFApiHttpGetGetRecentSets.h"
#import "ZFApiHttpGetAuthenticate.h"
#import "ZFApiHttpGetLoadPhotoSet.h"
#import "ZFApiHttpGetSearchPhotoByCategory.h"
#import "ZFApiHttpGetCheckPrivilege.h"
#import "ZFApiHttpGetLoadPublicProfile.h"
#import "ZFApiHttpGetCreateFavoritesSet.h"
#import "ZFApiHttpGetLoadPhotoSetPhotos.h"
#import "ZFApiHttpGetSetPhotoSetFeaturedIndex.h"
#import "ZFApiHttpGetSearchSetByText.h"
#import "ZFApiHttpGetLoadSharedFavoritesSets.h"
#import "ZFApiHttpGetDeleteGroup.h"
#import "ZFApiHttpGetMoveGroup.h"
#import "ZFApiHttpGetReindexPhotoSet.h"
#import "ZFApiHttpGetCollectionAddPhoto.h"
#import "ZFApiHttpGetLoadPhoto.h"
#import "ZFApiHttpGetShareFavoritesSet.h"
#import "ZFApiHttpGetCreatePhotoFromUrl.h"
#import "ZFApiHttpGetSetGroupTitlePhoto.h"
#import "ZFApiHttpGetSearchSetByCategory.h"
#import "ZFApiHttpGetReorderPhotoSet.h"
#import "ZFApiHttpGetSetRandomPhotoSetTitlePhoto.h"
#import "ZFApiHttpGetAuthenticatePlain.h"
#import "ZFApiHttpGetMovePhotos.h"
#import "ZFApiHttpGetRemovePhotoSetTitlePhoto.h"
#import "ZFApiHttpGetLoadMessages.h"
#import "ZFApiHttpGetLoadGroup.h"
#import "ZFApiHttpGetDeletePhotoSet.h"
#import "ZFApiHttpGetGetDownloadOriginalKey.h"
#import "ZFApiHttpGetDeletePhotos.h"
#import "ZFApiHttpGetAuthenticateVisitor.h"
#import "ZFApiHttpGetKeyringGetUnlockedRealms.h"
#import "ZFApiHttpGetSearchPhotoByText.h"
#import "ZFApiHttpGetCreateVideoFromUrl.h"
#import "ZFApiHttpGetReorderGroup.h"
#import "ZFApiHttpGetGetVersion.h"
#import "ZFApiHttpGetGetCategories.h"
#import "ZFApiHttpGetLoadPrivateProfile.h"
#import "ZFApiHttpGetLoadGroupHierarchy.h"
#import "ZFApiHttpGetReplacePhoto.h"
#import "FLModelObject.h"
#import "ZFApiHttpGetGetPopularPhotos.h"

@implementation ZFApiHttpGet

+ (ZFApiHttpGet*) apiHttpGet {
    return FLAutorelease([[[self class] alloc] init]);
}
- (ZFApiHttpGetAuthenticate*) createAuthenticate {
    return FLAutorelease([[ZFApiHttpGetAuthenticate alloc] init]);
}
- (ZFApiHttpGetAuthenticatePlain*) createAuthenticatePlain {
    return FLAutorelease([[ZFApiHttpGetAuthenticatePlain alloc] init]);
}
- (ZFApiHttpGetAuthenticateVisitor*) createAuthenticateVisitor {
    return FLAutorelease([[ZFApiHttpGetAuthenticateVisitor alloc] init]);
}
- (ZFApiHttpGetCheckPrivilege*) createCheckPrivilege {
    return FLAutorelease([[ZFApiHttpGetCheckPrivilege alloc] init]);
}
- (ZFApiHttpGetCollectionAddPhoto*) createCollectionAddPhoto {
    return FLAutorelease([[ZFApiHttpGetCollectionAddPhoto alloc] init]);
}
- (ZFApiHttpGetCollectionRemovePhoto*) createCollectionRemovePhoto {
    return FLAutorelease([[ZFApiHttpGetCollectionRemovePhoto alloc] init]);
}
- (ZFApiHttpGetCreateFavoritesSet*) createCreateFavoritesSet {
    return FLAutorelease([[ZFApiHttpGetCreateFavoritesSet alloc] init]);
}
- (ZFApiHttpGetCreatePhotoFromUrl*) createCreatePhotoFromUrl {
    return FLAutorelease([[ZFApiHttpGetCreatePhotoFromUrl alloc] init]);
}
- (ZFApiHttpGetCreateVideoFromUrl*) createCreateVideoFromUrl {
    return FLAutorelease([[ZFApiHttpGetCreateVideoFromUrl alloc] init]);
}
- (ZFApiHttpGetDeleteGroup*) createDeleteGroup {
    return FLAutorelease([[ZFApiHttpGetDeleteGroup alloc] init]);
}
- (ZFApiHttpGetDeleteMessage*) createDeleteMessage {
    return FLAutorelease([[ZFApiHttpGetDeleteMessage alloc] init]);
}
- (ZFApiHttpGetDeletePhoto*) createDeletePhoto {
    return FLAutorelease([[ZFApiHttpGetDeletePhoto alloc] init]);
}
- (ZFApiHttpGetDeletePhotoSet*) createDeletePhotoSet {
    return FLAutorelease([[ZFApiHttpGetDeletePhotoSet alloc] init]);
}
- (ZFApiHttpGetDeletePhotos*) createDeletePhotos {
    return FLAutorelease([[ZFApiHttpGetDeletePhotos alloc] init]);
}
- (ZFApiHttpGetGetCategories*) createGetCategories {
    return FLAutorelease([[ZFApiHttpGetGetCategories alloc] init]);
}
- (ZFApiHttpGetGetChallenge*) createGetChallenge {
    return FLAutorelease([[ZFApiHttpGetGetChallenge alloc] init]);
}
- (ZFApiHttpGetGetDownloadOriginalKey*) createGetDownloadOriginalKey {
    return FLAutorelease([[ZFApiHttpGetGetDownloadOriginalKey alloc] init]);
}
- (ZFApiHttpGetGetPopularPhotos*) createGetPopularPhotos {
    return FLAutorelease([[ZFApiHttpGetGetPopularPhotos alloc] init]);
}
- (ZFApiHttpGetGetPopularSets*) createGetPopularSets {
    return FLAutorelease([[ZFApiHttpGetGetPopularSets alloc] init]);
}
- (ZFApiHttpGetGetRecentPhotos*) createGetRecentPhotos {
    return FLAutorelease([[ZFApiHttpGetGetRecentPhotos alloc] init]);
}
- (ZFApiHttpGetGetRecentSets*) createGetRecentSets {
    return FLAutorelease([[ZFApiHttpGetGetRecentSets alloc] init]);
}
- (ZFApiHttpGetGetVersion*) createGetVersion {
    return FLAutorelease([[ZFApiHttpGetGetVersion alloc] init]);
}
- (ZFApiHttpGetGetVideoPlaybackUrl*) createGetVideoPlaybackUrl {
    return FLAutorelease([[ZFApiHttpGetGetVideoPlaybackUrl alloc] init]);
}
- (ZFApiHttpGetGetVisitorKey*) createGetVisitorKey {
    return FLAutorelease([[ZFApiHttpGetGetVisitorKey alloc] init]);
}
- (ZFApiHttpGetKeyringAddKeyPlain*) createKeyringAddKeyPlain {
    return FLAutorelease([[ZFApiHttpGetKeyringAddKeyPlain alloc] init]);
}
- (ZFApiHttpGetKeyringGetUnlockedRealms*) createKeyringGetUnlockedRealms {
    return FLAutorelease([[ZFApiHttpGetKeyringGetUnlockedRealms alloc] init]);
}
- (ZFApiHttpGetLoadAccessRealm*) createLoadAccessRealm {
    return FLAutorelease([[ZFApiHttpGetLoadAccessRealm alloc] init]);
}
- (ZFApiHttpGetLoadGroup*) createLoadGroup {
    return FLAutorelease([[ZFApiHttpGetLoadGroup alloc] init]);
}
- (ZFApiHttpGetLoadGroupHierarchy*) createLoadGroupHierarchy {
    return FLAutorelease([[ZFApiHttpGetLoadGroupHierarchy alloc] init]);
}
- (ZFApiHttpGetLoadMessages*) createLoadMessages {
    return FLAutorelease([[ZFApiHttpGetLoadMessages alloc] init]);
}
- (ZFApiHttpGetLoadPhoto*) createLoadPhoto {
    return FLAutorelease([[ZFApiHttpGetLoadPhoto alloc] init]);
}
- (ZFApiHttpGetLoadPhotoSet*) createLoadPhotoSet {
    return FLAutorelease([[ZFApiHttpGetLoadPhotoSet alloc] init]);
}
- (ZFApiHttpGetLoadPhotoSetPhotos*) createLoadPhotoSetPhotos {
    return FLAutorelease([[ZFApiHttpGetLoadPhotoSetPhotos alloc] init]);
}
- (ZFApiHttpGetLoadPrivateProfile*) createLoadPrivateProfile {
    return FLAutorelease([[ZFApiHttpGetLoadPrivateProfile alloc] init]);
}
- (ZFApiHttpGetLoadPublicProfile*) createLoadPublicProfile {
    return FLAutorelease([[ZFApiHttpGetLoadPublicProfile alloc] init]);
}
- (ZFApiHttpGetLoadSharedFavoritesSets*) createLoadSharedFavoritesSets {
    return FLAutorelease([[ZFApiHttpGetLoadSharedFavoritesSets alloc] init]);
}
- (ZFApiHttpGetMoveGroup*) createMoveGroup {
    return FLAutorelease([[ZFApiHttpGetMoveGroup alloc] init]);
}
- (ZFApiHttpGetMovePhoto*) createMovePhoto {
    return FLAutorelease([[ZFApiHttpGetMovePhoto alloc] init]);
}
- (ZFApiHttpGetMovePhotoSet*) createMovePhotoSet {
    return FLAutorelease([[ZFApiHttpGetMovePhotoSet alloc] init]);
}
- (ZFApiHttpGetMovePhotos*) createMovePhotos {
    return FLAutorelease([[ZFApiHttpGetMovePhotos alloc] init]);
}
- (ZFApiHttpGetReindexPhotoSet*) createReindexPhotoSet {
    return FLAutorelease([[ZFApiHttpGetReindexPhotoSet alloc] init]);
}
- (ZFApiHttpGetRemoveGroupTitlePhoto*) createRemoveGroupTitlePhoto {
    return FLAutorelease([[ZFApiHttpGetRemoveGroupTitlePhoto alloc] init]);
}
- (ZFApiHttpGetRemovePhotoSetTitlePhoto*) createRemovePhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiHttpGetRemovePhotoSetTitlePhoto alloc] init]);
}
- (ZFApiHttpGetReorderGroup*) createReorderGroup {
    return FLAutorelease([[ZFApiHttpGetReorderGroup alloc] init]);
}
- (ZFApiHttpGetReorderPhotoSet*) createReorderPhotoSet {
    return FLAutorelease([[ZFApiHttpGetReorderPhotoSet alloc] init]);
}
- (ZFApiHttpGetReplacePhoto*) createReplacePhoto {
    return FLAutorelease([[ZFApiHttpGetReplacePhoto alloc] init]);
}
- (ZFApiHttpGetResolveReference*) createResolveReference {
    return FLAutorelease([[ZFApiHttpGetResolveReference alloc] init]);
}
- (ZFApiHttpGetRotatePhoto*) createRotatePhoto {
    return FLAutorelease([[ZFApiHttpGetRotatePhoto alloc] init]);
}
- (ZFApiHttpGetSearchPhotoByCategory*) createSearchPhotoByCategory {
    return FLAutorelease([[ZFApiHttpGetSearchPhotoByCategory alloc] init]);
}
- (ZFApiHttpGetSearchPhotoByText*) createSearchPhotoByText {
    return FLAutorelease([[ZFApiHttpGetSearchPhotoByText alloc] init]);
}
- (ZFApiHttpGetSearchSetByCategory*) createSearchSetByCategory {
    return FLAutorelease([[ZFApiHttpGetSearchSetByCategory alloc] init]);
}
- (ZFApiHttpGetSearchSetByText*) createSearchSetByText {
    return FLAutorelease([[ZFApiHttpGetSearchSetByText alloc] init]);
}
- (ZFApiHttpGetSetGroupTitlePhoto*) createSetGroupTitlePhoto {
    return FLAutorelease([[ZFApiHttpGetSetGroupTitlePhoto alloc] init]);
}
- (ZFApiHttpGetSetPhotoSetFeaturedIndex*) createSetPhotoSetFeaturedIndex {
    return FLAutorelease([[ZFApiHttpGetSetPhotoSetFeaturedIndex alloc] init]);
}
- (ZFApiHttpGetSetPhotoSetTitlePhoto*) createSetPhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiHttpGetSetPhotoSetTitlePhoto alloc] init]);
}
- (ZFApiHttpGetSetRandomPhotoSetTitlePhoto*) createSetRandomPhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiHttpGetSetRandomPhotoSetTitlePhoto alloc] init]);
}
- (ZFApiHttpGetShareFavoritesSet*) createShareFavoritesSet {
    return FLAutorelease([[ZFApiHttpGetShareFavoritesSet alloc] init]);
}
- (ZFApiHttpGetUndeleteMessage*) createUndeleteMessage {
    return FLAutorelease([[ZFApiHttpGetUndeleteMessage alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif
- (NSString*) location {
    return @"http://api.zenfolio.com/api/1.7/zfapi.asmx";;
}
- (NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";;
}
- (NSString*) url {
    return @"http://www.zenfolio.com/api/1.7";;
}

@end