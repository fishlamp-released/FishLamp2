//
//	GtQueuedCachedOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDatabaseCacheOperation.h"

@implementation GtDatabaseCacheOperation

@synthesize operation = m_operation;

- (id) initWithObjectAndOperationType:(GtObjectDatabase*) cache
	object:(id) object 
	operation:(GtCacheOperationType) operation
{
	if((self = [super init]))
	{
		GtAssertNotNil(cache);
		GtAssertNotNil(object);
		
		m_cache = GtRetain(cache);
		self.input = object;
		self.operation = operation;
	}
	
	return self;
}

- (void) performSelf
{
	id output = nil;
				
	@try
	{
		switch(m_operation)
		{
			case gtLoadFromCacheOperation:
				self.output = [m_cache loadObject:self.input];
				break;
			case gtSaveToCacheOperation:
				[m_cache saveObject:self.input];
				break;

			case gtDeleteFromCacheOperation:
				[m_cache deleteObject:self.input];
				break;
				
				
			case gtLoadFromDatabaseOperation:
			case gtSaveToDatabaseOperation:
			case gtDeleteFromDatabase:
				GtAssertFailed(@"not implemented");
				break;
				
		}
	}
	@finally
	{
		GtReleaseWithNil(output);
	}
}

- (void) dealloc
{
	GtRelease(m_cache);
	GtSuperDealloc();
}

@end

