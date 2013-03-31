//
//  FLObjectStorageService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLObjectStorage.h"

@interface FLObjectStorageService : FLService<FLObjectStorage> {
@private
    id<FLServiceableObjectStorage> _objectStorage;
}

+ (FLObjectStorageService*) objectStorageService:(id<FLServiceableObjectStorage>) objectStorage;

@property (readonly, strong) id<FLObjectStorage> objectStorage;
@end

