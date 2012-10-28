//
//  FLAssetQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLAssetQueue.h"
#import "FLUploadedAsset.h"

#import "FLUserSession.h"
#import "NSObject+Blocks.h"
#import "NSString+GUID.h"
#import "FLDatabase.h"

@interface FLAssetQueueLoadLock (Internal)
- (id) initWithAssetQueue:(FLAssetQueue*) queue;
- (void) clearQueueReference;
@end

@interface FLAssetQueue ()
- (void) unload;

@property (readwrite, strong, nonatomic) FLAssetQueueState* state;
@end

@implementation FLAssetQueue

@synthesize queueUID = _queueUID;
@synthesize database = _database;
@synthesize assets = _queue;
@synthesize state = _state;

FLAssertDefaultInitNotCalled_v(nil);

- (id) initWithQueueUID:(NSString*) uid
{
	if((self = [super init]))
	{	
		FLAssertIsNotNil_v(uid, nil);
		_queueUID = FLReturnRetained(uid);
	}
	
	return self;
}

- (void) dealloc
{
    [self unload];
	FLRelease(_state);
	FLRelease(_queueUID);
	FLRelease(_queue);
	FLRelease(_database);
    FLRelease(_locks);
	FLSuperDealloc();
}

- (void) setDatabase:(FLObjectDatabase*) database
{
    [self unload];
	FLReleaseWithNil(_state);
    
	FLAssignObject(_database, database);
	if(_database)
	{
		FLAssetQueueState* input = [FLAssetQueueState assetQueueState];
		input.queueUID = _queueUID;
		self.state = [_database loadObject:input];
		if(!_state) {
			_state = FLReturnRetained(input);
			_state.firstQueuePositionValue = 0;
			_state.lastQueuePositionValue = 1;
			_state.sortOrder = FLAssetQueueSortOrderOldestFirst;
		}
	}
}

- (NSUInteger) count
{
    if(_queue)
    {
        return _queue.count;
    }
    
    return	[[FLUserSession instance].documentsDatabase rowCountForTable:[[self queueClass] sharedDatabaseTable]];
}

- (unsigned long) totalAssetsAdded
{
	return _state.totalAssetsAddedValue;
}

- (FLAssetQueueSortOrder) sortOrder
{
	return _state.sortOrderValue;
}

- (BOOL) isLoaded
{
	return _queue != nil;
}

- (void) unload
{
    if(_queue)
    {
        @synchronized(self) {
            FLReleaseWithNil(_queue);
            
            for(NSValue* value in _locks)
            {
                [[value nonretainedObjectValue] clearQueueReference];
            }
            
            FLReleaseWithNil(_locks);
        }
    }
}

- (void) saveAsset:(FLQueuedAsset*) asset
{
    FLAssertIsNotNil_v(self.database, nil);

    asset.queueUID = self.queueUID;
    [self.database saveObject:asset];
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) sort:(FLAssetQueueSortOrder) sortOrder assetSortPropertySelector:(SEL) selector
{
    FLAssertIsNotNil_v(self.database, nil);

    if(_queue && _queue.count)
    {
        @synchronized(self) {

            _state.sortOrderValue = sortOrder;

            if(sortOrder == FLAssetQueueSortOrderNewestFirst)
            {
                [_queue sortUsingComparator:^(id obj1, id obj2) { return [[obj2 performSelector:selector] compare:[obj1 performSelector:selector]]; }];
            }
            else
            {
                [_queue sortUsingComparator:^(id obj1, id obj2) { return [[obj1 performSelector:selector] compare:[obj2 performSelector:selector]]; }];
            }

            // normalize list and save it.

            int sortId = 0; // _queue.count;
            for(FLQueuedAsset* photo in _queue) 
            {
                photo.positionInQueueValue = ++sortId;
            }

            _state.firstQueuePosition = [[_queue firstObject] positionInQueue];
            _state.lastQueuePosition = [[_queue lastObject] positionInQueue];
        
            [self saveQueueToDatabase];
        }
    }
}

#pragma GCC diagnostic pop


