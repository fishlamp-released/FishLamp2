//
//  GtAssetQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetQueue.h"
#import "GtUploadedAsset.h"

#import "GtUserSession.h"
#import "NSObject+Blocks.h"

@interface GtAssetQueueLoadLock (Internal)
- (id) initWithAssetQueue:(GtAssetQueue*) queue;
- (void) clearQueueReference;
@end

@interface GtAssetQueue ()
- (void) unload;
@end

@implementation GtAssetQueue

@synthesize queueUID = m_queueUID;
@synthesize database = m_database;
@synthesize assets = m_queue;

GtAssertDefaultInitNotCalled();

- (id) initWithQueueUID:(NSString*) uid
{
	if((self = [super init]))
	{	
		GtAssertNotNil(uid);
		m_queueUID = GtRetain(uid);
	}
	
	return self;
}

- (void) dealloc
{
    [self unload];
	GtRelease(m_state);
	GtRelease(m_queueUID);
	GtRelease(m_queue);
	GtRelease(m_database);
    GtRelease(m_locks);
	GtSuperDealloc();
}

- (void) setDatabase:(GtObjectDatabase*) database
{
    [self unload];
	GtReleaseWithNil(m_state);
    
	GtAssignObject(m_database, database);
	if(m_database)
	{
		GtAssetQueueState* input = [GtAssetQueueState assetQueueState];
		input.queueUID = m_queueUID;
		[m_database loadObject:input outputObject:&m_state];
		if(!m_state)
		{
			m_state = GtRetain(input);
			m_state.firstQueuePositionValue = 0;
			m_state.lastQueuePositionValue = 1;
			m_state.sortOrder = GtAssetQueueSortOrderOldestFirst;
		}
	}
}

- (NSUInteger) count
{
    if(m_queue)
    {
        return m_queue.count;
    }
    
    return	[[GtUserSession instance].documentsDatabase rowCountForTable:[[self queueClass] sharedSqliteTable]];
}

- (unsigned long) totalAssetsAdded
{
	return m_state.totalAssetsAddedValue;
}

- (GtAssetQueueSortOrder) sortOrder
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
            GtReleaseWithNil(m_queue);
            
            for(NSValue* value in m_locks)
            {
                [[value nonretainedObjectValue] clearQueueReference];
            }
            
            GtReleaseWithNil(m_locks);
        }
    }
}

- (void) saveAsset:(GtQueuedAsset*) asset
{
    GtAssertNotNil(self.database);

    asset.queueUID = self.queueUID;
    [self.database saveObject:asset];
}

