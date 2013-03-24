//
//  FLDataStoreService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLObjectStorage.h"

@interface FLDataStoreService : FLService<FLObjectStorage> {
@private
    id<FLObjectStorage> _objectStorage;
}
@property (readwrite, strong) id<FLObjectStorage> dataStore;
@end

