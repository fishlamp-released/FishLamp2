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

@interface FLAssetQueueLoadLock (Internal)
- (id) initWithAssetQueue:(FLAssetQueue*) queue;
- (void) clearQueueReference;
@end

@interface FLAssetQueue ()
- (void) unload;
@end

@implementation FLAssetQueue

@synthesize queueUID = m_queueUID;
@synthesize database = m_database;
@synthesize assets = m_queue;

FLAssertDefaultInitNotCalled();

- (id) initWithQueueUID:(NSString*) uid
{
	if((self = [super init]))
	{	
		FLAssertIsNotNil(uid);
		m_queueUID = FLReturnRetained(uid);
	}
	
	return self;
}

- (void) dealloc
{
    [self unload];
	FLRelease(m_state);
	FLRelease(m_queueUID);
	FLRelease(m_queue);
	FLRelease(m_database);
    FLRelease(m_locks);
	FLSuperDealloc();
}

- (void) setDatabase:(FLObjectDatabase*) database
{
    [self unload];
	FLReleaseWithNil(m_state);
    
	FLAssignObject(m_database, database);
	if(m_database)
	{
		FLAssetQueueState* input = [FLAssetQueueState assetQueueState];
		input.queueUID = m_queueUID;
		[m_database loadObject:input outputObject:&m_state];
		if(!m_state)
		{
			m_state = FLReturnRetained(input);
			m_state.firstQueuePositionValue = 0;
			m_state.lastQueuePositionValue = 1;
			m_state.sortOrder = FLAssetQueueSortOrderOldestFirst;
		}
	}
}

- (NSUInteger) count
{
    if(m_queue)
    {
        return m_queue.count;
    }
    
    return	[[FLUserSession instance].documentsDatabase rowCountForTable:[[self queueClass] sharedSqliteTable]];
}

- (unsigned long) totalAssetsAdded
{
	return m_state.totalAssetsAddedValue;
}

- (FLAssetQueueSortOrder) sortOrder
{
	return m_state.sortOrderValue;
}

- (BOOL) isLoaded
{
	return m_queue != nil;
}

- (void) unload
{
    if(m_queue)
    {
        @synchronized(self) {
            FLReleaseWithNil(m_queue);
            
            for(NSValue* value in m_locks)
            {
                [[value nonretainedObjectValue] clearQueueReference];
            }
            
            FLReleaseWithNil(m_locks);
        }
    }
}

- (void) saveAsset:(FLQueuedAsset*) asset
{
    FLAssertIsNotNil(self.database);

    asset.queueUID = self.queueUID;
    [self.database saveObject:asset];
}

- (void) sort:(FLAssetQueueSortOrder) sortOrder assetSortPropertySelector:(SEL) selector
{
    FLAssertIsNotNil(self.database);

    if(m_queue && m_queue.count)
    {
        @synchronized(self) {

            m_state.sortOrderValue = sortOrder;

            if(sortOrder == FLAssetQueueSortOrderNewestFirst)
            {
                [m_queue sortUsingComparator:^(id obj1, id obj2) { return [[obj2 performSelector:selector] compare:[obj1 performSelector:selector]]; }];
            }
            else
            {
                [m_queue sortUsingComparator:^(id obj1, id obj2) { return [[obj1 performSelector:selector] compare:[obj2 performSelector:selector]]; }];
            }

            // normalize list and save it.

            int sortId = 0; // m_queue.count;
            for(FLQueuedAsset* photo in m_queue) 
            {
                photo.positionInQueueValue = ++sortId;
            }

            m_state.firstQueuePosition = [[m_queue firstObject] positionInQueue];
            m_state.lastQueuePosition = [[m_queue lastObject] positionInQueue];
        
            [self saveQueueToDatabase];
        }
    }
}

- (void) exchangeAssetsInSort:(NSUInteger) lhs rhs:(NSUInteger) rhs
{
	FLQueuedAsset* obj1 = nil;
   	FLQueuedAsset* obj2 = nil;
	FLAssertIsNotNil(self.database);

	@synchronized(self) {
		obj1 = [m_queue objectAtIndex:lhs];
		obj2 = [m_queue objectAtIndex:rhs];

		NSNumber* temp = FLReturnRetained(obj1.positionInQueue);
		obj1.positionInQueue = obj2.positionInQueue;
		obj2.positionInQueue = temp;
		
        FLRelease(temp);
		
        [m_queue exchangeObjectAtIndex:lhs withObjectAtIndex:rhs];
    }

    [m_database saveObject:obj1];
    [m_database saveObject:obj2];

    [self didChangeAssetQueue];
} 

