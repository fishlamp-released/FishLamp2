//
//  FLDataStoreService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDataStoreService.h"


@interface FLDataStoreService ()
@end

@implementation FLDataStoreService 
@synthesize dataStore = _objectStorage;

#if FL_MRC
- (void) dealloc {
    [_objectStorage release];
    [super dealloc];
}
#endif

- (void) closeService:(id) closer {
    self.dataStore = nil;
}

- (void) writeObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.dataStore);
    [self.dataStore writeObject:object];
}

- (id) readObject:(id) inputObject {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.dataStore);
    return [self.dataStore readObject:inputObject];
}

- (void) deleteObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.dataStore);
    [self.dataStore deleteObject:object];
}

- (BOOL) containsObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.dataStore);
    return [self.dataStore containsObject:object];
}


@end
