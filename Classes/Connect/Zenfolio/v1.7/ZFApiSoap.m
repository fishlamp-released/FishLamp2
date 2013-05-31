// 
// ZFApiSoap.m
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

#import "ZFApiSoap.h"
#import "ZFApiSoapLoadGroupHierarchy.h"
#import "ZFApiSoapUndeleteMessage.h"
#import "ZFApiSoapUpdatePhotoSet.h"
#import "ZFApiSoapCreatePhotoFromUrl.h"
#import "ZFApiSoapSearchSetByText.h"
#import "ZFApiSoapKeyringGetUnlockedRealms.h"
#import "ZFApiSoapLoadSharedFavoritesSets.h"
#import "ZFApiSoapLoadPhotoSet.h"
#import "ZFApiSoapLoadPrivateProfile.h"
#import "ZFApiSoapSetGroupTitlePhoto.h"
#import "ZFApiSoapMovePhotos.h"
#import "ZFApiSoapCreateQuickBlogPost.h"
#import "ZFApiSoapRemoveGroupTitlePhoto.h"
#import "ZFApiSoapCheckPrivilege.h"
#import "ZFApiSoapCreatePhotoSet.h"
#import "ZFApiSoapReindexPhotoSet.h"
#import "ZFApiSoapSetPhotoSetFeaturedIndex.h"
#import "ZFApiSoapSearchSetByCategory.h"
#import "ZFApiSoapDeletePhotos.h"
#import "ZFApiSoapGetRecentSets.h"
#import "ZFApiSoapDeleteMessage.h"
#import "ZFApiSoapSetRandomPhotoSetTitlePhoto.h"
#import "ZFApiSoapDeleteGroup.h"
#import "ZFApiSoapUpdateGroupAccess.h"
#import "ZFApiSoapGetVersion.h"
#import "ZFApiSoapUpdateGroup.h"
#import "ZFApiSoapCollectionRemovePhoto.h"
#import "ZFApiSoapLoadPublicProfile.h"
#import "ZFApiSoapShareFavoritesSet.h"
#import "ZFApiSoapGetDownloadOriginalKey.h"
#import "ZFApiSoapGetPopularPhotos.h"
#import "ZFApiSoapAuthenticatePlain.h"
#import "ZFApiSoapSearchPhotoByText.h"
#import "ZFApiSoapReplacePhoto.h"
#import "ZFApiSoapSearchPhotoByCategory.h"
#import "ZFApiSoapDeletePhoto.h"
#import "ZFApiSoapGetRecentPhotos.h"
#import "ZFApiSoapCreateFavoritesSet.h"
#import "ZFApiSoapMovePhotoSet.h"
#import "ZFApiSoapReorderGroup.h"
#import "ZFApiSoapUpdatePhoto.h"
#import "ZFApiSoapRemovePhotoSetTitlePhoto.h"
#import "ZFApiSoapLoadMessages.h"
#import "ZFApiSoapMovePhoto.h"
#import "ZFApiSoapDeletePhotoSet.h"
#import "ZFApiSoapReorderPhotoSet.h"
#import "ZFApiSoapGetVideoPlaybackUrl.h"
#import "ZFApiSoapGetPopularSets.h"
#import "ZFApiSoapCreateGroup.h"
#import "ZFApiSoapCreateVideoFromUrl.h"
#import "ZFApiSoapUpdatePhotoSetAccess.h"
#import "ZFApiSoapMoveGroup.h"
#import "ZFApiSoapGetCategories.h"
#import "ZFApiSoapGetChallenge.h"
#import "FLModelObject.h"
#import "ZFApiSoapLoadPhotoSetPhotos.h"
#import "ZFApiSoapLoadPhoto.h"
#import "ZFApiSoapResolveReference.h"
#import "ZFApiSoapLoadAccessRealm.h"
#import "ZFApiSoapKeyringAddKeyPlain.h"
#import "ZFApiSoapRotatePhoto.h"
#import "ZFApiSoapAddMessage.h"
#import "ZFApiSoapCollectionAddPhoto.h"
#import "ZFApiSoapGetVisitorKey.h"
#import "ZFApiSoapUpdatePhotoAccess.h"
#import "ZFApiSoapAuthenticateVisitor.h"
#import "ZFApiSoapLoadGroup.h"
#import "ZFApiSoapSetPhotoSetTitlePhoto.h"
#import "ZFApiSoapAuthenticate.h"
@implementation ZFApiSoap
- (NSString*) url {
    return @"http://www.zenfolio.com/api/1.7";
}
- (NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";
}
- (NSString*) location {
    return @"http://api.zenfolio.com/api/1.7/zfapi.asmx";
}
- (ZFApiSoapRemoveGroupTitlePhoto*) createRemoveGroupTitlePhoto {
    return FLAutorelease([[ZFApiSoapRemoveGroupTitlePhoto alloc] init]);
}
- (ZFApiSoapRemovePhotoSetTitlePhoto*) createRemovePhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiSoapRemovePhotoSetTitlePhoto alloc] init]);
}
- (ZFApiSoapSetRandomPhotoSetTitlePhoto*) createSetRandomPhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiSoapSetRandomPhotoSetTitlePhoto alloc] init]);
}
- (ZFApiSoapMovePhotos*) createMovePhotos {
    return FLAutorelease([[ZFApiSoapMovePhotos alloc] init]);
}
- (ZFApiSoapDeletePhotos*) createDeletePhotos {
    return FLAutorelease([[ZFApiSoapDeletePhotos alloc] init]);
}
- (ZFApiSoapAuthenticateVisitor*) createAuthenticateVisitor {
    return FLAutorelease([[ZFApiSoapAuthenticateVisitor alloc] init]);
}
- (ZFApiSoapGetVisitorKey*) createGetVisitorKey {
    return FLAutorelease([[ZFApiSoapGetVisitorKey alloc] init]);
}
- (ZFApiSoapAuthenticatePlain*) createAuthenticatePlain {
    return FLAutorelease([[ZFApiSoapAuthenticatePlain alloc] init]);
}
- (ZFApiSoapGetChallenge*) createGetChallenge {
    return FLAutorelease([[ZFApiSoapGetChallenge alloc] init]);
}
- (ZFApiSoapAuthenticate*) createAuthenticate {
    return FLAutorelease([[ZFApiSoapAuthenticate alloc] init]);
}
- (ZFApiSoapLoadPrivateProfile*) createLoadPrivateProfile {
    return FLAutorelease([[ZFApiSoapLoadPrivateProfile alloc] init]);
}
- (ZFApiSoapLoadPublicProfile*) createLoadPublicProfile {
    return FLAutorelease([[ZFApiSoapLoadPublicProfile alloc] init]);
}
- (ZFApiSoapLoadGroupHierarchy*) createLoadGroupHierarchy {
    return FLAutorelease([[ZFApiSoapLoadGroupHierarchy alloc] init]);
}
- (ZFApiSoapLoadGroup*) createLoadGroup {
    return FLAutorelease([[ZFApiSoapLoadGroup alloc] init]);
}
- (ZFApiSoapLoadAccessRealm*) createLoadAccessRealm {
    return FLAutorelease([[ZFApiSoapLoadAccessRealm alloc] init]);
}
- (ZFApiSoapLoadPhotoSet*) createLoadPhotoSet {
    return FLAutorelease([[ZFApiSoapLoadPhotoSet alloc] init]);
}
- (ZFApiSoapLoadPhotoSetPhotos*) createLoadPhotoSetPhotos {
    return FLAutorelease([[ZFApiSoapLoadPhotoSetPhotos alloc] init]);
}
- (ZFApiSoapLoadPhoto*) createLoadPhoto {
    return FLAutorelease([[ZFApiSoapLoadPhoto alloc] init]);
}
- (ZFApiSoapKeyringAddKeyPlain*) createKeyringAddKeyPlain {
    return FLAutorelease([[ZFApiSoapKeyringAddKeyPlain alloc] init]);
}
- (ZFApiSoapKeyringGetUnlockedRealms*) createKeyringGetUnlockedRealms {
    return FLAutorelease([[ZFApiSoapKeyringGetUnlockedRealms alloc] init]);
}
- (ZFApiSoapGetDownloadOriginalKey*) createGetDownloadOriginalKey {
    return FLAutorelease([[ZFApiSoapGetDownloadOriginalKey alloc] init]);
}
- (ZFApiSoapGetCategories*) createGetCategories {
    return FLAutorelease([[ZFApiSoapGetCategories alloc] init]);
}
- (ZFApiSoapSearchSetByCategory*) createSearchSetByCategory {
    return FLAutorelease([[ZFApiSoapSearchSetByCategory alloc] init]);
}
- (ZFApiSoapSearchSetByText*) createSearchSetByText {
    return FLAutorelease([[ZFApiSoapSearchSetByText alloc] init]);
}
- (ZFApiSoapGetPopularSets*) createGetPopularSets {
    return FLAutorelease([[ZFApiSoapGetPopularSets alloc] init]);
}
- (ZFApiSoapGetRecentSets*) createGetRecentSets {
    return FLAutorelease([[ZFApiSoapGetRecentSets alloc] init]);
}
- (ZFApiSoapSearchPhotoByCategory*) createSearchPhotoByCategory {
    return FLAutorelease([[ZFApiSoapSearchPhotoByCategory alloc] init]);
}
- (ZFApiSoapSearchPhotoByText*) createSearchPhotoByText {
    return FLAutorelease([[ZFApiSoapSearchPhotoByText alloc] init]);
}
- (ZFApiSoapGetPopularPhotos*) createGetPopularPhotos {
    return FLAutorelease([[ZFApiSoapGetPopularPhotos alloc] init]);
}
- (ZFApiSoapGetRecentPhotos*) createGetRecentPhotos {
    return FLAutorelease([[ZFApiSoapGetRecentPhotos alloc] init]);
}
- (ZFApiSoapCreateGroup*) createCreateGroup {
    return FLAutorelease([[ZFApiSoapCreateGroup alloc] init]);
}
- (ZFApiSoapDeleteGroup*) createDeleteGroup {
    return FLAutorelease([[ZFApiSoapDeleteGroup alloc] init]);
}
- (ZFApiSoapUpdateGroup*) createUpdateGroup {
    return FLAutorelease([[ZFApiSoapUpdateGroup alloc] init]);
}
- (ZFApiSoapCreatePhotoSet*) createCreatePhotoSet {
    return FLAutorelease([[ZFApiSoapCreatePhotoSet alloc] init]);
}
- (ZFApiSoapDeletePhotoSet*) createDeletePhotoSet {
    return FLAutorelease([[ZFApiSoapDeletePhotoSet alloc] init]);
}
- (ZFApiSoapUpdatePhotoSet*) createUpdatePhotoSet {
    return FLAutorelease([[ZFApiSoapUpdatePhotoSet alloc] init]);
}
- (ZFApiSoapDeletePhoto*) createDeletePhoto {
    return FLAutorelease([[ZFApiSoapDeletePhoto alloc] init]);
}
- (ZFApiSoapUpdatePhoto*) createUpdatePhoto {
    return FLAutorelease([[ZFApiSoapUpdatePhoto alloc] init]);
}
- (ZFApiSoapCollectionAddPhoto*) createCollectionAddPhoto {
    return FLAutorelease([[ZFApiSoapCollectionAddPhoto alloc] init]);
}
- (ZFApiSoapCollectionRemovePhoto*) createCollectionRemovePhoto {
    return FLAutorelease([[ZFApiSoapCollectionRemovePhoto alloc] init]);
}
- (ZFApiSoapUpdatePhotoAccess*) createUpdatePhotoAccess {
    return FLAutorelease([[ZFApiSoapUpdatePhotoAccess alloc] init]);
}
- (ZFApiSoapUpdatePhotoSetAccess*) createUpdatePhotoSetAccess {
    return FLAutorelease([[ZFApiSoapUpdatePhotoSetAccess alloc] init]);
}
- (ZFApiSoapUpdateGroupAccess*) createUpdateGroupAccess {
    return FLAutorelease([[ZFApiSoapUpdateGroupAccess alloc] init]);
}
- (ZFApiSoapReorderPhotoSet*) createReorderPhotoSet {
    return FLAutorelease([[ZFApiSoapReorderPhotoSet alloc] init]);
}
- (ZFApiSoapReindexPhotoSet*) createReindexPhotoSet {
    return FLAutorelease([[ZFApiSoapReindexPhotoSet alloc] init]);
}
- (ZFApiSoapMovePhoto*) createMovePhoto {
    return FLAutorelease([[ZFApiSoapMovePhoto alloc] init]);
}
- (ZFApiSoapRotatePhoto*) createRotatePhoto {
    return FLAutorelease([[ZFApiSoapRotatePhoto alloc] init]);
}
- (ZFApiSoapSetGroupTitlePhoto*) createSetGroupTitlePhoto {
    return FLAutorelease([[ZFApiSoapSetGroupTitlePhoto alloc] init]);
}
- (ZFApiSoapSetPhotoSetTitlePhoto*) createSetPhotoSetTitlePhoto {
    return FLAutorelease([[ZFApiSoapSetPhotoSetTitlePhoto alloc] init]);
}
- (ZFApiSoapSetPhotoSetFeaturedIndex*) createSetPhotoSetFeaturedIndex {
    return FLAutorelease([[ZFApiSoapSetPhotoSetFeaturedIndex alloc] init]);
}
- (ZFApiSoapMovePhotoSet*) createMovePhotoSet {
    return FLAutorelease([[ZFApiSoapMovePhotoSet alloc] init]);
}
- (ZFApiSoapReorderGroup*) createReorderGroup {
    return FLAutorelease([[ZFApiSoapReorderGroup alloc] init]);
}
- (ZFApiSoapReplacePhoto*) createReplacePhoto {
    return FLAutorelease([[ZFApiSoapReplacePhoto alloc] init]);
}
- (ZFApiSoapMoveGroup*) createMoveGroup {
    return FLAutorelease([[ZFApiSoapMoveGroup alloc] init]);
}
- (ZFApiSoapLoadMessages*) createLoadMessages {
    return FLAutorelease([[ZFApiSoapLoadMessages alloc] init]);
}
- (ZFApiSoapAddMessage*) createAddMessage {
    return FLAutorelease([[ZFApiSoapAddMessage alloc] init]);
}
- (ZFApiSoapDeleteMessage*) createDeleteMessage {
    return FLAutorelease([[ZFApiSoapDeleteMessage alloc] init]);
}
- (ZFApiSoapUndeleteMessage*) createUndeleteMessage {
    return FLAutorelease([[ZFApiSoapUndeleteMessage alloc] init]);
}
- (ZFApiSoapGetVersion*) createGetVersion {
    return FLAutorelease([[ZFApiSoapGetVersion alloc] init]);
}
- (ZFApiSoapCheckPrivilege*) createCheckPrivilege {
    return FLAutorelease([[ZFApiSoapCheckPrivilege alloc] init]);
}
- (ZFApiSoapCreateFavoritesSet*) createCreateFavoritesSet {
    return FLAutorelease([[ZFApiSoapCreateFavoritesSet alloc] init]);
}
- (ZFApiSoapShareFavoritesSet*) createShareFavoritesSet {
    return FLAutorelease([[ZFApiSoapShareFavoritesSet alloc] init]);
}
- (ZFApiSoapLoadSharedFavoritesSets*) createLoadSharedFavoritesSets {
    return FLAutorelease([[ZFApiSoapLoadSharedFavoritesSets alloc] init]);
}
- (ZFApiSoapGetVideoPlaybackUrl*) createGetVideoPlaybackUrl {
    return FLAutorelease([[ZFApiSoapGetVideoPlaybackUrl alloc] init]);
}
- (ZFApiSoapResolveReference*) createResolveReference {
    return FLAutorelease([[ZFApiSoapResolveReference alloc] init]);
}
- (ZFApiSoapCreateQuickBlogPost*) createCreateQuickBlogPost {
    return FLAutorelease([[ZFApiSoapCreateQuickBlogPost alloc] init]);
}
- (ZFApiSoapCreatePhotoFromUrl*) createCreatePhotoFromUrl {
    return FLAutorelease([[ZFApiSoapCreatePhotoFromUrl alloc] init]);
}
- (ZFApiSoapCreateVideoFromUrl*) createCreateVideoFromUrl {
    return FLAutorelease([[ZFApiSoapCreateVideoFromUrl alloc] init]);
}
+ (ZFApiSoap*) apiSoap {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif
@end