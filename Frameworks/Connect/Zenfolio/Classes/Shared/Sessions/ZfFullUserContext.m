//
//  ZFUserContext.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFFullUserContext.h"
#import "ZFSoapHttpRequestFactory.h"

@interface ZFFullUserContext ()
@property (readwrite, strong) FLFacebookService* facebookService; 
@property (readwrite, strong) FLTwitterService* twitterService; 
@property (readwrite, strong) FLBackgroundTaskMgr* backgroundTaskService;
@property (readwrite, strong) ZFSyncService* syncService; 
@property (readwrite, strong) ZFImageDownloadingService* imageDownloader;
@property (readwrite, strong) ZFUploadQueue* uploadQueue;
@property (readwrite, strong) FLUserDataStorageService* userStorageService;
@property (readwrite, strong) ZFCacheService* cacheService;
@property (readwrite, strong) ZFImageDisplaySize* imageDisplaySize;
@property (readwrite, strong) ZFPrefsService* prefsService;
@end

@implementation ZFFullUserContext


@synthesize imageDisplaySize = _imageDisplaySize;

@synthesize facebookService = _facebookService;
@synthesize twitterService = _twitterService;
@synthesize backgroundTaskService = _backgroundTaskService;
@synthesize syncService = _syncService;
@synthesize imageDownloader = _imageDownloader;
@synthesize uploadQueue = _uploadQueue;
@synthesize userStorageService = _userStorageService;
@synthesize cacheService = _cacheService;
@synthesize prefsService = _prefsService;

#if FL_MRC
- (void) dealloc {
    [_facebookService release];
    [_twitterService release];
    [_syncService release];
    [_imageDownloader release];
    [_uploadQueue release];
    [_cacheService release];
    [_backgroundTaskService release];
    [_imageDisplaySize release];
    [super dealloc];
}
#endif
        
        
- (id) init {
    self = [super init];
    if(self) {
    
        self.facebookService = [FLFacebookService facebookService];
        self.twitterService = [FLTwitterService twitterService];
        self.syncService = [ZFSyncService syncService];
        self.imageDownloader = [ZFImageDownloadingService imageDownloadingService];
        self.uploadQueue = [ZFUploadQueue uploadQueue];
        self.cacheService = [ZFCacheService cacheService];
        self.userStorageService = [FLUserDataStorageService userDataStorageService];
        self.backgroundTaskService = [FLBackgroundTaskMgr backgroundTaskMgr];
        self.prefsService = [ZFPrefsService prefsService];
    
        [self registerService:@selector(facebookService)];
        [self registerService:@selector(twitterService)];
        [self registerService:@selector(syncService)];
        [self registerService:@selector(imageDownloader)];
        [self registerService:@selector(uploadQueue)];
        [self registerService:@selector(cacheService)];
        [self registerService:@selector(userStorageService)];
        [self registerService:@selector(backgroundTaskService)];
        [self registerService:@selector(prefsService)];
    }
    return self;
}



@end

/*
my Zen
@synthesize backgroundTasks = _backgroundTasks;
@property (readwrite, strong) FLBackgroundTaskMgr* backgroundTasks;
    FLBackgroundTaskMgr* _backgroundTasks;

        _backgroundTasks = [[FLBackgroundTaskMgr alloc] init];
        [self addService:_backgroundTasks];

    [_backgroundTasks release];

*/
