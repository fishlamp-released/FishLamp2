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
		self.input = input;
		FLAssertIsNotNil_(database);
		FLAssertIsNotNil_(input);
		_database = retain_(database);
	}
	return self;
} 

#if FL_MRC
- (void) dealloc {
	release_(_database);
	super_dealloc_();
}
#endif

- (void) runSelf {
	FLAssertIsNotNil_(_database);
	[_database saveObject:[self input]];

}

@end
