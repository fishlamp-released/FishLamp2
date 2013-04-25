//
//	FLLoadObjectFromDatabaseOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLLoadObjectFromDatabaseOperation.h"

@implementation FLLoadObjectFromDatabaseOperation

- (id) initWithCacheableObjectInput:(FLDatabase*) database 
							  input:(id) input {
	self = [self init];
    if(self) {
		FLAssertIsNotNil(database);
		FLAssertIsNotNil(input);
        _input = FLRetain(input);
		_database = FLRetain(database);
	}
	return self;
} 

- (id) performSynchronously {
	FLAssertIsNotNil(_input);
    FLAssertIsNotNil(_database);
	return [_database readObject:_input];
}

#if FL_MRC
- (void) dealloc {
    [_input release];
    [_database release];
    [super dealloc];
}
#endif


@end
