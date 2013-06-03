//
//  FLDataStoreWithCacheService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStorageService.h"

@interface FLDataStoreWithCacheService : FLStorageService {
@private
    id<FLObjectStorage> _cache;
}
@property (readwrite, strong) id<FLObjectStorage> cache;
@end

