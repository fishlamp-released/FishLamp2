//
//  FLZffLibraryMgr.m
//  FishLamp-iOS
//
//  Created by Fullerton Mike on 12/28/11.
//  Copyright (c) 2011 Zenfolio, Inc. All rights reserved.
//

//#import "FLZfenfolioLibraryMgr.h"
//
//#import "FLCachedImage.h"
//#import "FLZfenfolioUtils.h"
//#import "FLCachedImageCacheBehavior.h"
//#import "FLZfenfolioSyncState.h"
//#import "FLAction.h"
//#import "FLObjectCacheBehavior.h"
//#import "FLZfenfolioRegisteredUserOperationAuthenticator.h"
//#import "FLHttpImageDownloadNetworkResponseHandler.h"
//#import "FLAction.h"
//#import "FLReachableNetwork.h"
//#import "FLZfenfolioSoapHttpRequestFactory.h"
//#import "FLApplicationDataModel.h"
//#import "FLZfenfolioErrors.h"
//#import "FLUserLogin+FLZfAdditions.h"
//
//#if IOS
//#import "UIDevice+FLExtras.h"
//#endif

#if MOVE_TO_MYZEN_APP
FIXME("Move this to myZen iOS app");

@implementation FLZfUser (Cache)
FLSynthesizeCachedObjectHandlerProperty(FLZfUser);
@end

@implementation FLZfPhoto (Cache)
FLSynthesizeCachedObjectHandlerProperty(FLZfPhoto);
@end

@implementation FLZfSyncState (Cache)
FLSynthesizeCachedObjectHandlerProperty(FLZfSyncState);
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
	[FLZfGroup setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:5 cacheKey:[FLZfGroup IdKey]]];
	[FLZfPhotoSet setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:5 cacheKey:[FLZfPhotoSet IdKey]]];
	[FLZfUser setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:1 cacheKey:[FLZfUser LoginNameKey]]];
	[FLZfPhoto setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:10 cacheKey:[FLZfPhoto IdKey]]];
	[FLZfSyncState setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:25 cacheKey:[FLZfSyncState syncObjectIdKey]]];
	[FLZfCachedCategories setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:1 cacheKey:[FLZfCachedCategories arrayIdKey]]];

#if DEBUG
	[FLZfSyncState sharedCacheBehavior].warnOnMainThreadLoad = NO;
	[FLZfSyncState sharedCacheBehavior].warnOnMainThreadWrite = NO;
	[FLZfSyncState sharedCacheBehavior].warnOnMainThreadDelete = NO;
#endif	  

// set up zf stuff	
	[FLZfPhotoInfo setPhotoSizes];
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

    FLZfPreferences* prefs = [FLZfPreferences loadPreferences];
    prefs.hasScrapbookPrivilegeValue = [userLogin isPrivilegeEnabled:FLZfScrapbookPrivilege];
    prefs.didCheckScrapbookPrivilegeValue = YES;
    [prefs savePreferences];
}
#endif


