//
//  FLStorageService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStorageService.h"


@interface FLStorageService ()
@end

@implementation FLStorageService 

- (id<FLObjectStorage>) objectStorage {
    return nil;
}

- (id<FLBlobStorage>) blobStorage {
    return nil;
}

- (void) writeObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    [self.objectStorage writeObject:object];
}

- (id) readObject:(id) inputObject {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    return [self.objectStorage readObject:inputObject];
}

- (void) deleteObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    [self.objectStorage deleteObject:object];
}

- (BOOL) containsObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    return [self.objectStorage containsObject:object];
}



@end
