//
//	ZfLoadUploadQueueThumbnail.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSaveObjectToDatabaseOperation.h"

@implementation GtSaveObjectToDatabaseOperation

- (id) initWithDatabaseObjectInput:(GtObjectDatabase*) database 
							 input:(id) input
{
	if((self = [self init]))
	{
		self.input = input;
		GtAssertNotNil(database);
		GtAssertNotNil(input);
		m_database = GtRetain(database);
	}
	return self;
} 

- (void) dealloc
{
	GtRelease(m_database);
	GtSuperDealloc();
}

- (void) performSelf
{
	GtAssertNotNil(m_database);
	[m_database saveObject:[self input]];
}

@end
