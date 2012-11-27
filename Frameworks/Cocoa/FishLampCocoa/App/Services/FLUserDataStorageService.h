//
//  FLUserDataStorageService.h
//  FishLampCore
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

@protocol FLUserDataStorageService <FLService>
// caching
@property (readonly, strong) FLDatabase* cacheDatabase;
@property (readonly, strong) FLDatabase* documentsDatabase;

// folders
@property (readonly, strong) FLFolder* documentsFolder;
@property (readonly, strong) FLFolder* cacheFolder;
@property (readonly, strong) FLFolder* photoFolder;
@property (readonly, strong) FLFolder* photoCacheFolder;
@property (readonly, strong) FLFolder* tempFolder;
@property (readonly, strong) FLFolder* logFolder;
@end

@interface FLUserDataStorageService : FLService<FLUserDataStorageService> {
@private
	FLDatabase* _cacheDatabase;
	FLDatabase* _documentsDatabase;
	FLFolder* _documentsFolder;
	FLFolder* _cacheFolder;
	FLFolder* _photoFolder;
	FLFolder* _photoCacheFolder;
	FLFolder* _tempFolder;
	FLFolder* _logFolder;
	FLVersionUpgradeLengthyTaskList* _upgradeTaskList;
    BOOL _willOpen;
    BOOL _isOpening;
    BOOL _open;
    BOOL _upgrading;
}

+ (id) userDataStorageService;

@end

@interface FLUserDataStorageService (PlatformSpecific)
+ (id) createVersionUpgradeProgressViewController;
+ (id) createUserLoggingOutProgressViewController;
@end

@protocol FLUserDataServiceObserver <FLObserver>
@optional
- (void) userDataService:(FLUserDataStorageService*) userDataService
    appVersionWillChange:(FLVersionUpgradeLengthyTaskList*) taskListToAddTo;

@end

service_declare_(storage, FLUserDataStorageService);
