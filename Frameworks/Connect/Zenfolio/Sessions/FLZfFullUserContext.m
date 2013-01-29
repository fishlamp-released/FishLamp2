//
//  FLZfUserContext.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfFullUserContext.h"
#import "FLZfSoapHttpRequestFactory.h"

@interface FLZfFullUserContext ()
@property (readwrite, strong) FLFacebookService* facebookService; 
@property (readwrite, strong) FLTwitterService* twitterService; 
@property (readwrite, strong) FLBackgroundTaskMgr* backgroundTaskService;
@property (readwrite, strong) FLZfSyncService* syncService; 
@property (readwrite, strong) FLZfImageDownloadingService* imageDownloader;
@property (readwrite, strong) FLZfUploadQueue* uploadQueue;
@property (readwrite, strong) FLUserDataStorageService* userStorageService;
@property (readwrite, strong) FLZfCacheService* cacheService;
@property (readwrite, strong) FLZfImageDisplaySize* imageDisplaySize;
@property (readwrite, strong) FLZfPrefsService* prefsService;
@end

@implementation FLZfFullUserContext


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
        self.syncService = [FLZfSyncService syncService];
        self.imageDownloader = [FLZfImageDownloadingService imageDownloadingService];
        self.uploadQueue = [FLZfUploadQueue uploadQueue];
        self.cacheService = [FLZfCacheService cacheService];
        self.userStorageService = [FLUserDataStorageService userDataStorageService];
        self.backgroundTaskService = [FLBackgroundTaskMgr backgroundTaskMgr];
        self.prefsService = [FLZfPrefsService prefsService];
    
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
