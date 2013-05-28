//
//  FLObjcNamedObjectCollection.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"

@class FLObjcName;

@interface FLObjcNamedObjectCollection : NSObject<NSFastEnumeration> {
@private
    NSMutableDictionary* _names;
    NSMutableDictionary* _generatedStrings;
}
+ (id) objcNamedObjectCollection;

- (id) objectForKey:(NSString*) name;
- (void) setObject:(id) object forKey:(FLObjcName*) key;

- (NSEnumerator *)objectEnumerator;
- (NSArray *)allKeys;
- (NSArray *)allValues;

@end
