//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApi1_6All.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioAuthChallenge.h"
#import "FLZenfolioUser.h"
#import "FLZenfolioFile.h"
#import "FLZenfolioAddress.h"
#import "FLZenfolioPhotoSet.h"
#import "FLZenfolioGroupElement.h"
#import "FLZenfolioAccessDescriptor.h"
#import "FLZenfolioGroup.h"
#import "FLZenfolioPhoto.h"
#import "FLZenfolioExifTag.h"
#import "FLZenfolioCategory.h"
#import "FLZenfolioPhotoSetResult.h"
#import "FLZenfolioPhotoResult.h"
#import "FLZenfolioGroupUpdater.h"
#import "FLZenfolioPhotoSetUpdater.h"
#import "FLZenfolioPhotoUpdater.h"
#import "FLZenfolioAccessUpdater.h"
#import "FLZenfolioMessage.h"
#import "FLZenfolioMessageUpdater.h"
#import "FLZenfolioFavoritesSet.h"
#import "FLZenfolioResolveResult.h"
#import "FLZenfolioAuthenticateVisitor.h"
#import "FLZenfolioAuthenticateVisitorResponse.h"
#import "FLZenfolioGetVisitorKey.h"
#import "FLZenfolioGetVisitorKeyResponse.h"
#import "FLZenfolioAuthenticatePlain.h"
#import "FLZenfolioAuthenticatePlainResponse.h"
#import "FLZenfolioGetChallenge.h"
#import "FLZenfolioGetChallengeResponse.h"
#import "FLZenfolioAuthenticate.h"
#import "FLZenfolioAuthenticateResponse.h"
#import "FLZenfolioLoadPrivateProfile.h"
#import "FLZenfolioLoadPrivateProfileResponse.h"
#import "FLZenfolioLoadPublicProfile.h"
#import "FLZenfolioLoadPublicProfileResponse.h"
#import "FLZenfolioLoadGroupHierarchy.h"
#import "FLZenfolioLoadGroupHierarchyResponse.h"
#import "FLZenfolioLoadGroup.h"
#import "FLZenfolioLoadGroupResponse.h"
#import "FLZenfolioLoadAccessRealm.h"
#import "FLZenfolioLoadAccessRealmResponse.h"
#import "FLZenfolioLoadPhotoSet.h"
#import "FLZenfolioLoadPhotoSetResponse.h"
#import "FLZenfolioLoadPhotoSetPhotos.h"
#import "FLZenfolioLoadPhotoSetPhotosResponse.h"
#import "FLZenfolioLoadPhoto.h"
#import "FLZenfolioLoadPhotoResponse.h"
#import "FLZenfolioKeyringAddKeyPlain.h"
#import "FLZenfolioKeyringAddKeyPlainResponse.h"
#import "FLZenfolioKeyringGetUnlockedRealms.h"
#import "FLZenfolioKeyringGetUnlockedRealmsResponse.h"
#import "FLZenfolioGetDownloadOriginalKey.h"
#import "FLZenfolioGetDownloadOriginalKeyResponse.h"
#import "FLZenfolioGetCategories.h"
#import "FLZenfolioGetCategoriesResponse.h"
#import "FLZenfolioSearchSetByCategory.h"
#import "FLZenfolioSearchSetByCategoryResponse.h"
#import "FLZenfolioSearchSetByText.h"
#import "FLZenfolioSearchSetByTextResponse.h"
#import "FLZenfolioGetPopularSets.h"
#import "FLZenfolioGetPopularSetsResponse.h"
#import "FLZenfolioGetRecentSets.h"
#import "FLZenfolioGetRecentSetsResponse.h"
#import "FLZenfolioSearchPhotoByCategory.h"
#import "FLZenfolioSearchPhotoByCategoryResponse.h"
#import "FLZenfolioSearchPhotoByText.h"
#import "FLZenfolioSearchPhotoByTextResponse.h"
#import "FLZenfolioGetPopularPhotos.h"
#import "FLZenfolioGetPopularPhotosResponse.h"
#import "FLZenfolioGetRecentPhotos.h"
#import "FLZenfolioGetRecentPhotosResponse.h"
#import "FLZenfolioCreateGroup.h"
#import "FLZenfolioCreateGroupResponse.h"
#import "FLZenfolioDeleteGroup.h"
#import "FLZenfolioDeleteGroupResponse.h"
#import "FLZenfolioUpdateGroup.h"
#import "FLZenfolioUpdateGroupResponse.h"
#import "FLZenfolioCreatePhotoSet.h"
#import "FLZenfolioCreatePhotoSetResponse.h"
#import "FLZenfolioDeletePhotoSet.h"
#import "FLZenfolioDeletePhotoSetResponse.h"
#import "FLZenfolioUpdatePhotoSet.h"
#import "FLZenfolioUpdatePhotoSetResponse.h"
#import "FLZenfolioDeletePhoto.h"
#import "FLZenfolioDeletePhotoResponse.h"
#import "FLZenfolioUpdatePhoto.h"
#import "FLZenfolioUpdatePhotoResponse.h"
#import "FLZenfolioCollectionAddPhoto.h"
#import "FLZenfolioCollectionAddPhotoResponse.h"
#import "FLZenfolioCollectionRemovePhoto.h"
#import "FLZenfolioCollectionRemovePhotoResponse.h"
#import "FLZenfolioUpdatePhotoAccess.h"
#import "FLZenfolioUpdatePhotoAccessResponse.h"
#import "FLZenfolioUpdatePhotoSetAccess.h"
#import "FLZenfolioUpdatePhotoSetAccessResponse.h"
#import "FLZenfolioUpdateGroupAccess.h"
#import "FLZenfolioUpdateGroupAccessResponse.h"
#import "FLZenfolioReorderPhotoSet.h"
#import "FLZenfolioReorderPhotoSetResponse.h"
#import "FLZenfolioReindexPhotoSet.h"
#import "FLZenfolioReindexPhotoSetResponse.h"
#import "FLZenfolioMovePhoto.h"
#import "FLZenfolioMovePhotoResponse.h"
#import "FLZenfolioRotatePhoto.h"
#import "FLZenfolioRotatePhotoResponse.h"
#import "FLZenfolioSetGroupTitlePhoto.h"
#import "FLZenfolioSetGroupTitlePhotoResponse.h"
#import "FLZenfolioSetPhotoSetTitlePhoto.h"
#import "FLZenfolioSetPhotoSetTitlePhotoResponse.h"
#import "FLZenfolioSetPhotoSetFeaturedIndex.h"
#import "FLZenfolioSetPhotoSetFeaturedIndexResponse.h"
#import "FLZenfolioMovePhotoSet.h"
#import "FLZenfolioMovePhotoSetResponse.h"
#import "FLZenfolioReorderGroup.h"
#import "FLZenfolioReorderGroupResponse.h"
#import "FLZenfolioReplacePhoto.h"
#import "FLZenfolioReplacePhotoResponse.h"
#import "FLZenfolioMoveGroup.h"
#import "FLZenfolioMoveGroupResponse.h"
#import "FLZenfolioLoadMessages.h"
#import "FLZenfolioLoadMessagesResponse.h"
#import "FLZenfolioAddMessage.h"
#import "FLZenfolioAddMessageResponse.h"
#import "FLZenfolioDeleteMessage.h"
#import "FLZenfolioDeleteMessageResponse.h"
#import "FLZenfolioUndeleteMessage.h"
#import "FLZenfolioUndeleteMessageResponse.h"
#import "FLZenfolioGetVersion.h"
#import "FLZenfolioGetVersionResponse.h"
#import "FLZenfolioCheckPrivilege.h"
#import "FLZenfolioCheckPrivilegeResponse.h"
#import "FLZenfolioCreateFavoritesSet.h"
#import "FLZenfolioCreateFavoritesSetResponse.h"
#import "FLZenfolioShareFavoritesSet.h"
#import "FLZenfolioShareFavoritesSetResponse.h"
#import "FLZenfolioLoadSharedFavoritesSets.h"
#import "FLZenfolioLoadSharedFavoritesSetsResponse.h"
#import "FLZenfolioGetVideoPlaybackUrl.h"
#import "FLZenfolioGetVideoPlaybackUrlResponse.h"
#import "FLZenfolioResolveReference.h"
#import "FLZenfolioResolveReferenceResponse.h"
#import "FLZenfolioCreatePhotoFromUrl.h"
#import "FLZenfolioCreatePhotoFromUrlResponse.h"
#import "FLZenfolioCreateVideoFromUrl.h"
#import "FLZenfolioCreateVideoFromUrlResponse.h"
#import "FLZenfolioAuthenticateVisitorHttpGetIn.h"
#import "FLZenfolioGetVisitorKeyHttpGetIn.h"
#import "FLZenfolioAuthenticatePlainHttpGetIn.h"
#import "FLZenfolioGetChallengeHttpGetIn.h"
#import "FLZenfolioAuthenticateHttpGetIn.h"
#import "FLZenfolioLoadPrivateProfileHttpGetIn.h"
#import "FLZenfolioLoadPublicProfileHttpGetIn.h"
#import "FLZenfolioLoadGroupHierarchyHttpGetIn.h"
#import "FLZenfolioLoadGroupHttpGetIn.h"
#import "FLZenfolioLoadAccessRealmHttpGetIn.h"
#import "FLZenfolioLoadPhotoSetHttpGetIn.h"
#import "FLZenfolioLoadPhotoSetPhotosHttpGetIn.h"
#import "FLZenfolioLoadPhotoHttpGetIn.h"
#import "FLZenfolioKeyringAddKeyPlainHttpGetIn.h"
#import "FLZenfolioKeyringGetUnlockedRealmsHttpGetIn.h"
#import "FLZenfolioGetDownloadOriginalKeyHttpGetIn.h"
#import "FLZenfolioGetCategoriesHttpGetIn.h"
#import "FLZenfolioSearchSetByCategoryHttpGetIn.h"
#import "FLZenfolioSearchSetByTextHttpGetIn.h"
#import "FLZenfolioGetPopularSetsHttpGetIn.h"
#import "FLZenfolioGetRecentSetsHttpGetIn.h"
#import "FLZenfolioSearchPhotoByCategoryHttpGetIn.h"
#import "FLZenfolioSearchPhotoByTextHttpGetIn.h"
#import "FLZenfolioGetPopularPhotosHttpGetIn.h"
#import "FLZenfolioGetRecentPhotosHttpGetIn.h"
#import "FLZenfolioDeleteGroupHttpGetIn.h"
#import "FLZenfolioDeleteGroupHttpGetOut.h"
#import "FLZenfolioDeletePhotoSetHttpGetIn.h"
#import "FLZenfolioDeletePhotoSetHttpGetOut.h"
#import "FLZenfolioDeletePhotoHttpGetIn.h"
#import "FLZenfolioDeletePhotoHttpGetOut.h"
#import "FLZenfolioCollectionAddPhotoHttpGetIn.h"
#import "FLZenfolioCollectionAddPhotoHttpGetOut.h"
#import "FLZenfolioCollectionRemovePhotoHttpGetIn.h"
#import "FLZenfolioCollectionRemovePhotoHttpGetOut.h"
#import "FLZenfolioReorderPhotoSetHttpGetIn.h"
#import "FLZenfolioReorderPhotoSetHttpGetOut.h"
#import "FLZenfolioReindexPhotoSetHttpGetIn.h"
#import "FLZenfolioReindexPhotoSetHttpGetOut.h"
#import "FLZenfolioMovePhotoHttpGetIn.h"
#import "FLZenfolioMovePhotoHttpGetOut.h"
#import "FLZenfolioRotatePhotoHttpGetIn.h"
#import "FLZenfolioSetGroupTitlePhotoHttpGetIn.h"
#import "FLZenfolioSetGroupTitlePhotoHttpGetOut.h"
#import "FLZenfolioSetPhotoSetTitlePhotoHttpGetIn.h"
#import "FLZenfolioSetPhotoSetTitlePhotoHttpGetOut.h"
#import "FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn.h"
#import "FLZenfolioSetPhotoSetFeaturedIndexHttpGetOut.h"
#import "FLZenfolioMovePhotoSetHttpGetIn.h"
#import "FLZenfolioMovePhotoSetHttpGetOut.h"
#import "FLZenfolioReorderGroupHttpGetIn.h"
#import "FLZenfolioReorderGroupHttpGetOut.h"
#import "FLZenfolioReplacePhotoHttpGetIn.h"
#import "FLZenfolioReplacePhotoHttpGetOut.h"
#import "FLZenfolioMoveGroupHttpGetIn.h"
#import "FLZenfolioMoveGroupHttpGetOut.h"
#import "FLZenfolioLoadMessagesHttpGetIn.h"
#import "FLZenfolioDeleteMessageHttpGetIn.h"
#import "FLZenfolioDeleteMessageHttpGetOut.h"
#import "FLZenfolioUndeleteMessageHttpGetIn.h"
#import "FLZenfolioUndeleteMessageHttpGetOut.h"
#import "FLZenfolioGetVersionHttpGetIn.h"
#import "FLZenfolioCheckPrivilegeHttpGetIn.h"
#import "FLZenfolioCreateFavoritesSetHttpGetIn.h"
#import "FLZenfolioShareFavoritesSetHttpGetIn.h"
#import "FLZenfolioShareFavoritesSetHttpGetOut.h"
#import "FLZenfolioLoadSharedFavoritesSetsHttpGetIn.h"
#import "FLZenfolioGetVideoPlaybackUrlHttpGetIn.h"
#import "FLZenfolioResolveReferenceHttpGetIn.h"
#import "FLZenfolioCreatePhotoFromUrlHttpGetIn.h"
#import "FLZenfolioCreateVideoFromUrlHttpGetIn.h"
#import "FLZenfolioAuthenticateVisitorHttpPostIn.h"
#import "FLZenfolioGetVisitorKeyHttpPostIn.h"
#import "FLZenfolioAuthenticatePlainHttpPostIn.h"
#import "FLZenfolioGetChallengeHttpPostIn.h"
#import "FLZenfolioAuthenticateHttpPostIn.h"
#import "FLZenfolioLoadPrivateProfileHttpPostIn.h"
#import "FLZenfolioLoadPublicProfileHttpPostIn.h"
#import "FLZenfolioLoadGroupHierarchyHttpPostIn.h"
#import "FLZenfolioLoadGroupHttpPostIn.h"
#import "FLZenfolioLoadAccessRealmHttpPostIn.h"
#import "FLZenfolioLoadPhotoSetHttpPostIn.h"
#import "FLZenfolioLoadPhotoSetPhotosHttpPostIn.h"
#import "FLZenfolioLoadPhotoHttpPostIn.h"
#import "FLZenfolioKeyringAddKeyPlainHttpPostIn.h"
#import "FLZenfolioKeyringGetUnlockedRealmsHttpPostIn.h"
#import "FLZenfolioGetDownloadOriginalKeyHttpPostIn.h"
#import "FLZenfolioGetCategoriesHttpPostIn.h"
#import "FLZenfolioSearchSetByCategoryHttpPostIn.h"
#import "FLZenfolioSearchSetByTextHttpPostIn.h"
#import "FLZenfolioGetPopularSetsHttpPostIn.h"
#import "FLZenfolioGetRecentSetsHttpPostIn.h"
#import "FLZenfolioSearchPhotoByCategoryHttpPostIn.h"
#import "FLZenfolioSearchPhotoByTextHttpPostIn.h"
#import "FLZenfolioGetPopularPhotosHttpPostIn.h"
#import "FLZenfolioGetRecentPhotosHttpPostIn.h"
#import "FLZenfolioDeleteGroupHttpPostIn.h"
#import "FLZenfolioDeleteGroupHttpPostOut.h"
#import "FLZenfolioDeletePhotoSetHttpPostIn.h"
#import "FLZenfolioDeletePhotoSetHttpPostOut.h"
#import "FLZenfolioDeletePhotoHttpPostIn.h"
#import "FLZenfolioDeletePhotoHttpPostOut.h"
#import "FLZenfolioCollectionAddPhotoHttpPostIn.h"
#import "FLZenfolioCollectionAddPhotoHttpPostOut.h"
#import "FLZenfolioCollectionRemovePhotoHttpPostIn.h"
#import "FLZenfolioCollectionRemovePhotoHttpPostOut.h"
#import "FLZenfolioReorderPhotoSetHttpPostIn.h"
#import "FLZenfolioReorderPhotoSetHttpPostOut.h"
#import "FLZenfolioReindexPhotoSetHttpPostIn.h"
#import "FLZenfolioReindexPhotoSetHttpPostOut.h"
#import "FLZenfolioMovePhotoHttpPostIn.h"
#import "FLZenfolioMovePhotoHttpPostOut.h"
#import "FLZenfolioRotatePhotoHttpPostIn.h"
#import "FLZenfolioSetGroupTitlePhotoHttpPostIn.h"
#import "FLZenfolioSetGroupTitlePhotoHttpPostOut.h"
#import "FLZenfolioSetPhotoSetTitlePhotoHttpPostIn.h"
#import "FLZenfolioSetPhotoSetTitlePhotoHttpPostOut.h"
#import "FLZenfolioSetPhotoSetFeaturedIndexHttpPostIn.h"
#import "FLZenfolioSetPhotoSetFeaturedIndexHttpPostOut.h"
#import "FLZenfolioMovePhotoSetHttpPostIn.h"
#import "FLZenfolioMovePhotoSetHttpPostOut.h"
#import "FLZenfolioReorderGroupHttpPostIn.h"
#import "FLZenfolioReorderGroupHttpPostOut.h"
#import "FLZenfolioReplacePhotoHttpPostIn.h"
#import "FLZenfolioReplacePhotoHttpPostOut.h"
#import "FLZenfolioMoveGroupHttpPostIn.h"
#import "FLZenfolioMoveGroupHttpPostOut.h"
#import "FLZenfolioLoadMessagesHttpPostIn.h"
#import "FLZenfolioDeleteMessageHttpPostIn.h"
#import "FLZenfolioDeleteMessageHttpPostOut.h"
#import "FLZenfolioUndeleteMessageHttpPostIn.h"
#import "FLZenfolioUndeleteMessageHttpPostOut.h"
#import "FLZenfolioGetVersionHttpPostIn.h"
#import "FLZenfolioCheckPrivilegeHttpPostIn.h"
#import "FLZenfolioCreateFavoritesSetHttpPostIn.h"
#import "FLZenfolioShareFavoritesSetHttpPostIn.h"
#import "FLZenfolioShareFavoritesSetHttpPostOut.h"
#import "FLZenfolioLoadSharedFavoritesSetsHttpPostIn.h"
#import "FLZenfolioGetVideoPlaybackUrlHttpPostIn.h"
#import "FLZenfolioResolveReferenceHttpPostIn.h"
#import "FLZenfolioCreatePhotoFromUrlHttpPostIn.h"
#import "FLZenfolioCreateVideoFromUrlHttpPostIn.h"
#import "FLZenfolioApiSoap.h"
#import "FLZenfolioApiHttpGet.h"
#import "FLZenfolioApiHttpPost.h"
#import "FLZenfolioApiSoapAuthenticateVisitor.h"
#import "FLZenfolioApiSoapGetVisitorKey.h"
#import "FLZenfolioApiSoapAuthenticatePlain.h"
#import "FLZenfolioApiSoapGetChallenge.h"
#import "FLZenfolioApiSoapAuthenticate.h"
#import "FLZenfolioApiSoapLoadPrivateProfile.h"
#import "FLZenfolioApiSoapLoadPublicProfile.h"
#import "FLZenfolioApiSoapLoadGroupHierarchy.h"
#import "FLZenfolioApiSoapLoadGroup.h"
#import "FLZenfolioApiSoapLoadAccessRealm.h"
#import "FLZenfolioApiSoapLoadPhotoSet.h"
#import "FLZenfolioApiSoapLoadPhotoSetPhotos.h"
#import "FLZenfolioApiSoapLoadPhoto.h"
#import "FLZenfolioApiSoapKeyringAddKeyPlain.h"
#import "FLZenfolioApiSoapKeyringGetUnlockedRealms.h"
#import "FLZenfolioApiSoapGetDownloadOriginalKey.h"
#import "FLZenfolioApiSoapGetCategories.h"
#import "FLZenfolioApiSoapSearchSetByCategory.h"
#import "FLZenfolioApiSoapSearchSetByText.h"
#import "FLZenfolioApiSoapGetPopularSets.h"
#import "FLZenfolioApiSoapGetRecentSets.h"
#import "FLZenfolioApiSoapSearchPhotoByCategory.h"
#import "FLZenfolioApiSoapSearchPhotoByText.h"
#import "FLZenfolioApiSoapGetPopularPhotos.h"
#import "FLZenfolioApiSoapGetRecentPhotos.h"
#import "FLZenfolioApiSoapCreateGroup.h"
#import "FLZenfolioApiSoapDeleteGroup.h"
#import "FLZenfolioApiSoapUpdateGroup.h"
#import "FLZenfolioApiSoapCreatePhotoSet.h"
#import "FLZenfolioApiSoapDeletePhotoSet.h"
#import "FLZenfolioApiSoapUpdatePhotoSet.h"
#import "FLZenfolioApiSoapDeletePhoto.h"
#import "FLZenfolioApiSoapUpdatePhoto.h"
#import "FLZenfolioApiSoapCollectionAddPhoto.h"
#import "FLZenfolioApiSoapCollectionRemovePhoto.h"
#import "FLZenfolioApiSoapUpdatePhotoAccess.h"
#import "FLZenfolioApiSoapUpdatePhotoSetAccess.h"
#import "FLZenfolioApiSoapUpdateGroupAccess.h"
#import "FLZenfolioApiSoapReorderPhotoSet.h"
#import "FLZenfolioApiSoapReindexPhotoSet.h"
#import "FLZenfolioApiSoapMovePhoto.h"
#import "FLZenfolioApiSoapRotatePhoto.h"
#import "FLZenfolioApiSoapSetGroupTitlePhoto.h"
#import "FLZenfolioApiSoapSetPhotoSetTitlePhoto.h"
#import "FLZenfolioApiSoapSetPhotoSetFeaturedIndex.h"
#import "FLZenfolioApiSoapMovePhotoSet.h"
#import "FLZenfolioApiSoapReorderGroup.h"
#import "FLZenfolioApiSoapReplacePhoto.h"
#import "FLZenfolioApiSoapMoveGroup.h"
#import "FLZenfolioApiSoapLoadMessages.h"
#import "FLZenfolioApiSoapAddMessage.h"
#import "FLZenfolioApiSoapDeleteMessage.h"
#import "FLZenfolioApiSoapUndeleteMessage.h"
#import "FLZenfolioApiSoapGetVersion.h"
#import "FLZenfolioApiSoapCheckPrivilege.h"
#import "FLZenfolioApiSoapCreateFavoritesSet.h"
#import "FLZenfolioApiSoapShareFavoritesSet.h"
#import "FLZenfolioApiSoapLoadSharedFavoritesSets.h"
#import "FLZenfolioApiSoapGetVideoPlaybackUrl.h"
#import "FLZenfolioApiSoapResolveReference.h"
#import "FLZenfolioApiSoapCreatePhotoFromUrl.h"
#import "FLZenfolioApiSoapCreateVideoFromUrl.h"
#import "FLZenfolioApiHttpGetAuthenticateVisitor.h"
#import "FLZenfolioApiHttpGetGetVisitorKey.h"
#import "FLZenfolioApiHttpGetAuthenticatePlain.h"
#import "FLZenfolioApiHttpGetGetChallenge.h"
#import "FLZenfolioApiHttpGetAuthenticate.h"
#import "FLZenfolioApiHttpGetLoadPrivateProfile.h"
#import "FLZenfolioApiHttpGetLoadPublicProfile.h"
#import "FLZenfolioApiHttpGetLoadGroupHierarchy.h"
#import "FLZenfolioApiHttpGetLoadGroup.h"
#import "FLZenfolioApiHttpGetLoadAccessRealm.h"
#import "FLZenfolioApiHttpGetLoadPhotoSet.h"
#import "FLZenfolioApiHttpGetLoadPhotoSetPhotos.h"
#import "FLZenfolioApiHttpGetLoadPhoto.h"
#import "FLZenfolioApiHttpGetKeyringAddKeyPlain.h"
#import "FLZenfolioApiHttpGetKeyringGetUnlockedRealms.h"
#import "FLZenfolioApiHttpGetGetDownloadOriginalKey.h"
#import "FLZenfolioApiHttpGetGetCategories.h"
#import "FLZenfolioApiHttpGetSearchSetByCategory.h"
#import "FLZenfolioApiHttpGetSearchSetByText.h"
#import "FLZenfolioApiHttpGetGetPopularSets.h"
#import "FLZenfolioApiHttpGetGetRecentSets.h"
#import "FLZenfolioApiHttpGetSearchPhotoByCategory.h"
#import "FLZenfolioApiHttpGetSearchPhotoByText.h"
#import "FLZenfolioApiHttpGetGetPopularPhotos.h"
#import "FLZenfolioApiHttpGetGetRecentPhotos.h"
#import "FLZenfolioApiHttpGetDeleteGroup.h"
#import "FLZenfolioApiHttpGetDeletePhotoSet.h"
#import "FLZenfolioApiHttpGetDeletePhoto.h"
#import "FLZenfolioApiHttpGetCollectionAddPhoto.h"
#import "FLZenfolioApiHttpGetCollectionRemovePhoto.h"
#import "FLZenfolioApiHttpGetReorderPhotoSet.h"
#import "FLZenfolioApiHttpGetReindexPhotoSet.h"
#import "FLZenfolioApiHttpGetMovePhoto.h"
#import "FLZenfolioApiHttpGetRotatePhoto.h"
#import "FLZenfolioApiHttpGetSetGroupTitlePhoto.h"
#import "FLZenfolioApiHttpGetSetPhotoSetTitlePhoto.h"
#import "FLZenfolioApiHttpGetSetPhotoSetFeaturedIndex.h"
#import "FLZenfolioApiHttpGetMovePhotoSet.h"
#import "FLZenfolioApiHttpGetReorderGroup.h"
#import "FLZenfolioApiHttpGetReplacePhoto.h"
#import "FLZenfolioApiHttpGetMoveGroup.h"
#import "FLZenfolioApiHttpGetLoadMessages.h"
#import "FLZenfolioApiHttpGetDeleteMessage.h"
#import "FLZenfolioApiHttpGetUndeleteMessage.h"
#import "FLZenfolioApiHttpGetGetVersion.h"
#import "FLZenfolioApiHttpGetCheckPrivilege.h"
#import "FLZenfolioApiHttpGetCreateFavoritesSet.h"
#import "FLZenfolioApiHttpGetShareFavoritesSet.h"
#import "FLZenfolioApiHttpGetLoadSharedFavoritesSets.h"
#import "FLZenfolioApiHttpGetGetVideoPlaybackUrl.h"
#import "FLZenfolioApiHttpGetResolveReference.h"
#import "FLZenfolioApiHttpGetCreatePhotoFromUrl.h"
#import "FLZenfolioApiHttpGetCreateVideoFromUrl.h"
#import "FLZenfolioApiHttpPostAuthenticateVisitor.h"
#import "FLZenfolioApiHttpPostGetVisitorKey.h"
#import "FLZenfolioApiHttpPostAuthenticatePlain.h"
#import "FLZenfolioApiHttpPostGetChallenge.h"
#import "FLZenfolioApiHttpPostAuthenticate.h"
#import "FLZenfolioApiHttpPostLoadPrivateProfile.h"
#import "FLZenfolioApiHttpPostLoadPublicProfile.h"
#import "FLZenfolioApiHttpPostLoadGroupHierarchy.h"
#import "FLZenfolioApiHttpPostLoadGroup.h"
#import "FLZenfolioApiHttpPostLoadAccessRealm.h"
#import "FLZenfolioApiHttpPostLoadPhotoSet.h"
#import "FLZenfolioApiHttpPostLoadPhotoSetPhotos.h"
#import "FLZenfolioApiHttpPostLoadPhoto.h"
#import "FLZenfolioApiHttpPostKeyringAddKeyPlain.h"
#import "FLZenfolioApiHttpPostKeyringGetUnlockedRealms.h"
#import "FLZenfolioApiHttpPostGetDownloadOriginalKey.h"
#import "FLZenfolioApiHttpPostGetCategories.h"
#import "FLZenfolioApiHttpPostSearchSetByCategory.h"
#import "FLZenfolioApiHttpPostSearchSetByText.h"
#import "FLZenfolioApiHttpPostGetPopularSets.h"
#import "FLZenfolioApiHttpPostGetRecentSets.h"
#import "FLZenfolioApiHttpPostSearchPhotoByCategory.h"
#import "FLZenfolioApiHttpPostSearchPhotoByText.h"
#import "FLZenfolioApiHttpPostGetPopularPhotos.h"
#import "FLZenfolioApiHttpPostGetRecentPhotos.h"
#import "FLZenfolioApiHttpPostDeleteGroup.h"
#import "FLZenfolioApiHttpPostDeletePhotoSet.h"
#import "FLZenfolioApiHttpPostDeletePhoto.h"
#import "FLZenfolioApiHttpPostCollectionAddPhoto.h"
#import "FLZenfolioApiHttpPostCollectionRemovePhoto.h"
#import "FLZenfolioApiHttpPostReorderPhotoSet.h"
#import "FLZenfolioApiHttpPostReindexPhotoSet.h"
#import "FLZenfolioApiHttpPostMovePhoto.h"
#import "FLZenfolioApiHttpPostRotatePhoto.h"
#import "FLZenfolioApiHttpPostSetGroupTitlePhoto.h"
#import "FLZenfolioApiHttpPostSetPhotoSetTitlePhoto.h"
#import "FLZenfolioApiHttpPostSetPhotoSetFeaturedIndex.h"
#import "FLZenfolioApiHttpPostMovePhotoSet.h"
#import "FLZenfolioApiHttpPostReorderGroup.h"
#import "FLZenfolioApiHttpPostReplacePhoto.h"
#import "FLZenfolioApiHttpPostMoveGroup.h"
#import "FLZenfolioApiHttpPostLoadMessages.h"
#import "FLZenfolioApiHttpPostDeleteMessage.h"
#import "FLZenfolioApiHttpPostUndeleteMessage.h"
#import "FLZenfolioApiHttpPostGetVersion.h"
#import "FLZenfolioApiHttpPostCheckPrivilege.h"
#import "FLZenfolioApiHttpPostCreateFavoritesSet.h"
#import "FLZenfolioApiHttpPostShareFavoritesSet.h"
#import "FLZenfolioApiHttpPostLoadSharedFavoritesSets.h"
#import "FLZenfolioApiHttpPostGetVideoPlaybackUrl.h"
#import "FLZenfolioApiHttpPostResolveReference.h"
#import "FLZenfolioApiHttpPostCreatePhotoFromUrl.h"
#import "FLZenfolioApiHttpPostCreateVideoFromUrl.h"
