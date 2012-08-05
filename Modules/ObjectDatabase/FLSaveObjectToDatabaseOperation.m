//
//	ZfLoadUploadQueueThumbnail.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSaveObjectToDatabaseOperation.h"

@implementation FLSaveObjectToDatabaseOperation

- (id) initWithDatabaseObjectInput:(FLObjectDatabase*) database 
							 input:(id) input
{
	if((self = [self init]))
	{
		self.input = input;
		FLAssertIsNotNil(database);
		FLAssertIsNotNil(input);
		_database = FLReturnRetained(database);
	}
	return self;
} 

- (void) dealloc
{
	FLRelease(_database);
	FLSuperDealloc();
}

- (void) performSelf
{
	FLAssertIsNotNil(_database);
	[_database saveObject:[self input]];
}

@end
