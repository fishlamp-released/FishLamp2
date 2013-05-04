//
//  FLDatabaseObjectStorage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDatabaseObjectStorageService.h"

@interface FLDatabaseObjectStorageService ()
@property (readwrite, strong, nonatomic) FLObjectDatabaseController* databaseController;
@end

@implementation FLDatabaseObjectStorageService
@synthesize databaseController = _databaseController;

+ (id) databaseObjectStorageService:(id<FLDatabaseObjectStorageServiceDelegate>) delegate {
    return FLAutorelease([[[self class] alloc] initWithDelegate:delegate]);
}

- (id<FLObjectStorage>) objectStorage {
    return self.databaseController;
}

#if FL_MRC
- (void) dealloc {
    [_databaseController release];
    [super dealloc];
}
#endif

- (void) openService {
    NSString* databasePath = [self.delegate databaseObjectStorageServiceGetDatabasePath:self];
    self.databaseController = [FLObjectDatabaseController  objectDatabaseController:databasePath];
    
    [self.databaseController dispatchAsync:^(FLObjectDatabase* database) {
        [database openDatabase];
    }
    completion:^(FLPromisedResult result) {
        if([result error]) {
            FLLog(@"database error: %@", result)
        }
    }];
    

    
}

- (void) closeService {
    [self.databaseController dispatchAsync:^(FLObjectDatabase* database) {
        [database openDatabase];
    }
    completion:^(FLPromisedResult result) {
        if([result error]) {
            FLLog(@"database error: %@", result)
        }
    }];
}


@end
