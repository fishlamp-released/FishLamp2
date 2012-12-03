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
		FLAssertIsNotNil_(database);
		FLAssertIsNotNil_(input);
        _input = retain_(input);
		_database = retain_(database);
	}
	return self;
} 

- (FLResult) runSelf {
	FLAssertIsNotNil_(_input);
    FLAssertIsNotNil_(_database);
	return [_database loadObject:_input];
}

#if FL_MRC
- (void) dealloc {
    [_input release];
    [_database release];
    [super dealloc];
}
#endif


@end
