//
//  FLZfUserContext.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfUserContext.h"
#import "FLBackgroundTaskMgr.h"
#import "FLUserLoginService.h"
#import "FLFacebookService.h"
#import "FLTwitterService.h"
#import "FLBackgroundTaskMgr.h"
#import "FLUserDataStorageService.h"

#import "FLZfUploadQueue.h"
#import "FLZfHttpRequest.h"
#import "FLZfSyncService.h"

#import "FLZfCacheService.h"
#import "FLZfStorageService.h"

#import "FLZfPrefsService.h"
#import "FLZfImageDownloadingService.h"
#import "FLZfImageDisplaySize.h"

@interface FLZfFullUserContext : FLZfUserContext {
@private
    FLZfImageDisplaySize* _imageDisplaySize;
    FLFacebookService* _facebookService;
    FLTwitterService* _twitterService;
    FLBackgroundTaskMgr* _backgroundTaskService;
    FLZfSyncService* _syncService;
    FLZfImageDownloadingService* _imageDownloader;
    FLZfUploadQueue* _uploadQueue;
    FLUserDataStorageService* _userStorageService;
    FLZfCacheService* _cacheService;
    FLZfPrefsService* _prefsService;
}

@property (readonly, strong) FLFacebookService* facebookService; 
@property (readonly, strong) FLTwitterService* twitterService; 
@property (readonly, strong) FLBackgroundTaskMgr* backgroundTaskService;

@property (readonly, strong) FLZfSyncService* syncService; 
@property (readonly, strong) FLZfImageDownloadingService* imageDownloader;
@property (readonly, strong) FLZfUploadQueue* uploadQueue;

@property (readonly, strong) FLUserDataStorageService* userStorageService;
@property (readonly, strong) FLZfCacheService* cacheService;

@property (readonly, strong) FLZfImageDisplaySize* imageDisplaySize;

@property (readonly, strong) FLZfPrefsService* prefsService;
@end



