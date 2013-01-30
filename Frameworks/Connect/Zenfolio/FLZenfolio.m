//
//  FLZenfoliofLibraryMgr.m
//  FishLamp-iOS
//
//  Created by Fullerton Mike on 12/28/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

//#import "FLZenfolioenfolioLibraryMgr.h"
//
//#import "FLCachedImage.h"
//#import "FLZenfolioenfolioUtils.h"
//#import "FLCachedImageCacheBehavior.h"
//#import "FLZenfolioenfolioSyncState.h"
//#import "FLAction.h"
//#import "FLObjectCacheBehavior.h"
//#import "FLZenfolioenfolioRegisteredUserOperationAuthenticator.h"
//#import "FLHttpImageDownloadNetworkResponseHandler.h"
//#import "FLAction.h"
//#import "FLReachableNetwork.h"
//#import "FLZenfolioenfolioSoapHttpRequestFactory.h"
//#import "FLApplicationDataModel.h"
//#import "FLZenfolioenfolioErrors.h"
//#import "FLUserLogin+ZenfolioAdditions.h"
//
//#if IOS
//#import "UIDevice+FLExtras.h"
//#endif

#if MOVE_TO_MYZEN_APP
FIXME("Move this to myZen iOS app");

@implementation FLZenfolioUser (Cache)
FLSynthesizeCachedObjectHandlerProperty(FLZenfolioUser);
@end

@implementation FLZenfolioPhoto (Cache)
FLSynthesizeCachedObjectHandlerProperty(FLZenfolioPhoto);
@end

@implementation FLZenfolioSyncState (Cache)
FLSynthesizeCachedObjectHandlerProperty(FLZenfolioSyncState);
@end

- (void) handleActionFailed:(FLAction*) action
{
	NSError* error = [action error];
	
	if( (FLStringsAreEqual([FLFrameworkErrorDomain instance], error.domain) && error.code == FLAuthenticationErrorPasswordIncorrect) ||
        error.zenfolioErrorCode == errAccountLocked) {
        [[FLUserLoginService instance] beginLoggingOutUser:nil];
	}
	else if(FLStringsAreEqual(NSURLErrorDomain, error.domain) && 
			error.code == NSURLErrorNotConnectedToInternet) {
		action.handledError = !action.networkRequired;
    }
}

- (void) initializeLibary
{
// init stuff in fishlamp
#if IOS
	[FLCachedImage setSharedCacheBehavior:[FLCachedImageCacheBehavior cachedImageCacheBehavior:([UIDevice currentDevice].isAtLeastIPhone4 || DeviceIsPad()) ? 128 : 64]];
#else
	[FLCachedImage setSharedCacheBehavior:[FLCachedImageCacheBehavior cachedImageCacheBehavior:512]];
#endif

	[[FLReachableNetwork instance] startMonitoring];
	
// setup cache behaviors	
	[FLZenfolioGroup setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:5 cacheKey:[FLZenfolioGroup IdKey]]];
	[FLZenfolioPhotoSet setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:5 cacheKey:[FLZenfolioPhotoSet IdKey]]];
	[FLZenfolioUser setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:1 cacheKey:[FLZenfolioUser LoginNameKey]]];
	[FLZenfolioPhoto setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:10 cacheKey:[FLZenfolioPhoto IdKey]]];
	[FLZenfolioSyncState setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:25 cacheKey:[FLZenfolioSyncState syncObjectIdKey]]];
	[FLZenfolioCachedCategories setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:1 cacheKey:[FLZenfolioCachedCategories arrayIdKey]]];

#if DEBUG
	[FLZenfolioSyncState sharedCacheBehavior].warnOnMainThreadLoad = NO;
	[FLZenfolioSyncState sharedCacheBehavior].warnOnMainThreadWrite = NO;
	[FLZenfolioSyncState sharedCacheBehavior].warnOnMainThreadDelete = NO;
#endif	  

// set up Zenfolio stuff	
	[FLZenfolioPhotoInfo setPhotoSizes];
	[FLAction setGlobalFailedCallback:self action:@selector(handleActionFailed:)];

// setup user session
	
//	[FLObsoleteUserLogin convertIfNeeded];
}




- (FLUserLogin*) userLogin {
    return [FLUserLoginService instance].userLogin;
}

- (void) setUserLogin:(FLUserLogin*) userLogin {
    [[FLApplicationDataModel instance] saveUserLogin:userLogin];
    [[FLUserLoginService instance].documentsDatabase saveObject:userLogin];

    FLZenfolioPreferences* prefs = [FLZenfolioPreferences loadPreferences];
    prefs.hasScrapbookPrivilegeValue = [userLogin isPrivilegeEnabled:FLZenfolioScrapbookPrivilege];
    prefs.didCheckScrapbookPrivilegeValue = YES;
    [prefs savePreferences];
}
#endif


