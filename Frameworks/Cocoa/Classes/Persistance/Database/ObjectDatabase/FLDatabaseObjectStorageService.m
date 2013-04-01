//
//  FLDatabaseObjectStorage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDatabaseObjectStorageService.h"

@interface FLDatabaseObjectStorageService ()
@property (readwrite, strong, nonatomic) FLObjectDatabase* objectStorage;
@end

@implementation FLDatabaseObjectStorageService
@synthesize objectStorage = _objectStorage;

+ (id) databaseObjectStorageService:(id<FLDatabaseObjectStorageServiceDelegate>) delegate {
    return FLAutorelease([[[self class] alloc] initWithDelegate:delegate]);
}

#if FL_MRC
- (void) dealloc {
    [_objectStorage release];
    [super dealloc];
}
#endif

- (void) openService {
    NSString* databasePath = [self.delegate databaseObjectStorageServiceGetDatabasePath:self];
    FLObjectDatabase* database = [[FLObjectDatabase alloc] initWithFilePath:databasePath];
    BOOL needsUpgrade = [database openDatabase];
    if(needsUpgrade) {
        // doh.
    }
    
    self.objectStorage = database;
}

- (void) closeService {
    [self.objectStorage closeDatabase];
}


@end
