//
//  FLDataStoreWithCacheService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDataStoreService.h"

@interface FLDataStoreWithCacheService : FLDataStoreService {
@private
    id<FLObjectStorage> _cache;
}
@property (readwrite, strong) id<FLObjectStorage> cache;
@end
