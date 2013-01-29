//
//  ZFLibraryMgr.m
//  ZenLib-iOS
//
//  Created by Fullerton Mike on 12/28/11.
//  Copyright (c) 2011 Zenfolio, Inc. All rights reserved.
//

//#import "ZFLibraryMgr.h"
//
//#import "FLCachedImage.h"
//#import "ZFUtils.h"
//#import "FLCachedImageCacheBehavior.h"
//#import "ZFSyncState.h"
//#import "FLAction.h"
//#import "FLObjectCacheBehavior.h"
//#import "ZFRegisteredUserOperationAuthenticator.h"
//#import "FLHttpImageDownloadNetworkResponseHandler.h"
//#import "FLAction.h"
//#import "FLReachableNetwork.h"
//#import "ZFSoapHttpRequestFactory.h"
//#import "FLApplicationDataModel.h"
//#import "ZFErrors.h"
//#import "FLUserLogin+ZFAdditions.h"
//
//#if IOS
//#import "UIDevice+FLExtras.h"
//#endif

#if MOVE_TO_MYZEN_APP
FIXME("Move this to myZen iOS app");

@implementation ZFUser (Cache)
FLSynthesizeCachedObjectHandlerProperty(ZFUser);
@end

@implementation ZFPhoto (Cache)
FLSynthesizeCachedObjectHandlerProperty(ZFPhoto);
@end

@implementation ZFSyncState (Cache)
FLSynthesizeCachedObjectHandlerProperty(ZFSyncState);
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
	[ZFGroup setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:5 cacheKey:[ZFGroup IdKey]]];
	[ZFPhotoSet setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:5 cacheKey:[ZFPhotoSet IdKey]]];
	[ZFUser setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:1 cacheKey:[ZFUser LoginNameKey]]];
	[ZFPhoto setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:10 cacheKey:[ZFPhoto IdKey]]];
	[ZFSyncState setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:25 cacheKey:[ZFSyncState syncObjectIdKey]]];
	[ZFCachedCategories setSharedCacheBehavior:[FLObjectCacheBehavior objectCacheBehavior:1 cacheKey:[ZFCachedCategories arrayIdKey]]];

#if DEBUG
	[ZFSyncState sharedCacheBehavior].warnOnMainThreadLoad = NO;
	[ZFSyncState sharedCacheBehavior].warnOnMainThreadWrite = NO;
	[ZFSyncState sharedCacheBehavior].warnOnMainThreadDelete = NO;
#endif	  

// set up zf stuff	
	[ZFPhotoInfo setPhotoSizes];
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

    ZFPreferences* prefs = [ZFPreferences loadPreferences];
    prefs.hasScrapbookPrivilegeValue = [userLogin isPrivilegeEnabled:ZFScrapbookPrivilege];
    prefs.didCheckScrapbookPrivilegeValue = YES;
    [prefs savePreferences];
}
#endif


