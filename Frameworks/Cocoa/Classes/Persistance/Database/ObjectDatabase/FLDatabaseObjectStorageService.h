//
//  FLDatabaseObjectStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStorageService.h"

#import "FLObjectDatabaseController.h"

@protocol FLDatabaseObjectStorageServiceDelegate;

@interface FLDatabaseObjectStorageService : FLStorageService {
@private
    FLObjectDatabaseController* _objectDatabase;
}
@property (readonly, strong, nonatomic) FLObjectDatabaseController* databaseController;

+ (id) databaseObjectStorageService:(id<FLDatabaseObjectStorageServiceDelegate>) delegate;

@end

@protocol FLDatabaseObjectStorageServiceDelegate <NSObject>
- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service; 
@end