- (void) exchangeAssetsInSort:(NSUInteger) lhs rhs:(NSUInteger) rhs
{
	FLQueuedAsset* obj1 = nil;
   	FLQueuedAsset* obj2 = nil;
	FLAssertIsNotNil_v(self.database, nil);

	@synchronized(self) {
		obj1 = [_queue objectAtIndex:lhs];
		obj2 = [_queue objectAtIndex:rhs];

		NSNumber* temp = FLReturnRetained(obj1.positionInQueue);
		obj1.positionInQueue = obj2.positionInQueue;
		obj2.positionInQueue = temp;
		
        FLRelease(temp);
		
        [_queue exchangeObjectAtIndex:lhs withObjectAtIndex:rhs];
    }

    [_database saveObject:obj1];
    [_database saveObject:obj2];

    [self didChangeAssetQueue];
} 

- (NSUInteger) indexOfAsset:(FLQueuedAsset*) aAsset
{
	@synchronized(self) {
		NSUInteger idx = 0;
		for(FLQueuedAsset* asset in _queue)
		{
			if([asset.assetUID isEqualToString:aAsset.assetUID])
			{
				return idx;
			}
			
			++idx;
		}
	}
	
	return NSNotFound;
}

- (id) assetAtIndex:(NSUInteger) idx
{
	@synchronized(self) {
		FLAssert_v(self.isLoaded, @"queue not loaded");
		FLAssert_v(idx >= 0 && idx < _queue.count, @"bad idx");
		
		if(idx < _queue.count)
		{
			return [_queue objectAtIndex:idx];
		}
	}
	
	return nil;
}

- (void) deleteAsset:(FLQueuedAsset*) asset
{	
    FLAssertIsNotNil_v(asset, nil);
    FLAssertIsNotNil_v(asset.assetObject, nil);

    if(_queue)
    {
        @synchronized(self) {
            NSUInteger idx = [self indexOfAsset:asset];
            if(idx != NSNotFound)
            {
                [_queue removeObjectAtIndex:idx];
            }
        }
    }

    asset.queueUID = self.queueUID;
    [asset.assetObject deleteFromAssetStorage];
    [_database deleteObject:asset];
    [self didChangeAssetQueue];
}

- (void) deleteAssetAtIndex:(NSUInteger) idx
{
    FLAssert_v(self.isLoaded, @"queue not loaded");
    FLAssert_v(idx >= 0 && idx < _queue.count, @"bad idx");

    FLQueuedAsset* asset = nil;
		
	@synchronized(self) {
		asset = [_queue objectAtIndex:idx];
		[_queue removeObjectAtIndex:idx];
    }

    [asset.assetObject deleteFromAssetStorage];
	[_database deleteObject:asset];
    [self didChangeAssetQueue];
}

- (void) removeAllAssets
{
	[self removeAssetsByType:FLAssetTypeNone];
}

- (void) removeAssetsByType:(FLAssetType) type
{
	@synchronized(self) {
    
		FLAssert_v(self.isLoaded, @"queue not loaded");
        
        for(int i = _queue.count - 1; i >= 0; i--)
        {
            FLQueuedAsset* asset = [_queue objectAtIndex:i];
            if( type == FLAssetTypeNone ||
                type == (FLAssetType) asset.assetTypeValue) 
            {
                [asset.assetObject deleteFromAssetStorage];
                [_database deleteObject:asset];
                [_queue removeObjectAtIndex:i];
            }
        }
    }    
    
    [self didChangeAssetQueue];
}

- (void) _addAssetToQueue:(FLQueuedAsset*) asset
{
	switch(self.sortOrder)
	{
		case FLAssetQueueSortOrderOldestFirst:
			_state.lastQueuePositionValue = _state.lastQueuePositionValue + 1;
			asset.positionInQueue = _state.lastQueuePosition;
			
			if(_queue)
			{
				[_queue addObject:asset];
			}
		break;
		
		case FLAssetQueueSortOrderNewestFirst:
			_state.firstQueuePositionValue = _state.firstQueuePositionValue - 1;
			asset.positionInQueue = _state.firstQueuePosition;
			
			if(_queue)
			{
				[_queue insertObject:asset atIndex:0];
			}
		break;
	}
	_state.totalAssetsAddedValue = _state.totalAssetsAddedValue + 1;
}

