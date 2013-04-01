//
//  FLDictionaryObjectStorageService.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDictionaryObjectStorageService.h"

@interface FLDictionaryObjectStorageService ()
@property (readwrite, strong) NSMutableDictionary* objectStorage;
@end

@implementation FLDictionaryObjectStorageService
@synthesize objectStorage = _objectStorage;

- (id) init {	
	self = [super init];
	if(self) {
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_objectStorage release];
	[super dealloc];
}
#endif

+ (id) dictionaryObjectStorageService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) writeObject:(id) object {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    [self.objectStorage setObject:object forKey:[object objectStorageKey_fl]];
}

- (id) readObject:(id) inputObject {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    return [self.objectStorage objectForKey:[inputObject objectStorageKey_fl]];
}

- (void) deleteObject:(id) inputObject {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    [self.objectStorage removeObjectForKey:[inputObject objectStorageKey_fl]];
}

- (BOOL) containsObject:(id) inputObject {
    FLAssert(self.isServiceOpen);
    FLAssertNotNil(self.objectStorage);
    return [self.objectStorage objectForKey:[inputObject objectStorageKey_fl]] != nil;
}

- (void) openService {
    [super openService];
	self.objectStorage = [NSMutableDictionary dictionary];
}

- (void) closeService {
    [super closeService];
    self.objectStorage = nil;
}

@end
