//
//  FLDatabaseObjectStorage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/1/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

- (NSString*) databaseFilePath {
    return [self.delegate databaseObjectStorageServiceGetDatabasePath:self];
}

- (void) openService {
    NSString* databasePath = [self databaseFilePath];
    FLAssertStringIsNotEmpty(databasePath);
    
    self.databaseController = [FLObjectDatabaseController  objectDatabaseController:databasePath];
    
    [self.databaseController dispatchAsync:^(FLObjectDatabase* database) {
        [database openDatabase];
    }
    completion:^(id result, NSError* error) {
        if([result error]) {
            FLLog(@"database error: %@", result)
        }
    }];
 }

- (void) closeService {
    [self.databaseController dispatchAsync:^(FLObjectDatabase* database) {
        [database openDatabase];
    }
    completion:^(id result, NSError* error) {
        if([result error]) {
            FLLog(@"database error: %@", result)
        }
    }];
}


@end