- (void) batchAddAssets:(NSArray*) assets
{
    NSDate* date = [[NSDate alloc] init];
		
	@synchronized(self) {
		for(FLQueuedAsset* asset in assets)
		{
			[self _addAssetToQueue:asset];
			asset.queueUID = self.queueUID;
			asset.queuedDate = date;
		}
    }

	FLRelease(date);
    
    [_database batchSaveObjects:assets];
    [_database saveObject:_state];
    
    [self didChangeAssetQueue];
}

- (void) didChangeAssetQueue
{
}

- (void) addAsset:(FLQueuedAsset*) asset
{
	@synchronized(self) {
		[self _addAssetToQueue:asset];
	}

    NSDate* date = [[NSDate alloc] init];
    asset.queuedDate = date;
    FLRelease(date);
    
    [self saveAsset:asset];
    [_database saveObject:_state];

    [self didChangeAssetQueue];
	
}

- (Class) queueClass
{
	return [FLQueuedAsset class];
}

- (void) beginLoadingFirstAsset:(FLAssetQueueLoadAssetBlock) completionBlock
{
    completionBlock = FLReturnAutoreleased([completionBlock copy]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
    ^{
        FLDatabaseTable* table = [[self queueClass] sharedDatabaseTable];
        FLDatabaseIterator* statement = [FLDatabaseIterator databaseIterator:_database table:table];
        
        __block FLQueuedAsset* asset = nil;
        @try 
        {
            [statement selectObjects:^(BOOL* stop){ // LIMIT 1
                    [statement appendFormat:@"SELECT * FROM %@ ORDER BY %@ ASC LIMIT 1",
                            table.tableName,
                            FLDatabaseNameEncode([FLQueuedAsset positionInQueueKey])];

                }
                didSelectObject:^(id object, BOOL* stop) {
                    FLAssignObject(asset, object);
                    *stop = YES;
                }
                didFinish:^{
                    if(asset)
                    {
                        [asset createAssetIfNeeded];
                        [asset.assetObject beginLoadingRepresentation:^(NSError* error) {
                            if(completionBlock)
                            {
                                [self performBlockOnMainThread:
                                    ^{	
                                        if(error)
                                        {
                                            completionBlock(nil, error);
                                        }
                                        else
                                        {
                                            completionBlock(asset, nil);
                                        }
                                    }];
                            }
                            
                        }];
                    } 
                    else if(completionBlock)
                    {
                        [self performBlockOnMainThread:^{ completionBlock(nil,nil); }];
                    }
                }];
        }
        @catch(NSException* ex) {
            if(completionBlock) {
                [self performBlockOnMainThread: ^{
                        completionBlock(nil, ex.error);
                    }];
            }
        }
        
    });
}



- (void) didUploadAsset:(FLQueuedAsset*) asset
{
    FLUploadedAsset* uploadedAsset = [FLUploadedAsset uploadedAsset];
    uploadedAsset.queueUID = asset.queueUID;
    uploadedAsset.assetName = asset.displayName;
    uploadedAsset.assetType = asset.assetType;
    uploadedAsset.assetUID = asset.assetUID;
    uploadedAsset.assetURL = asset.assetURL;
    uploadedAsset.thumbnail = [asset.assetObject thumbnailImage];
    uploadedAsset.uploadDestinationId = asset.uploadDestinationId;
    uploadedAsset.uploadDestinationName = asset.uploadDestinationName;
    uploadedAsset.uploadDestinationURL = asset.uploadDestinationURL;
    uploadedAsset.uploadedAssetId = asset.uploadedAssetId;
    uploadedAsset.uploadedAssetURL = asset.uploadedAssetURL;
    uploadedAsset.uploadedDate = [NSDate date];
    [_database	saveObject:uploadedAsset];
    [self deleteAsset:asset];
}