- (NSUInteger) indexOfAsset:(FLQueuedAsset*) aAsset
{
	@synchronized(self) {
		NSUInteger idx = 0;
		for(FLQueuedAsset* asset in m_queue)
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
		FLAssert(self.isLoaded, @"queue not loaded");
		FLAssert(idx >= 0 && idx < m_queue.count, @"bad idx");
		
		if(idx < m_queue.count)
		{
			return [m_queue objectAtIndex:idx];
		}
	}
	
	return nil;
}

- (void) deleteAsset:(FLQueuedAsset*) asset
{	
    FLAssertIsNotNil(asset);
    FLAssertIsNotNil(asset.assetObject);

    if(m_queue)
    {
        @synchronized(self) {
            NSUInteger idx = [self indexOfAsset:asset];
            if(idx != NSNotFound)
            {
                [m_queue removeObjectAtIndex:idx];
            }
        }
    }

    asset.queueUID = self.queueUID;
    [asset.assetObject deleteFromAssetStorage];
    [m_database deleteObject:asset];
    [self didChangeAssetQueue];
}

- (void) deleteAssetAtIndex:(NSUInteger) idx
{
    FLAssert(self.isLoaded, @"queue not loaded");
    FLAssert(idx >= 0 && idx < m_queue.count, @"bad idx");

    FLQueuedAsset* asset = nil;
		
	@synchronized(self) {
		asset = [m_queue objectAtIndex:idx];
		[m_queue removeObjectAtIndex:idx];
    }

    [asset.assetObject deleteFromAssetStorage];
	[m_database deleteObject:asset];
    [self didChangeAssetQueue];
}

- (void) removeAllAssets
{
	[self removeAssetsByType:FLAssetTypeNone];
}

