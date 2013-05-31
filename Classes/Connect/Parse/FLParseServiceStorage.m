//
//  FLParseServiceStorage.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 5/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParseServiceStorage.h"

@implementation FLParseServiceStorage

+ (id) parseServiceStorage:(id<FLDatabaseObjectStorageServiceDelegate>) delegate {
    return [super databaseObjectStorageService:delegate];
}


@end
