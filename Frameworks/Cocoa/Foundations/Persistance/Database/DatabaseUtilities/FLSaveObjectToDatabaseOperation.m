//
//	FLSaveObjectToDatabaseOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSaveObjectToDatabaseOperation.h"

@implementation FLSaveObjectToDatabaseOperation

- (id) initWithDatabaseObjectInput:(FLDatabase*) database 
							 input:(id) input {
	if((self = [self init])) {
		FLAssertIsNotNil(database);
		FLAssertIsNotNil(input);
        _input = FLRetain(input);
		_database = FLRetain(database);
	}
	return self;
} 

#if FL_MRC
- (void) dealloc {
    [_input release];
    [_database release];
    [super dealloc];
}
#endif


- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
	FLAssertIsNotNil(_database);
	FLAssertIsNotNil(_input);
	[_database writeObject:_input];
    return FLSuccessfullResult;
}

@end
