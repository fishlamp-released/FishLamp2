//
//	FLQueuedCachedOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLDatabaseCacheOperation.h"

@implementation FLDatabaseCacheOperation

@synthesize operation = _operation;

- (id) initWithObjectAndOperationType:(FLObjectDatabase*) cache
	object:(id) object 
	operation:(FLCacheOperationType) operation
{
	if((self = [super init]))
	{
		FLAssertIsNotNil_v(cache, nil);
		FLAssertIsNotNil_v(object, nil);
		
		_cache = FLReturnRetained(cache);
		self.input = object;
		self.operation = operation;
	}
	
	return self;
}

- (void) runSelf
{
	id output = nil;
				
	@try
	{
		switch(_operation)
		{
			case gtLoadFromCacheOperation:
				self.output = [_cache loadObject:self.input];
				break;
			case gtSaveToCacheOperation:
				[_cache saveObject:self.input];
				break;

			case gtDeleteFromCacheOperation:
				[_cache deleteObject:self.input];
				break;
				
				
			case gtLoadFromDatabaseOperation:
			case gtSaveToDatabaseOperation:
			case gtDeleteFromDatabase:
				FLAssertFailed_v(@"not implemented");
				break;
				
		}
	}
	@finally {
		FLReleaseWithNil(output);
	}
}

- (void) dealloc
{
	FLRelease(_cache);
	FLSuperDealloc();
}

@end

