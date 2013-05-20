//
//	ZfLoadUploadQueueThumbnail.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLoadObjectFromDatabaseOperation.h"

@implementation GtLoadObjectFromDatabaseOperation

- (id) initWithCacheableObjectInput:(GtObjectDatabase*) database 
							  input:(id) input
{
	if((self = [self init]))
	{
		GtAssertNotNil(database);
		GtAssertNotNil(input);
		self.input = input;
		m_database = GtRetain(database);
	}
	return self;
} 

- (void) performSelf
{
	GtAssertNotNil(m_database);
	id outputObject = nil;
	@try
	{
		[m_database loadObject:[self input] outputObject:&outputObject];
		self.output = outputObject;
	}
	@finally
	{
		GtReleaseWithNil(outputObject);
	}
}

- (void) dealloc
{
	GtRelease(m_database);
	GtSuperDealloc();
}

@end
