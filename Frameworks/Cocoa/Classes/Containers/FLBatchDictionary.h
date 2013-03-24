//
//  FLArrayDictionary.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLBatchDictionary : NSObject<NSFastEnumeration, NSCopying, NSMutableCopying, NSCoding> {
@private
    NSMutableDictionary* _sets;
}

+ (id) batchDictionary;

// TODO: add more API to mirror NSDictionary

- (NSSet*) objectsForKey:(id) key;


@end

@interface FLMutableBatchDictionary : FLBatchDictionary {
}

- (void) addObject:(id) object forKey:(id) key;

- (void) removeObject:(id) object forKey:(id) key;
- (void) removeObject:(id) object;
- (void) removeAllObjectsForKey:(id) key;
- (void) removeAllObjects;

@end


