//
//  FLUserDataStorageService.h
//  FLCore
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLDatabase.h"
#import "FLFolder.h"
#import "FLLengthyTask.h"
#import "FLLengthyTaskList.h"
#import "FLVersionUpgradeLengthyTaskList.h"
#import "FLImageFolder.h"


@interface FLUserDataStorageService : FLService {
@private

// cache
	FLFolder* _cacheFolder;
	FLImageFolder* _imageCacheFolder;
	FLFolder* _tempFolder;
	FLFolder* _logFolder;
	FLDatabase* _cacheDatabase;

// documents
	FLFolder* _documentsFolder;
	FLDatabase* _documentsDatabase;
	FLImageFolder* _imageFolder;

	FLVersionUpgradeLengthyTaskList* _upgradeTaskList;
    BOOL _willOpen;
    BOOL _isOpening;
    BOOL _open;
    BOOL _upgrading;
}

// cache
@property (readonly, strong) FLFolder* cacheFolder;
@property (readonly, strong) FLDatabase* cacheDatabase;
@property (readonly, strong) FLImageFolder* imageCacheFolder;
@property (readonly, strong) FLFolder* tempFolder;
@property (readonly, strong) FLFolder* logFolder;

// app data
@property (readonly, strong) FLDatabase* documentsDatabase;
@property (readonly, strong) FLFolder* documentsFolder;
@property (readonly, strong) FLImageFolder* imageFolder;

+ (id) userDataStorageService;

@end

@interface FLUserDataStorageService (PlatformSpecific)
+ (id) createVersionUpgradeProgressViewController;
+ (id) createUserLoggingOutProgressViewController;
@end

@protocol FLUserDataServiceObserver <NSObject>

- (void) userDataService:(FLUserDataStorageService*) userDataService
    appVersionWillChange:(FLVersionUpgradeLengthyTaskList*) taskListToAddTo;

@end

@protocol FLUserContextResponder <NSObject>
- (void) userContextDidOpen:(FLUserDataStorageService*) service;
- (void) userContextDidClose:(FLUserDataStorageService*) service;
@end

FLPublishService(userStorageService, FLUserDataStorageService*)

//@interface FLServiceManagingContext (FLUserDataStorageService) 
//@property (readwrite, strong) FLUserDataStorageService* storageService;
//@property (readonly, strong) FLFolder* cacheFolder;
//@property (readonly, strong) FLDatabase* cacheDatabase;
//@property (readonly, strong) FLImageFolder* imageCacheFolder;
//@property (readonly, strong) FLFolder* tempFolder;
//@property (readonly, strong) FLFolder* logFolder;
//@property (readonly, strong) FLDatabase* documentsDatabase;
//@property (readonly, strong) FLFolder* documentsFolder;
//@property (readonly, strong) FLImageFolder* imageFolder;
//@end
