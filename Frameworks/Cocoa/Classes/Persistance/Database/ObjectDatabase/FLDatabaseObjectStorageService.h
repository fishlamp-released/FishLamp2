//
//  FLDatabaseObjectStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectStorageService.h"

#import "FLObjectDatabase.h"

@protocol FLDatabaseObjectStorageServiceDelegate;

@interface FLDatabaseObjectStorageService : FLObjectStorageService {
@private
    FLObjectDatabase* _database;
}

+ (id) databaseObjectStorageService:(id<FLDatabaseObjectStorageServiceDelegate>) delegate;

@end

@protocol FLDatabaseObjectStorageServiceDelegate <NSObject>
- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service; 
@end
