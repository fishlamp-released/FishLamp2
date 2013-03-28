//
//  FLObjectStorageService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectStorageService.h"


@interface FLObjectStorageService ()
@end

@implementation FLObjectStorageService 
@synthesize objectStorage = _objectStorage;

#if FL_MRC
- (void) dealloc {
    [_objectStorage release];
    [super dealloc];
}
#endif

//- (void) openService {
//    [super openService];
//    
//    [self.objectStorage openStorage];
//}
//
//- (void) closeService {
//    [super closeService];
//
//    [self.objectStorage closeStorage];
//}

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