- (void) sort:(GtAssetQueueSortOrder) sortOrder assetSortPropertySelector:(SEL) selector
{
    GtAssertNotNil(self.database);

    if(m_queue && m_queue.count)
    {
        @synchronized(self) {

            m_state.sortOrderValue = sortOrder;

            if(sortOrder == GtAssetQueueSortOrderNewestFirst)
            {
                [m_queue sortUsingComparator:^(id obj1, id obj2) { return [[obj2 performSelector:selector] compare:[obj1 performSelector:selector]]; }];
            }
            else
            {
                [m_queue sortUsingComparator:^(id obj1, id obj2) { return [[obj1 performSelector:selector] compare:[obj2 performSelector:selector]]; }];
            }

            // normalize list and save it.

            int sortId = 0; // m_queue.count;
            for(GtQueuedAsset* photo in m_queue) 
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
	GtQueuedAsset* obj1 = nil;
   	GtQueuedAsset* obj2 = nil;
	GtAssertNotNil(self.database);

	@synchronized(self) {
		obj1 = [m_queue objectAtIndex:lhs];
		obj2 = [m_queue objectAtIndex:rhs];

		NSNumber* temp = GtRetain(obj1.positionInQueue);
		obj1.positionInQueue = obj2.positionInQueue;
		obj2.positionInQueue = temp;
		
        GtRelease(temp);
		
        [m_queue exchangeObjectAtIndex:lhs withObjectAtIndex:rhs];
    }

    [m_database saveObject:obj1];
    [m_database saveObject:obj2];

    [self didChangeAssetQueue];
} 

- (NSUInteger) indexOfAsset:(GtQueuedAsset*) aAsset
{
	@synchronized(self) {
		NSUInteger idx = 0;
		for(GtQueuedAsset* asset in m_queue)
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
		GtAssert(self.isLoaded, @"queue not loaded");
		GtAssert(idx >= 0 && idx < m_queue.count, @"bad idx");
		
		if(idx < m_queue.count)
		{
			return [m_queue objectAtIndex:idx];
		}
	}
	
	return nil;
}

- (void) deleteAsset:(GtQueuedAsset*) asset
{	
    GtAssertNotNil(asset);
    GtAssertNotNil(asset.assetObject);

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
    GtAssert(self.isLoaded, @"queue not loaded");
    GtAssert(idx >= 0 && idx < m_queue.count, @"bad idx");

    GtQueuedAsset* asset = nil;
		
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
	[self removeAssetsByType:GtAssetTypeNone];
}

- (void) removeAssetsByType:(GtAssetType) type;
{
	@synchronized(self) {
    
		GtAssert(self.isLoaded, @"queue not loaded");
        
        for(int i = m_queue.count - 1; i >= 0; i--)
        {
            GtQueuedAsset* asset = [m_queue objectAtIndex:i];
            if( type == GtAssetTypeNone ||
                type == (GtAssetType) asset.assetTypeValue) 
            {
                [asset.assetObject deleteFromAssetStorage];
                [m_database deleteObject:asset];
                [m_queue removeObjectAtIndex:i];
            }
        }
    }    
    
    [self didChangeAssetQueue];
}

- (void) _addAssetToQueue:(GtQueuedAsset*) asset
{
	switch(self.sortOrder)
	{
		case GtAssetQueueSortOrderOldestFirst:
			m_state.lastQueuePositionValue = m_state.lastQueuePositionValue + 1;
			asset.positionInQueue = m_state.lastQueuePosition;
			
			if(m_queue)
			{
				[m_queue addObject:asset];
			}
		break;
		
		case GtAssetQueueSortOrderNewestFirst:
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
		for(GtQueuedAsset* asset in assets)
		{
			[self _addAssetToQueue:asset];
			asset.queueUID = self.queueUID;
			asset.queuedDate = date;
		}
    }

	GtRelease(date);
    
    [m_database batchSaveObjects:assets];
    [m_database saveObject:m_state];
    
    [self didChangeAssetQueue];
}

- (void) didChangeAssetQueue
{
}

- (void) addAsset:(GtQueuedAsset*) asset
{
	@synchronized(self) {
		[self _addAssetToQueue:asset];
	}

    NSDate* date = [[NSDate alloc] init];
    asset.queuedDate = date;
    GtRelease(date);
    
    [self saveAsset:asset];
    [m_database saveObject:m_state];

    [self didChangeAssetQueue];
	
}

- (Class) queueClass
{
	return [GtQueuedAsset class];
}

- (void) beginLoadingFirstAsset:(GtAssetQueueLoadAssetBlock) completionBlock
{
    completionBlock = GtReturnAutoreleased([completionBlock copy]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
    ^{

        GtObjectDatabaseIterator* iterator = GtReturnAutoreleased([[GtObjectDatabaseIterator alloc] initWithObjectDatabase:m_database]);
        
        GtSqliteTable* table = [[self queueClass] sharedSqliteTable];
        [m_database createTableIfNeeded:table];
        
        __block GtQueuedAsset* asset = nil;
        @try 
        {
            [iterator selectObjectsInTable:table 
                willPrepareBlock:^{ // LIMIT 1
                    [iterator prepareStatement:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY %@ ASC LIMIT 1", table.tableName, GtSqliteNameEncode([GtQueuedAsset positionInQueueKey])]];
                    return YES;
                }
                didSelectObjectBlock:^(id object) {
                    GtAssignObject(asset, object);
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



- (void) didUploadAsset:(GtQueuedAsset*) asset
{
    GtUploadedAsset* uploadedAsset = [GtUploadedAsset uploadedAsset];
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
    GtSqliteTable* table = [[self queueClass] sharedSqliteTable];
    GtSqliteStatement* statement = [[GtSqliteStatement alloc] initWithSqliteDatabase:self.database];
    @try
    {
        [self.database createTableIfNeeded:table];
    
        [statement prepareStatement:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=?", 
            GtSqliteNameEncode(@"assetUID"),
            GtSqliteNameEncode(table.tableName),
            GtSqliteNameEncode(@"assetURL")]];
        
        [assetURL bindToStatement:statement parameterIndex:1];

        while(statement.willStep)
        {
            NSDictionary* row = [statement step];
            if(row && row.count)
            {
                return [row objectForKey:GtSqliteNameEncode(@"assetUID")] != nil;
            }
        }
    }
    @finally
    {
        [statement finalizeStatement];
        GtRelease(statement);
    
    }
	
	return NO;
}

- (BOOL) assetWasUploaded:(NSString*) assetURL
{
    GtSqliteTable* table = [[GtUploadedAsset class] sharedSqliteTable];
    GtSqliteStatement* statement = [[GtSqliteStatement alloc] initWithSqliteDatabase:self.database];
    @try
    {
        [self.database createTableIfNeeded:table];
    
        [statement prepareStatement:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=?", 
            GtSqliteNameEncode(@"assetUID"),
            GtSqliteNameEncode(table.tableName),
            GtSqliteNameEncode(@"assetURL")]];
        
        [assetURL bindToStatement:statement parameterIndex:1];

        while(statement.willStep)
        {
            NSDictionary* row = [statement step];
            if(row && row.count)
            {
                return [row objectForKey:GtSqliteNameEncode(@"assetUID")] != nil;
            }
        }
    }
    @finally
    {
        [statement finalizeStatement];
        GtRelease(statement);
    
    }
	
    return NO;	
}

- (void) replaceAssetAtIndex:(NSUInteger) idx asset:(GtQueuedAsset*) asset
{
	GtAssert(self.isLoaded, @"queue not loaded");

	@synchronized(self) {
		GtQueuedAsset* oldAsset = [m_queue objectAtIndex:idx];
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
        GtAssignObject(m_queue, queue);
    }
}

- (GtAssetQueueLoadLock*) loadLock
{
    GtAssert(self.isLoaded, @"can't get a load lock on an unloaded queue");

    if(!m_locks)
    {
        m_locks = [[NSMutableArray alloc] init];
    }

    GtLog(@"Added lock");

    GtAssetQueueLoadLock* lock = GtReturnAutoreleased([[GtAssetQueueLoadLock alloc] initWithAssetQueue:self]);
    [m_locks addObject:[NSValue valueWithNonretainedObject:lock]];
    return lock;
}

- (void) releaseLoadLock:(GtAssetQueueLoadLock*) lock
{
    for(NSInteger i = m_locks.count - 1; i >= 0; i--)
    {
        if([[m_locks objectAtIndex:i] nonretainedObjectValue] == lock)
        {
            [m_locks removeObjectAtIndex:i];
            GtLog(@"released lock");
        }
    }
    
    if(m_locks.count == 0)
    {
        [self unload];
        GtLog(@"unloaded asset queue");
    }
}

@end

#import "GtJpegFileImageAsset.h"
#import "GtAssetsLibraryImageAsset.h"

@implementation GtQueuedAsset (GtAssetQueue)

- (id) initWithImageAsset:(id<GtImageAsset>) photo 	   
                assetType:(GtAssetType) assetType
{
	GtAssertNotNil(photo);

	if((self = [super init]))
	{
        if(photo)
        {
            if(GtStringIsEmpty(photo.assetUID))
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
			self.assetObject = GtReturnAutoreleased([[GtJpegFileImageAsset alloc] initWithFolder:[GtUserSession instance].photoFolder assetUID:self.assetUID]);
		}
		else if([self.assetURL hasPrefix:@"assets-library"])
		{
			self.assetObject = GtReturnAutoreleased([[GtAssetsLibraryImageAsset alloc] initWithAssetURL:[NSURL URLWithString:self.assetURL]]);
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
	return GtReturnAutoreleased([[[self class] alloc] initWithAssetUID:assetUID]);
}

- (id<GtImageAsset>) imageAsset
{
	GtAssertNotNil(self.assetObject);

	return (id<GtImageAsset>) self.assetObject;
}

- (void) setImageAsset:(id<GtImageAsset>) imageAsset
{
	self.assetObject = (GtAsset*) imageAsset;
}

- (NSString*) displayName
{
	return GtStringIsNotEmpty(self.assetName) ? self.assetName : self.assetFileName;
}


@end

@implementation GtAssetQueueLoader

@synthesize assetQueue = m_assetQueue;
@synthesize error = m_error;
@synthesize wasCancelled = m_cancelled;

- (id) initWithAssetQueue:(GtAssetQueue*) queue
{
    if((self = [super init]))
    {
        m_assetQueue = GtRetain(queue);
    }
    
    return self;
}

+ (GtAssetQueueLoader*) assetQueueLoader:(GtAssetQueue*) queue
{
    return GtReturnAutoreleased([[GtAssetQueueLoader alloc] initWithAssetQueue:queue]);
}

- (void) dealloc
{
    GtRelease(m_queue);
    GtRelease(m_assetQueue);
    GtRelease(m_error);
    GtSuperDealloc();
}

- (void) cancelLoading
{
    m_cancelled = YES;
}

- (void) _loadNextAsset:(NSMutableArray*) queue
           currentIndex:(NSUInteger) currentIndex
        completionBlock:(GtBlock) completionBlock
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
        
            GtQueuedAsset* asset = [queue objectAtIndex:currentIndex]; 
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
                        GtAssignObject(m_error, error);
                        
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
            completionBlock:(GtBlock) completionBlock
{
    [self _loadNextAsset:assets 
            currentIndex:0 
         completionBlock:GtReturnAutoreleased([completionBlock copy])];
}

- (void) _didFinishLoading:(GtAssetQueueLoaderBlock) callback
{
    [self performBlockOnMainThread:^{
        if(m_cancelled)
        {
            GtAssignObject(m_error, [NSError cancelError]);
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

- (void) beginLoadingFromDatabase:(GtAssetQueueLoaderBlock) completionBlock
{
    if(m_assetQueue.isLoaded)
    {
        if(completionBlock)
        {
            completionBlock([m_assetQueue loadLock]);
        }
        
        return;
    }

    completionBlock = GtReturnAutoreleased([completionBlock copy]);
    
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
        GtAutorelease(queue);

        if(m_cancelled)
        {
            [self _didFinishLoading:completionBlock];
            return;
        }
        
        if(!queue || queue.count == 0)
        {
            GtAssignObject(m_queue, [NSMutableArray array]); 
            [self _didFinishLoading:completionBlock];
        }
        else
        {
            NSMutableArray* newQueue = GtReturnAutoreleased([queue mutableCopy]);
                    
            [self beginLoadingAssets:newQueue completionBlock:^{ 
                
                if(!m_error && !m_cancelled)
                {
                    [newQueue sortUsingComparator:^(id obj1, id obj2) {
                        return [[obj1 positionInQueue] compare:[obj2 positionInQueue]];
                        }];

                    GtAssignObject(m_queue, newQueue); 
                }
                
                [self _didFinishLoading:completionBlock];
            }];
        }
    });
}

@end

@implementation GtAssetQueueLoadLock

- (id) initWithAssetQueue:(GtAssetQueue*) queue
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
    GtSuperDealloc();
}

- (void) clearQueueReference
{
    m_assetQueue = nil;
}

@end
