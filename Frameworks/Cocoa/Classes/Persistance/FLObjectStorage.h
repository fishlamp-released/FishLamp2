//
//  FLObjectStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLObjectStorage <NSObject>
- (void) writeObject:(id) object;
- (void) writeObjectsInArray:(NSArray*) array; 

- (id) readObject:(id) inputObject;
- (void) deleteObject:(id) object;
- (BOOL) containsObject:(id) object;
@end

@protocol FLObjectStorageExtended <FLObjectStorage>
- (NSUInteger) objectCountForClass:(Class) aClass;
- (void) deleteAllObjectsForClass:(Class) aClass;
- (NSArray*) readAllObjectsForClass:(Class) aClass;
@end

@interface NSObject (FLObjectStorage)

- (id) objectStorageKey_fl;

@end