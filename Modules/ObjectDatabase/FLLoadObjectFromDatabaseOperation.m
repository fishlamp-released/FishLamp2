//
//	ZfLoadUploadQueueThumbnail.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLLoadObjectFromDatabaseOperation.h"

@implementation FLLoadObjectFromDatabaseOperation

- (id) initWithCacheableObjectInput:(FLObjectDatabase*) database 
							  input:(id) input
{
	if((self = [self init]))
	{
		FLAssertIsNotNil(database);
		FLAssertIsNotNil(input);
		self.input = input;
		_database = FLReturnRetained(database);
	}
	return self;
} 

- (void) performSelf
{
	FLAssertIsNotNil(_database);
	id outputObject = nil;
	@try
	{
		[_database loadObject:[self input] outputObject:&outputObject];
		self.output = outputObject;
	}
	@finally
	{
		FLReleaseWithNil(outputObject);
	}
}

- (void) dealloc
{
	FLRelease(_database);
	FLSuperDealloc();
}

@end