- (BOOL) assetForURL:(NSString*) assetUrl existsInTable:(FLDatabaseTable*) table {

    __block BOOL foundIt = NO;

    FLDatabaseIterator* statement = [FLDatabaseIterator databaseIterator:self.database table:table];
    [statement appendString:SQL_SELECT andString:FLDatabaseNameEncode(@"assetUID")];
    [statement appendString:SQL_FROM andString:table.tableName];
    [statement appendString:SQL_WHERE];
    [statement appendObject:assetUrl comparedToString:FLDatabaseNameEncode(@"assetURL") withComparer:SQL_EQUAL];

    [statement execute:^(NSDictionary* row, BOOL* stop) {
        foundIt = [row objectForKey:FLDatabaseNameEncode(@"assetUID")] != nil;
        if(foundIt) {
            *stop = YES;
        }
    }];

    return foundIt;
}


- (BOOL) assetIsInQueue:(NSString*) assetURL {
    return [self assetForURL:assetURL existsInTable:[[self queueClass] sharedDatabaseTable]];
}

- (BOOL) assetWasUploaded:(NSString*) assetURL {
    return [self assetForURL:assetURL existsInTable:[[FLUploadedAsset class] sharedDatabaseTable]];
}

- (void) replaceAssetAtIndex:(NSUInteger) idx asset:(FLQueuedAsset*) asset
{
	FLAssert_v(self.isLoaded, @"queue not loaded");

	@synchronized(self) {
		FLQueuedAsset* oldAsset = [_queue objectAtIndex:idx];
		asset.positionInQueue = oldAsset.positionInQueue;
		[_queue replaceObjectAtIndex:idx withObject:asset];
	}	
	
    [self saveAsset:asset];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id *)stackbuf count:(NSUInteger)len
{
	if(state->state >= _queue.count) {
		return 0;
	}
	
	NSRange range = NSMakeRange(state->state, len);
	if(range.length + range.location >= _queue.count) {
		range.length -= ((range.length + range.location) - _queue.count);
	}
	
	__unsafe_unretained id objects[len];
	
	[_queue getObjects:objects range:range];
	
	for(NSUInteger i = 0; i < range.length; i++) {
		stackbuf[i] = objects[i];
	}
	
	state->state = state->state + range.length;
	state->itemsPtr = stackbuf;
	state->mutationsPtr = (__bridge_fl void*) self;

	return range.length;
}

- (void) saveQueueToDatabase
{
	@synchronized(self) {
        if(_queue)
        {
            [_database batchSaveObjects:_queue];
        }
        if(_state)
        {
            [_database saveObject:_state];
        }
    }
	[self didChangeAssetQueue];
}

- (void) finishLoadingFromDatabase:(NSMutableArray*) queue
{
    @synchronized(self) {
        FLAssignObject(_queue, queue);
    }
}

- (FLAssetQueueLoadLock*) loadLock
{
    FLAssert_v(self.isLoaded, @"can't get a load lock on an unloaded queue");

    if(!_locks)
    {
        _locks = [[NSMutableArray alloc] init];
    }

    FLLog(@"Added lock");

    FLAssetQueueLoadLock* lock = FLReturnAutoreleased([[FLAssetQueueLoadLock alloc] initWithAssetQueue:self]);
    [_locks addObject:[NSValue valueWithNonretainedObject:lock]];
    return lock;
}

- (void) releaseLoadLock:(FLAssetQueueLoadLock*) lock
{
    for(NSInteger i = _locks.count - 1; i >= 0; i--)
    {
        if([[_locks objectAtIndex:i] nonretainedObjectValue] == lock)
        {
            [_locks removeObjectAtIndex:i];
            FLLog(@"released lock");
        }
    }
    
    if(_locks.count == 0)
    {
        [self unload];
        FLLog(@"unloaded asset queue");
    }
}

@end

//#import "FLAssetsLibraryImageAsset.h"


@implementation FLAssetQueueLoader

@synthesize assetQueue = _assetQueue;
@synthesize error = _error;
@synthesize wasCancelled = _cancelled;

- (id) initWithAssetQueue:(FLAssetQueue*) queue
{
    if((self = [super init]))
    {
        _assetQueue = FLReturnRetained(queue);
    }
    
    return self;
}

+ (FLAssetQueueLoader*) assetQueueLoader:(FLAssetQueue*) queue
{
    return FLReturnAutoreleased([[FLAssetQueueLoader alloc] initWithAssetQueue:queue]);
}

