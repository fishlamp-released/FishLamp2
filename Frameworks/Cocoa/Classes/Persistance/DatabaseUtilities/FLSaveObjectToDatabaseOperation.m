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
		FLAssertIsNotNil_(database);
		FLAssertIsNotNil_(input);
        _input = retain_(input);
		_database = retain_(database);
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


- (FLResult) runSelf {
	FLAssertIsNotNil_(_database);
	FLAssertIsNotNil_(_input);
	[_database saveObject:_input];
    return FLSuccessfullResult;
}

@end
