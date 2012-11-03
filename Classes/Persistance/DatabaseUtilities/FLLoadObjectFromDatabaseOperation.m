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
							  input:(id) input
{
	if((self = [self init]))
	{
		FLAssertIsNotNil_(database);
		FLAssertIsNotNil_(input);
		self.input = input;
		_database = retain_(database);
	}
	return self;
} 

- (void) runSelf {
	FLAssertIsNotNil_(_database);
	id outputObject = nil;
	@try {
		[_database loadObject:[self input] outputObject:&outputObject];
		self.output = outputObject;
	}
	@finally {
		FLReleaseWithNil_(outputObject);
	}

}

- (void) dealloc {
	mrc_release_(_database);
	super_dealloc_();
}

@end
