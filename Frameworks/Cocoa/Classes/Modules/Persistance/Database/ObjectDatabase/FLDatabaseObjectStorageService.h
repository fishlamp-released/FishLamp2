//
//  FLDatabaseObjectStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/1/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStorageService.h"

#import "FLObjectDatabaseController.h"

@protocol FLDatabaseObjectStorageServiceDelegate;

@interface FLDatabaseObjectStorageService : FLStorageService {
@private
    FLObjectDatabaseController* _databaseController;
    __unsafe_unretained id<FLDatabaseObjectStorageServiceDelegate> _delegate;
}
@property (readwrite, assign, nonatomic) id<FLDatabaseObjectStorageServiceDelegate> delegate;
@property (readonly, strong, nonatomic) FLObjectDatabaseController* databaseController;

+ (id) databaseObjectStorageService:(id<FLDatabaseObjectStorageServiceDelegate>) delegate;

- (NSString*) databaseFilePath;

@end

@protocol FLDatabaseObjectStorageServiceDelegate <NSObject>
- (NSString*) databaseObjectStorageServiceGetDatabasePath:(FLDatabaseObjectStorageService*) service; 
@end
