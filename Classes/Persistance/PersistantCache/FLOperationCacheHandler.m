//
//  FLOperationCacheHandler.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/9/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLOperationCacheHandler.h"

@implementation FLOperationCacheHandler

@synthesize database = _database;

@synthesize onLoadFromCache = _loadFromCacheCallback;
@synthesize onSaveToCache = _saveToCacheCallback;
@synthesize onLoadedFromCache = _wasLoadedFromCacheCallback;
@synthesize onLoadedFromCacheInMainThread = _wasLoadedFromCacheMainThreadCallback;

FLSynthesizeStructProperty(cacheBehavior, setCacheBehavior, FLHttpOperationCacheBehavior, _networkFlags);
FLSynthesizeStructProperty(wasLoadedFromCache, setWasLoadedFromCache, BOOL, _networkFlags);

- (id) initWithDatabase:(FLObjectDatabase*) database
    behavior:(FLHttpOperationCacheBehavior) behavior
{
    self = [super init];
    if(self)
    {
        self.database = database;
        self.cacheBehavior = behavior;
    }
    return self;
}

+ (FLOperationCacheHandler*) operationCacheHandler:(FLObjectDatabase*) database
    behavior:(FLHttpOperationCacheBehavior) behavior
{
    return FLReturnAutoreleased([[FLOperationCacheHandler alloc] initWithDatabase:database behavior:behavior]);
}

- (void) saveOperationOutputToCache:(FLOperation*) operation
{
	if(_database && operation.operationOutput)
	{
		[_database saveObject:operation.operationOutput];
	}
}

- (id) loadObjectFromCacheWithOperation:(FLOperation*) operation
{
	id object = nil;
	if(_database && operation.operationInput)
	{
		object = [self.database loadObject:operation.operationInput];
	}

	return object;
}

- (void) _performWasLoadedFromCacheCallbackOnMainThread:(id) operation
{
    if(_wasLoadedFromCacheMainThreadCallback)
    {
        _wasLoadedFromCacheMainThreadCallback(self, operation); 
    }
}

- (void) setOutputFromCacheForOperation:(FLOperation*) operation
    output:(id) output
{
	if(output)
	{
		operation.operationOutput = output;
		self.wasLoadedFromCache = YES;
		
		if(_wasLoadedFromCacheCallback)
		{
			_wasLoadedFromCacheCallback(self, operation);
		}
		if(_wasLoadedFromCacheMainThreadCallback)
		{
            [self performSelectorOnMainThread:@selector(_performWasLoadedFromCacheCallbackOnMainThread:) withObject:operation waitUntilDone:NO];
		}
	}
}

- (void) willStartSelf:(FLOperation*) operation
{
    if(FLTestBits(self.cacheBehavior, FLHttpOperationCacheBehaviorLoad))
	{
		id object = nil;
		if(_loadFromCacheCallback)
		{
			object = _loadFromCacheCallback(self);
		}
		else
		{
			object = [self loadObjectFromCacheWithOperation:operation];
		}
		
		[self setOutputFromCacheForOperation:operation output:object];
		
		if(self.wasLoadedFromCache && !FLTestBits(self.cacheBehavior, FLHttpOperationCacheBehaviorContinueAfterLoad)) {
			[operation requestCancel];
		}
		
		self.wasLoadedFromCache = NO;
	}
}



- (void) dealloc
{
    FLReleaseBlockWithNil(_loadFromCacheCallback);
    FLReleaseBlockWithNil(_saveToCacheCallback);
    FLReleaseBlockWithNil(_wasLoadedFromCacheCallback);
    FLReleaseBlockWithNil(_wasLoadedFromCacheMainThreadCallback);
    FLRelease(_database);
	FLSuperDealloc();
}

- (void) willFinishSelf:(FLOperation*) operation {
    if(!operation.error && 
        FLTestBits(self.cacheBehavior, FLHttpOperationCacheBehaviorSave) && 
        !self.wasLoadedFromCache)
    {
        if(_saveToCacheCallback)
        {
            _saveToCacheCallback(self, operation);
        }
        else 
        {
            [self saveOperationOutputToCache:operation];
        }
    }
}

@end