- (void) dealloc
{
    FLRelease(_queue);
    FLRelease(_assetQueue);
    FLRelease(_error);
    FLSuperDealloc();
}

- (void) cancelLoading
{
    _cancelled = YES;
}

- (void) _loadNextAsset:(NSMutableArray*) queue
           currentIndex:(NSUInteger) currentIndex
        completionBlock:(dispatch_block_t) completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
    ^{
        if(currentIndex < queue.count)
        {
            if(_cancelled)
            {
                if(completionBlock)
                {
                    completionBlock();
                }
                return;
            }
        
            FLQueuedAsset* asset = [queue objectAtIndex:currentIndex]; 
            [asset createAssetIfNeeded];
            [asset.assetObject beginLoadingRepresentation:^(NSError* error) 
            {
                if(_cancelled)
                {
                    if(completionBlock)
                    {
                        completionBlock();
                    }
                }
                else
                {
                    if(error) 
                    {
                        FLAssignObject(_error, error);
                        
                        if(completionBlock)
                        {
                            completionBlock();
                        }
                    }
                    else
                    {
                        [self _loadNextAsset:queue currentIndex:(currentIndex + 1) completionBlock:completionBlock];
                    }
                }
            }];
        }
        else
        {
            if(completionBlock)
            {
                completionBlock();
            }
        }
    });
}
 
- (void) beginLoadingAssets:(NSMutableArray*) assets
            completionBlock:(dispatch_block_t) completionBlock
{
    [self _loadNextAsset:assets 
            currentIndex:0 
         completionBlock:FLReturnAutoreleased([completionBlock copy])];
}

- (void) _didFinishLoading:(FLAssetQueueLoaderBlock) callback
{
    [self performBlockOnMainThread:^{
        if(_cancelled)
        {
            FLAssignObject(_error, [NSError cancelError]);
        }
        
        if(!_cancelled && !_error)
        {
            [_assetQueue finishLoadingFromDatabase:_queue];
        }
        
        if(callback)
        {
            callback([_assetQueue loadLock]);
        }
    }];
}

- (void) beginLoadingFromDatabase:(FLAssetQueueLoaderBlock) completionBlock
{
    if(_assetQueue.isLoaded)
    {
        if(completionBlock)
        {
            completionBlock([_assetQueue loadLock]);
        }
        
        return;
    }

    completionBlock = FLReturnAutoreleased([completionBlock copy]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
    ^{
        if(_cancelled)
        {
            [self _didFinishLoading:completionBlock];
            return;
        }
        
        // TODO: Load with sort. ORDER BY
        NSArray* queue = nil;
        [_assetQueue.database loadAllObjectsForTypeWithClass:[_assetQueue queueClass] outObjects:&queue];
        FLAutorelease(queue);

        if(_cancelled)
        {
            [self _didFinishLoading:completionBlock];
            return;
        }
        
        if(!queue || queue.count == 0)
        {
            FLAssignObject(_queue, [NSMutableArray array]); 
            [self _didFinishLoading:completionBlock];
        }
        else
        {
            NSMutableArray* newQueue = FLReturnAutoreleased([queue mutableCopy]);
                    
            [self beginLoadingAssets:newQueue completionBlock:^{ 
                
                if(!_error && !_cancelled)
                {
                    [newQueue sortUsingComparator:^(id obj1, id obj2) {
                        return [[obj1 positionInQueue] compare:[obj2 positionInQueue]];
                        }];

                    FLAssignObject(_queue, newQueue); 
                }
                
                [self _didFinishLoading:completionBlock];
            }];
        }
    });
}

@end

@implementation FLAssetQueueLoadLock

- (id) initWithAssetQueue:(FLAssetQueue*) queue
{
    if((self = [super init]))
    {
        _assetQueue = queue;
    }
    return self;
}

- (void) releaseLock
{
    [_assetQueue releaseLoadLock:self];
    _assetQueue = nil;
}

- (void) dealloc
{
    [self releaseLock];
    FLSuperDealloc();
}

- (void) clearQueueReference
{
    _assetQueue = nil;
}

@end
