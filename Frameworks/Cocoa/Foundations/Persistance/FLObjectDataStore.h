//
//  FLObjectDataStore.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLObjectDataStore <NSObject>
- (void) writeObject:(id) object;
- (id) readObject:(id) inputObject;
- (void) deleteObject:(id) object;
- (BOOL) containsObject:(id) object;
@end

@protocol FLObjectDataStoreExtended <FLObjectDataStore>
- (NSUInteger) objectCountForClass:(Class) aClass;
- (void) removeAllObjectsWithClass:(Class) aClass;
- (NSArray*) readObjectsForClass:(Class) aClass;
@end