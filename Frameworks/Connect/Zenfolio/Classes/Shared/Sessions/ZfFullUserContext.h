//
//  ZFUserContext.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFUserContext.h"
#import "FLBackgroundTaskMgr.h"
#import "FLUserLoginService.h"
#import "FLFacebookService.h"
#import "FLTwitterService.h"
#import "FLBackgroundTaskMgr.h"
#import "FLUserDataStorageService.h"

#import "ZFUploadQueue.h"
#import "ZFHttpRequest.h"
#import "ZFSyncService.h"

#import "ZFCacheService.h"
#import "ZFStorageService.h"

#import "ZFPrefsService.h"
#import "ZFImageDownloadingService.h"
#import "ZFImageDisplaySize.h"

@interface ZFFullUserContext : ZFUserContext {
@private
    ZFImageDisplaySize* _imageDisplaySize;
    FLFacebookService* _facebookService;
    FLTwitterService* _twitterService;
    FLBackgroundTaskMgr* _backgroundTaskService;
    ZFSyncService* _syncService;
    ZFImageDownloadingService* _imageDownloader;
    ZFUploadQueue* _uploadQueue;
    FLUserDataStorageService* _userStorageService;
    ZFCacheService* _cacheService;
    ZFPrefsService* _prefsService;
}

@property (readonly, strong) FLFacebookService* facebookService; 
@property (readonly, strong) FLTwitterService* twitterService; 
@property (readonly, strong) FLBackgroundTaskMgr* backgroundTaskService;

@property (readonly, strong) ZFSyncService* syncService; 
@property (readonly, strong) ZFImageDownloadingService* imageDownloader;
@property (readonly, strong) ZFUploadQueue* uploadQueue;

@property (readonly, strong) FLUserDataStorageService* userStorageService;
@property (readonly, strong) ZFCacheService* cacheService;

@property (readonly, strong) ZFImageDisplaySize* imageDisplaySize;

@property (readonly, strong) ZFPrefsService* prefsService;
@end



