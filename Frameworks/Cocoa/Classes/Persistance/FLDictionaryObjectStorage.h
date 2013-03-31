//
//  FLDictionaryObjectStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectStorage.h"

@interface FLDictionaryObjectStorage : NSObject<FLServiceableObjectStorage> {
@private
    NSMutableDictionary* _storage;
}

+ (id) dictionaryObjectStorage;
@end
