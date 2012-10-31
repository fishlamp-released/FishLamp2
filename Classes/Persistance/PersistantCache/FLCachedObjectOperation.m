//
//	FLCachedObjectOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCachedObjectOperation.h"
#import "FLPerformSelectorOperation.h"

@implementation FLCachedObjectOperation
@synthesize cache = _cache;
@synthesize subOperation = _subOperation;

FLSynthesizeStructProperty(canSaveToCache, setCanSaveToCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(canLoadFromCache, setCanLoadFromCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(wasLoadedFromCache, setWasLoadedFromCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(wasLoadedFromMemoryCache, setWasLoadedFromMemoryCache, BOOL, _cacheOperationFlags);
FLSynthesizeStructProperty(shouldRunIfLoadedFromCache, setShouldRunIfLoadedFromCache, BOOL, _cacheOperationFlags);

- (id) init {
	if((self = [super init])) {
	}

	return self;
}

- (id) initWithSubOperation:(FLOperation*) operation {
	if((self = [super init])) {
		self.subOperation = operation;
	}
	return self;
}

+ (id) cachedObjectOperation:(FLOperation*) subOperation {
    return autorelease_([[[self class] alloc] initWithSubOperation:subOperation]);
}

- (void) dealloc {
	mrc_release_(_cache);
	mrc_release_(_subOperation);
	mrc_super_dealloc_();
}

- (void) setWasLoadedFromCacheCallback:(id) target action:(SEL) action {
	_target = target;
    _action = action;
}

- (void) setInputObjectForCacheLoading {
}

- (id) loadOutputFromMemoryCache {
    FLAssertIsNotNil_(self.cache);

	if(!self.input) {
		[self setInputObjectForCacheLoading];
	}
	return [self.cache loadObjectFromMemoryCache:self.input];
}

- (id) loadOutputFromCache {
	if(!self.input) {	
		[self setInputObjectForCacheLoading];
	}
	return [self.cache loadObject:self.input];
}

- (void) setOutputFromCache:(id) object {
	self.output = object;
}

- (BOOL) loadFromMemoryCache {

    FLAssertIsNotNil_(self.cache);

	id cachedObject = [self loadOutputFromMemoryCache];

	if(cachedObject) {
		[self setOutputFromCache:cachedObject];
		self.wasLoadedFromMemoryCache = YES;
		self.wasLoadedFromCache = YES;
		
		[self didLoadFromCache];
	}
	
	return self.wasLoadedFromMemoryCache;
}

- (void) didLoadFromCache {
    [_target performIfRespondsToSelector:_action withObject:self];
}

- (void) loadFromCache {
	id cachedObject = [self loadOutputFromCache];

	if(cachedObject) {
		[self setOutputFromCache:cachedObject];
	
		self.wasLoadedFromCache = YES;
		[self didLoadFromCache];
	}
}

- (void) saveOutputToCache {
	[self.cache saveObject:self.output];
}

- (void) setOutputFromSubOperation {
	self.output = self.subOperation.output;
}

- (void) runSubOperations {
    [self runSubOperation:_subOperation];
}


- (void) runSelf {
	if(self.canLoadFromCache && (!self.wasLoadedFromCache || self.shouldRunIfLoadedFromCache)) {
		[self loadFromCache];
	}
	
    if(!self.wasLoadedFromCache || self.shouldRunIfLoadedFromCache) {
		self.wasLoadedFromCache = NO;
	
        [self runSubOperations];

        [self setOutputFromSubOperation];
    
        if(self.canSaveToCache && !self.wasLoadedFromCache) {
            [self saveOutputToCache];
        }
	}
}



@end
