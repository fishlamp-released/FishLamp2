//
//  FLDictionaryObjectStorage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDictionaryObjectStorage.h"

@implementation FLDictionaryObjectStorage

- (id) init {	
	self = [super init];
	if(self) {
		_storage = [[NSMutableDictionary alloc] init];
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
    [_storage setObject:object forKey:[object objectStorageKey_fl]];
}

- (id) readObject:(id) inputObject {
    return [_storage objectForKey:[inputObject objectStorageKey_fl]];
}

- (void) deleteObject:(id) inputObject {
    [_storage removeObjectForKey:[inputObject objectStorageKey_fl]];
}

- (BOOL) containsObject:(id) inputObject {
    return [_storage objectForKey:[inputObject objectStorageKey_fl]] != nil;
}


@end
