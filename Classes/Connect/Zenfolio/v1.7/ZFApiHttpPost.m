// 
// ZFApiHttpPost.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 6:24 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFApiHttpPost.h"
#import "ZFApiHttpPostLoadSharedFavoritesSets.h"
#import "ZFApiHttpPostRotatePhoto.h"
#import "ZFApiHttpPostUndeleteMessage.h"
#import "ZFApiHttpPostSearchPhotoByCategory.h"
#import "ZFApiHttpPostMovePhoto.h"
#import "ZFApiHttpPostSearchSetByCategory.h"
#import "ZFApiHttpPostSetRandomPhotoSetTitlePhoto.h"
#import "ZFApiHttpPostKeyringGetUnlockedRealms.h"
#import "ZFApiHttpPostGetVideoPlaybackUrl.h"
#import "ZFApiHttpPostCollectionAddPhoto.h"
#import "ZFApiHttpPostGetVersion.h"
#import "ZFApiHttpPostGetVisitorKey.h"
#import "ZFApiHttpPostDeleteGroup.h"
#import "ZFApiHttpPostGetChallenge.h"
#import "ZFApiHttpPostDeletePhoto.h"
#import "ZFApiHttpPostLoadGroupHierarchy.h"
#import "ZFApiHttpPostMovePhotos.h"
#import "ZFApiHttpPostCollectionRemovePhoto.h"
#import "ZFApiHttpPostGetRecentPhotos.h"
#import "ZFApiHttpPostSetPhotoSetTitlePhoto.h"
#import "ZFApiHttpPostReplacePhoto.h"
#import "ZFApiHttpPostMoveGroup.h"
#import "ZFApiHttpPostLoadAccessRealm.h"
#import "ZFApiHttpPostResolveReference.h"
#import "ZFApiHttpPostSearchSetByText.h"
#import "ZFApiHttpPostAuthenticateVisitor.h"
#import "ZFApiHttpPostCheckPrivilege.h"
#import "ZFApiHttpPostSetPhotoSetFeaturedIndex.h"
#import "ZFApiHttpPostRemovePhotoSetTitlePhoto.h"
#import "ZFApiHttpPostLoadPrivateProfile.h"
#import "ZFApiHttpPostLoadPublicProfile.h"
#import "ZFApiHttpPostCreateVideoFromUrl.h"
#import "ZFApiHttpPostGetDownloadOriginalKey.h"
#import "ZFApiHttpPostGetPopularSets.h"
#import "ZFApiHttpPostLoadPhoto.h"
#import "ZFApiHttpPostLoadPhotoSet.h"
#import "ZFApiHttpPostAuthenticate.h"
#import "ZFApiHttpPostLoadMessages.h"
#import "ZFApiHttpPostGetCategories.h"
#import "ZFApiHttpPostRemoveGroupTitlePhoto.h"
#import "ZFApiHttpPostMovePhotoSet.h"
#import "ZFApiHttpPostDeleteMessage.h"
#import "ZFApiHttpPostSearchPhotoByText.h"
#import "ZFApiHttpPostLoadPhotoSetPhotos.h"
#import "ZFApiHttpPostKeyringAddKeyPlain.h"
#import "ZFApiHttpPostReorderPhotoSet.h"
#import "ZFApiHttpPostDeletePhotoSet.h"
#import "ZFApiHttpPostLoadGroup.h"
#import "ZFApiHttpPostShareFavoritesSet.h"
#import "FLModelObject.h"
#import "ZFApiHttpPostCreatePhotoFromUrl.h"
#import "ZFApiHttpPostReorderGroup.h"
#import "ZFApiHttpPostDeletePhotos.h"
#import "ZFApiHttpPostCreateFavoritesSet.h"
#import "ZFApiHttpPostAuthenticatePlain.h"
#import "ZFApiHttpPostReindexPhotoSet.h"
#import "ZFApiHttpPostSetGroupTitlePhoto.h"
#import "ZFApiHttpPostGetRecentSets.h"
#import "ZFApiHttpPostGetPopularPhotos.h"
@implementation ZFApiHttpPost
- (NSString*) url {
    return @"http://www.zenfolio.com/api/1.7";
}
- (NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";
}
- (NSString*) location {
    return @"http://api.zenfolio.com/api/1.7/zfapi.asmx";
}
- (ZFApiHttpPostRemoveGroupTitlePhoto*) createRemoveGroupTitlePhoto {
    return FLAutorelease([[ZFApiHttpPostRemoveGroupTitlePhoto alloc] init]);
}
- (ZFApiHttpPostRemovePhotoSetTitlePhoto*) createRemovePhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiHttpPostRemovePhotoSetTitlePhoto alloc] init]);
}
- (ZFApiHttpPostSetRandomPhotoSetTitlePhoto*) createSetRandomPhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiHttpPostSetRandomPhotoSetTitlePhoto alloc] init]);
}
- (ZFApiHttpPostMovePhotos*) createMovePhotos {
    return FLAutorelease([[ZFApiHttpPostMovePhotos alloc] init]);
}
- (ZFApiHttpPostDeletePhotos*) createDeletePhotos {
    return FLAutorelease([[ZFApiHttpPostDeletePhotos alloc] init]);
}
- (ZFApiHttpPostAuthenticateVisitor*) createAuthenticateVisitor {
    return FLAutorelease([[ZFApiHttpPostAuthenticateVisitor alloc] init]);
}
- (ZFApiHttpPostGetVisitorKey*) createGetVisitorKey {
    return FLAutorelease([[ZFApiHttpPostGetVisitorKey alloc] init]);
}
- (ZFApiHttpPostAuthenticatePlain*) createAuthenticatePlain {
    return FLAutorelease([[ZFApiHttpPostAuthenticatePlain alloc] init]);
}
- (ZFApiHttpPostGetChallenge*) createGetChallenge {
    return FLAutorelease([[ZFApiHttpPostGetChallenge alloc] init]);
}
- (ZFApiHttpPostAuthenticate*) createAuthenticate {
    return FLAutorelease([[ZFApiHttpPostAuthenticate alloc] init]);
}
- (ZFApiHttpPostLoadPrivateProfile*) createLoadPrivateProfile {
    return FLAutorelease([[ZFApiHttpPostLoadPrivateProfile alloc] init]);
}
- (ZFApiHttpPostLoadPublicProfile*) createLoadPublicProfile {
    return FLAutorelease([[ZFApiHttpPostLoadPublicProfile alloc] init]);
}
- (ZFApiHttpPostLoadGroupHierarchy*) createLoadGroupHierarchy {
    return FLAutorelease([[ZFApiHttpPostLoadGroupHierarchy alloc] init]);
}
- (ZFApiHttpPostLoadGroup*) createLoadGroup {
    return FLAutorelease([[ZFApiHttpPostLoadGroup alloc] init]);
}
- (ZFApiHttpPostLoadAccessRealm*) createLoadAccessRealm {
    return FLAutorelease([[ZFApiHttpPostLoadAccessRealm alloc] init]);
}
- (ZFApiHttpPostLoadPhotoSet*) createLoadPhotoSet {
    return FLAutorelease([[ZFApiHttpPostLoadPhotoSet alloc] init]);
}
- (ZFApiHttpPostLoadPhotoSetPhotos*) createLoadPhotoSetPhotos {
    return FLAutorelease([[ZFApiHttpPostLoadPhotoSetPhotos alloc] init]);
}
- (ZFApiHttpPostLoadPhoto*) createLoadPhoto {
    return FLAutorelease([[ZFApiHttpPostLoadPhoto alloc] init]);
}
- (ZFApiHttpPostKeyringAddKeyPlain*) createKeyringAddKeyPlain {
    return FLAutorelease([[ZFApiHttpPostKeyringAddKeyPlain alloc] init]);
}
- (ZFApiHttpPostKeyringGetUnlockedRealms*) createKeyringGetUnlockedRealms {
    return FLAutorelease([[ZFApiHttpPostKeyringGetUnlockedRealms alloc] init]);
}
- (ZFApiHttpPostGetDownloadOriginalKey*) createGetDownloadOriginalKey {
    return FLAutorelease([[ZFApiHttpPostGetDownloadOriginalKey alloc] init]);
}
- (ZFApiHttpPostGetCategories*) createGetCategories {
    return FLAutorelease([[ZFApiHttpPostGetCategories alloc] init]);
}
- (ZFApiHttpPostSearchSetByCategory*) createSearchSetByCategory {
    return FLAutorelease([[ZFApiHttpPostSearchSetByCategory alloc] init]);
}
- (ZFApiHttpPostSearchSetByText*) createSearchSetByText {
    return FLAutorelease([[ZFApiHttpPostSearchSetByText alloc] init]);
}
- (ZFApiHttpPostGetPopularSets*) createGetPopularSets {
    return FLAutorelease([[ZFApiHttpPostGetPopularSets alloc] init]);
}
- (ZFApiHttpPostGetRecentSets*) createGetRecentSets {
    return FLAutorelease([[ZFApiHttpPostGetRecentSets alloc] init]);
}
- (ZFApiHttpPostSearchPhotoByCategory*) createSearchPhotoByCategory {
    return FLAutorelease([[ZFApiHttpPostSearchPhotoByCategory alloc] init]);
}
- (ZFApiHttpPostSearchPhotoByText*) createSearchPhotoByText {
    return FLAutorelease([[ZFApiHttpPostSearchPhotoByText alloc] init]);
}
- (ZFApiHttpPostGetPopularPhotos*) createGetPopularPhotos {
    return FLAutorelease([[ZFApiHttpPostGetPopularPhotos alloc] init]);
}
- (ZFApiHttpPostGetRecentPhotos*) createGetRecentPhotos {
    return FLAutorelease([[ZFApiHttpPostGetRecentPhotos alloc] init]);
}
- (ZFApiHttpPostDeleteGroup*) createDeleteGroup {
    return FLAutorelease([[ZFApiHttpPostDeleteGroup alloc] init]);
}
- (ZFApiHttpPostDeletePhotoSet*) createDeletePhotoSet {
    return FLAutorelease([[ZFApiHttpPostDeletePhotoSet alloc] init]);
}
- (ZFApiHttpPostDeletePhoto*) createDeletePhoto {
    return FLAutorelease([[ZFApiHttpPostDeletePhoto alloc] init]);
}
- (ZFApiHttpPostCollectionAddPhoto*) createCollectionAddPhoto {
    return FLAutorelease([[ZFApiHttpPostCollectionAddPhoto alloc] init]);
}
- (ZFApiHttpPostCollectionRemovePhoto*) createCollectionRemovePhoto {
    return FLAutorelease([[ZFApiHttpPostCollectionRemovePhoto alloc] init]);
}
- (ZFApiHttpPostReorderPhotoSet*) createReorderPhotoSet {
    return FLAutorelease([[ZFApiHttpPostReorderPhotoSet alloc] init]);
}
- (ZFApiHttpPostReindexPhotoSet*) createReindexPhotoSet {
    return FLAutorelease([[ZFApiHttpPostReindexPhotoSet alloc] init]);
}
- (ZFApiHttpPostMovePhoto*) createMovePhoto {
    return FLAutorelease([[ZFApiHttpPostMovePhoto alloc] init]);
}
- (ZFApiHttpPostRotatePhoto*) createRotatePhoto {
    return FLAutorelease([[ZFApiHttpPostRotatePhoto alloc] init]);
}
- (ZFApiHttpPostSetGroupTitlePhoto*) createSetGroupTitlePhoto {
    return FLAutorelease([[ZFApiHttpPostSetGroupTitlePhoto alloc] init]);
}
- (ZFApiHttpPostSetPhotoSetTitlePhoto*) createSetPhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiHttpPostSetPhotoSetTitlePhoto alloc] init]);
}
- (ZFApiHttpPostSetPhotoSetFeaturedIndex*) createSetPhotoSetFeaturedIndex {
    return FLAutorelease([[ZFApiHttpPostSetPhotoSetFeaturedIndex alloc] init]);
}
- (ZFApiHttpPostMovePhotoSet*) createMovePhotoSet {
    return FLAutorelease([[ZFApiHttpPostMovePhotoSet alloc] init]);
}
- (ZFApiHttpPostReorderGroup*) createReorderGroup {
    return FLAutorelease([[ZFApiHttpPostReorderGroup alloc] init]);
}
- (ZFApiHttpPostReplacePhoto*) createReplacePhoto {
    return FLAutorelease([[ZFApiHttpPostReplacePhoto alloc] init]);
}
- (ZFApiHttpPostMoveGroup*) createMoveGroup {
    return FLAutorelease([[ZFApiHttpPostMoveGroup alloc] init]);
}
- (ZFApiHttpPostLoadMessages*) createLoadMessages {
    return FLAutorelease([[ZFApiHttpPostLoadMessages alloc] init]);
}
- (ZFApiHttpPostDeleteMessage*) createDeleteMessage {
    return FLAutorelease([[ZFApiHttpPostDeleteMessage alloc] init]);
}
- (ZFApiHttpPostUndeleteMessage*) createUndeleteMessage {
    return FLAutorelease([[ZFApiHttpPostUndeleteMessage alloc] init]);
}
- (ZFApiHttpPostGetVersion*) createGetVersion {
    return FLAutorelease([[ZFApiHttpPostGetVersion alloc] init]);
}
- (ZFApiHttpPostCheckPrivilege*) createCheckPrivilege {
    return FLAutorelease([[ZFApiHttpPostCheckPrivilege alloc] init]);
}
- (ZFApiHttpPostCreateFavoritesSet*) createCreateFavoritesSet {
    return FLAutorelease([[ZFApiHttpPostCreateFavoritesSet alloc] init]);
}
- (ZFApiHttpPostShareFavoritesSet*) createShareFavoritesSet {
    return FLAutorelease([[ZFApiHttpPostShareFavoritesSet alloc] init]);
}
- (ZFApiHttpPostLoadSharedFavoritesSets*) createLoadSharedFavoritesSets {
    return FLAutorelease([[ZFApiHttpPostLoadSharedFavoritesSets alloc] init]);
}
- (ZFApiHttpPostGetVideoPlaybackUrl*) createGetVideoPlaybackUrl {
    return FLAutorelease([[ZFApiHttpPostGetVideoPlaybackUrl alloc] init]);
}
- (ZFApiHttpPostResolveReference*) createResolveReference {
    return FLAutorelease([[ZFApiHttpPostResolveReference alloc] init]);
}
- (ZFApiHttpPostCreatePhotoFromUrl*) createCreatePhotoFromUrl {
    return FLAutorelease([[ZFApiHttpPostCreatePhotoFromUrl alloc] init]);
}
- (ZFApiHttpPostCreateVideoFromUrl*) createCreateVideoFromUrl {
    return FLAutorelease([[ZFApiHttpPostCreateVideoFromUrl alloc] init]);
}
+ (ZFApiHttpPost*) apiHttpPost {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif
@end
