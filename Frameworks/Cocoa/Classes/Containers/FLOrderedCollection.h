//
//	FLOrderedCollection.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"

/// @brief this class is about quick access. uses a lot more memory. inserts/deletes a bit slower. 
@interface FLOrderedCollection : NSObject<NSCopying, NSMutableCopying, NSFastEnumeration> {
@private
	NSMutableDictionary* _objectDictionary;
	NSMutableDictionary* _indexes;
	NSMutableArray* _keys;
	NSMutableArray* _objectArray;
    unsigned long _mutatationCount;
}

- (id) initWithCapacity:(NSUInteger) capacity;

+ (FLOrderedCollection*) orderedCollection;
+ (FLOrderedCollection*) orderedCollectionWithCapacity:(NSUInteger) capacity;

@property (readonly, retain, nonatomic) NSArray* objectArray;
//@property (readonly, retain, nonatomic) NSDictionary* objectDictionary;
//@property (readonly, retain, nonatomic) NSArray* keys;
//@property (readonly, retain, nonatomic) NSMutableDictionary* indexes;

@property (readonly, assign, nonatomic) NSUInteger count;
//@property (readonly, copy, nonatomic) NSArray* objectArray;

// setting an object will add it to the end of the array if it's not already in collection

//- (void) addOrReplaceObject:(id) object forKey:(id) key;

- (void) setObject:(id) object forKey:(id) key;
- (id) objectForKey:(id) key;
- (id) objectAtIndex:(NSUInteger) idx;

- (void) removeObjectForKey:(id) key;
- (void) removeObjectAtIndex:(NSUInteger) idx;

- (void) removeObject:(id) object;

- (void) removeAllObjects;

- (id) replaceObjectAtIndex:(NSUInteger) atIndex withObject:(id) object forKey:(id) forKey;

- (NSUInteger) indexForKey:(id) key;

- (id) lastObject;
- (id) firstObject;

- (id<NSFastEnumeration>) forwardKeyEnumerator;
- (id<NSFastEnumeration>) forwardObjectEnumerator;

// TODO
//- (void)sortUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
//- (void)sortUsingSelector:(SEL)comparator;

@end
