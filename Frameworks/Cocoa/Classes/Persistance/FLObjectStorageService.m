//
//  FLObjectStorageService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectStorageService.h"


@interface FLObjectStorageService ()
@property (readwrite, strong) id<FLObjectStorage> objectStorage;
@end

@implementation FLObjectStorageService 

@synthesize objectStorage = _objectStorage;

+ (FLObjectStorageService*) objectStorageService:(id<FLServiceableObjectStorage>) objectStorage {
    FLObjectStorageService* service = FLAutorelease([[[self class] alloc] init]);
    service.objectStorage = objectStorage;
    return service;
}

#if FL_MRC
- (void) dealloc {
    [_objectStorage release];
    [super dealloc];
}
#endif

- (void) openService {
    [super openService];
    
    [((id)self.objectStorage) openStorage];
}

- (void) closeService {
    [super closeService];

    [((id)self.objectStorage) closeStorage];
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
