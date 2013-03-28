//
//  FLDictionaryObjectStorage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDictionaryObjectStorage.h"

@interface FLDictionaryObjectStorage ()
@property (readwrite, strong) NSMutableDictionary* storage;
@end

@implementation FLDictionaryObjectStorage
@synthesize storage = _storage;

- (id) init {	
	self = [super init];
	if(self) {
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_storage release];
	[super dealloc];
}
#endif

+ (id) dictionaryObjectStorage {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) writeObject:(id) object {
    [self.storage setObject:object forKey:[object objectStorageKey_fl]];
}

- (id) readObject:(id) inputObject {
    return [self.storage objectForKey:[inputObject objectStorageKey_fl]];
}

- (void) deleteObject:(id) inputObject {
    [self.storage removeObjectForKey:[inputObject objectStorageKey_fl]];
}

- (BOOL) containsObject:(id) inputObject {
    return [self.storage objectForKey:[inputObject objectStorageKey_fl]] != nil;
}

- (void) openStorage {
	self.storage = [NSMutableDictionary dictionary];
}

- (void) closeStorage { 
    self.storage = nil;
}


@end
