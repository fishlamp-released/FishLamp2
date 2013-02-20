//
//  FLDataStoreService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLObjectDataStore.h"

@interface FLDataStoreService : FLService<FLObjectDataStore> {
@private
    id<FLObjectDataStore> _dataStore;
}
@property (readwrite, strong) id<FLObjectDataStore> dataStore;
@end

