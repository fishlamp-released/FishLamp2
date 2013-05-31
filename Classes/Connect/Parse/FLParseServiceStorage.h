//
//  FLParseServiceStorage.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 5/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDatabaseObjectStorageService.h"

@interface FLParseServiceStorage : FLDatabaseObjectStorageService
+ (id) parseServiceStorage:(id<FLDatabaseObjectStorageServiceDelegate>) delegate;

@end
