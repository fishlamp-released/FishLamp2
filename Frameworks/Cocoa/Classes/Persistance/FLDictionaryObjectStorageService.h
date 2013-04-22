//
//  FLDictionaryObjectStorageService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectStorage.h"
#import "FLStorageService.h"

@interface FLDictionaryObjectStorageService : FLStorageService {
@private
    NSMutableDictionary* _objectStorage;
}

+ (id) dictionaryObjectStorageService;
@end