- (void) removeAssetsByType:(FLAssetType) type;
{
	@synchronized(self) {
    
		FLAssert(self.isLoaded, @"queue not loaded");
        
        for(int i = m_queue.count - 1; i >= 0; i--)
        {
            FLQueuedAsset* asset = [m_queue objectAtIndex:i];
            if( type == FLAssetTypeNone ||
                type == (FLAssetType) asset.assetTypeValue) 
            {
                [asset.assetObject deleteFromAssetStorage];
                [m_database deleteObject:asset];
                [m_queue removeObjectAtIndex:i];
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
			m_state.lastQueuePositionValue = m_state.lastQueuePositionValue + 1;
			asset.positionInQueue = m_state.lastQueuePosition;
			
			if(m_queue)
			{
				[m_queue addObject:asset];
			}
		break;
		
		case FLAssetQueueSortOrderNewestFirst:
			m_state.firstQueuePositionValue = m_state.firstQueuePositionValue - 1;
			asset.positionInQueue = m_state.firstQueuePosition;
			
			if(m_queue)
			{
				[m_queue insertObject:asset atIndex:0];
			}
		break;
	}
	m_state.totalAssetsAddedValue = m_state.totalAssetsAddedValue + 1;
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
    
    [m_database batchSaveObjects:assets];
    [m_database saveObject:m_state];
    
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
    [m_database saveObject:m_state];

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

        FLObjectDatabaseIterator* iterator = FLReturnAutoreleased([[FLObjectDatabaseIterator alloc] initWithObjectDatabase:m_database]);
        
        FLSqliteTable* table = [[self queueClass] sharedSqliteTable];
        [m_database createTableIfNeeded:table];
        
        __block FLQueuedAsset* asset = nil;
        @try 
        {
            [iterator selectObjectsInTable:table 
                willPrepareBlock:^{ // LIMIT 1
                    [iterator prepareStatement:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ ASC LIMIT 1", table.tableName, FLSqliteNameEncode([FLQueuedAsset positionInQueueKey])]];
                    return YES;
                }
                didSelectObjectBlock:^(id object) {
                    FLAssignObject(asset, object);
                    return NO;
                }
                didFinishBlock:^{
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
        @catch(NSException* ex) 
        {
            if(completionBlock)
            {
                [self performBlockOnMainThread:
                    ^{	
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
    [m_database	saveObject:uploadedAsset];
    [self deleteAsset:asset];
}

- (BOOL) assetIsInQueue:(NSString*) assetURL
{
    FLSqliteTable* table = [[self queueClass] sharedSqliteTable];
    FLSqliteStatement* statement = [[FLSqliteStatement alloc] initWithSqliteDatabase:self.database];
    @try
    {
        [self.database createTableIfNeeded:table];
    
        [statement prepareStatement:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=?", 
            FLSqliteNameEncode(@"assetUID"),
            FLSqliteNameEncode(table.tableName),
            FLSqliteNameEncode(@"assetURL")]];
        
        [assetURL bindToStatement:statement parameterIndex:1];

        while(statement.willStep)
        {
            NSDictionary* row = [statement step];
            if(row && row.count)
            {
                return [row objectForKey:FLSqliteNameEncode(@"assetUID")] != nil;
            }
        }
    }
    @finally
    {
        [statement finalizeStatement];
        FLRelease(statement);
    
    }
	
	return NO;
}

- (BOOL) assetWasUploaded:(NSString*) assetURL
{
    FLSqliteTable* table = [[FLUploadedAsset class] sharedSqliteTable];
    FLSqliteStatement* statement = [[FLSqliteStatement alloc] initWithSqliteDatabase:self.database];
    @try
    {
        [self.database createTableIfNeeded:table];
    
        [statement prepareStatement:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=?", 
            FLSqliteNameEncode(@"assetUID"),
            FLSqliteNameEncode(table.tableName),
            FLSqliteNameEncode(@"assetURL")]];
        
        [assetURL bindToStatement:statement parameterIndex:1];

        while(statement.willStep)
        {
            NSDictionary* row = [statement step];
            if(row && row.count)
            {
                return [row objectForKey:FLSqliteNameEncode(@"assetUID")] != nil;
            }
        }
    }
    @finally
    {
        [statement finalizeStatement];
        FLRelease(statement);
    
    }
	
    return NO;	
}

- (void) replaceAssetAtIndex:(NSUInteger) idx asset:(FLQueuedAsset*) asset
{
	FLAssert(self.isLoaded, @"queue not loaded");

	@synchronized(self) {
		FLQueuedAsset* oldAsset = [m_queue objectAtIndex:idx];
		asset.positionInQueue = oldAsset.positionInQueue;
		[m_queue replaceObjectAtIndex:idx withObject:asset];
	}	
	
    [self saveAsset:asset];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
	if(state->state >= m_queue.count)
	{
		return 0;
	}
	
	NSRange range = NSMakeRange(state->state, len);
	if(range.length + range.location >= m_queue.count)
	{
		range.length -= ((range.length + range.location) - m_queue.count);
	}
	
	id objects[len];
	
	[m_queue getObjects:objects range:range];
	
	for(NSUInteger i = 0; i < range.length; i++)
	{	
		stackbuf[i] = objects[i];
	}
	
	state->state = state->state + range.length;
	state->itemsPtr = stackbuf;
	state->mutationsPtr = (unsigned long*) self;

	return range.length;
}

- (void) saveQueueToDatabase
{
	@synchronized(self) {
        if(m_queue)
        {
            [m_database batchSaveObjects:m_queue];
        }
        if(m_state)
        {
            [m_database saveObject:m_state];
        }
    }
	[self didChangeAssetQueue];
}

- (void) finishLoadingFromDatabase:(NSMutableArray*) queue
{
    @synchronized(self) {
        FLAssignObject(m_queue, queue);
    }
}

- (FLAssetQueueLoadLock*) loadLock
{
    FLAssert(self.isLoaded, @"can't get a load lock on an unloaded queue");

    if(!m_locks)
    {
        m_locks = [[NSMutableArray alloc] init];
    }

    FLLog(@"Added lock");

    FLAssetQueueLoadLock* lock = FLReturnAutoreleased([[FLAssetQueueLoadLock alloc] initWithAssetQueue:self]);
    [m_locks addObject:[NSValue valueWithNonretainedObject:lock]];
    return lock;
}

- (void) releaseLoadLock:(FLAssetQueueLoadLock*) lock
{
    for(NSInteger i = m_locks.count - 1; i >= 0; i--)
    {
        if([[m_locks objectAtIndex:i] nonretainedObjectValue] == lock)
        {
            [m_locks removeObjectAtIndex:i];
            FLLog(@"released lock");
        }
    }
    
    if(m_locks.count == 0)
    {
        [self unload];
        FLLog(@"unloaded asset queue");
    }
}

@end

#import "FLJpegFileImageAsset.h"
#import "FLAssetsLibraryImageAsset.h"

@implementation FLQueuedAsset (FLAssetQueue)

- (id) initWithImageAsset:(id<FLImageAsset>) photo 	   
                assetType:(FLAssetType) assetType
{
	FLAssertIsNotNil(photo);

	if((self = [super init]))
	{
        if(photo)
        {
            if(FLStringIsEmpty(photo.assetUID))
            {
                photo.assetUID = [NSString guidString];
            }
        
            self.assetUID = photo.assetUID;
            self.assetURL = [photo.assetURL absoluteString];
            self.assetTypeValue = assetType;
            self.createdDate = photo.takenDate; 
            if(!self.createdDate)
            {
                self.createdDate = [NSDate date];
            }
            
            self.modifiedDate = self.createdDate;
            self.imageAsset = photo;
        }
	}
	return self;
}


- (void) createAssetIfNeeded
{
	if(!self.assetObject)
	{
		if([self.assetURL hasPrefix:@"file:"])
		{
			self.assetObject = FLReturnAutoreleased([[FLJpegFileImageAsset alloc] initWithFolder:[FLUserSession instance].photoFolder assetUID:self.assetUID]);
		}
		else if([self.assetURL hasPrefix:@"assets-library"])
		{
			self.assetObject = FLReturnAutoreleased([[FLAssetsLibraryImageAsset alloc] initWithAssetURL:[NSURL URLWithString:self.assetURL]]);
		}
	}
}

- (id) initWithAssetUID:(NSString*) assetUID
{
	if((self = [super init]))
	{
		self.assetUID = assetUID;
	}
	
	return self;
} 

+ (id) queuedAsset:(NSString*) assetUID
{
	return FLReturnAutoreleased([[[self class] alloc] initWithAssetUID:assetUID]);
}

- (id<FLImageAsset>) imageAsset
{
	FLAssertIsNotNil(self.assetObject);

	return (id<FLImageAsset>) self.assetObject;
}

- (void) setImageAsset:(id<FLImageAsset>) imageAsset
{
	self.assetObject = (FLAsset*) imageAsset;
}

- (NSString*) displayName
{
	return FLStringIsNotEmpty(self.assetName) ? self.assetName : self.assetFileName;
}


@end

@implementation FLAssetQueueLoader

@synthesize assetQueue = m_assetQueue;
@synthesize error = m_error;
@synthesize wasCancelled = m_cancelled;

- (id) initWithAssetQueue:(FLAssetQueue*) queue
{
    if((self = [super init]))
    {
        m_assetQueue = FLReturnRetained(queue);
    }
    
    return self;
}

+ (FLAssetQueueLoader*) assetQueueLoader:(FLAssetQueue*) queue
{
    return FLReturnAutoreleased([[FLAssetQueueLoader alloc] initWithAssetQueue:queue]);
}

- (void) dealloc
{
    FLRelease(m_queue);
    FLRelease(m_assetQueue);
    FLRelease(m_error);
    FLSuperDealloc();
}

- (void) cancelLoading
{
    m_cancelled = YES;
}

- (void) _loadNextAsset:(NSMutableArray*) queue
           currentIndex:(NSUInteger) currentIndex
        completionBlock:(FLEventCallback) completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
    ^{
        if(currentIndex < queue.count)
        {
            if(m_cancelled)
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
                if(m_cancelled)
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
                        FLAssignObject(m_error, error);
                        
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
            completionBlock:(FLEventCallback) completionBlock
{
    [self _loadNextAsset:assets 
            currentIndex:0 
         completionBlock:FLReturnAutoreleased([completionBlock copy])];
}

- (void) _didFinishLoading:(FLAssetQueueLoaderBlock) callback
{
    [self performBlockOnMainThread:^{
        if(m_cancelled)
        {
            FLAssignObject(m_error, [NSError cancelError]);
        }
        
        if(!m_cancelled && !m_error)
        {
            [m_assetQueue finishLoadingFromDatabase:m_queue];
        }
        
        if(callback)
        {
            callback([m_assetQueue loadLock]);
        }
    }];
}

- (void) beginLoadingFromDatabase:(FLAssetQueueLoaderBlock) completionBlock
{
    if(m_assetQueue.isLoaded)
    {
        if(completionBlock)
        {
            completionBlock([m_assetQueue loadLock]);
        }
        
        return;
    }

    completionBlock = FLReturnAutoreleased([completionBlock copy]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
    ^{
        if(m_cancelled)
        {
            [self _didFinishLoading:completionBlock];
            return;
        }
        
        // TODO: Load with sort. ORDER BY
        NSArray* queue = nil;
        [m_assetQueue.database loadAllObjectsForTypeWithClass:[m_assetQueue queueClass] outObjects:&queue];
        FLAutorelease(queue);

        if(m_cancelled)
        {
            [self _didFinishLoading:completionBlock];
            return;
        }
        
        if(!queue || queue.count == 0)
        {
            FLAssignObject(m_queue, [NSMutableArray array]); 
            [self _didFinishLoading:completionBlock];
        }
        else
        {
            NSMutableArray* newQueue = FLReturnAutoreleased([queue mutableCopy]);
                    
            [self beginLoadingAssets:newQueue completionBlock:^{ 
                
                if(!m_error && !m_cancelled)
                {
                    [newQueue sortUsingComparator:^(id obj1, id obj2) {
                        return [[obj1 positionInQueue] compare:[obj2 positionInQueue]];
                        }];

                    FLAssignObject(m_queue, newQueue); 
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
        m_assetQueue = queue;
    }
    return self;
}

- (void) releaseLock
{
    [m_assetQueue releaseLoadLock:self];
    m_assetQueue = nil;
}

- (void) dealloc
{
    [self releaseLock];
    FLSuperDealloc();
}

- (void) clearQueueReference
{
    m_assetQueue = nil;
}

@end
