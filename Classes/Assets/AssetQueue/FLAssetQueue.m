//
//  FLAssetQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLAssetQueue.h"
#import "FLUploadedAsset.h"
#import "NSObject+Blocks.h"
#import "NSString+GUID.h"
#import "FLDatabase.h"


@interface FLAssetQueue ()
@property (readwrite, strong) FLAssetQueueState* state;
//@property (readwrite, strong) NSMutableArray* locks;
@property (readwrite, strong) NSArray* assets;
@property (readwrite, assign) NSInteger lockCount;
- (void) lock;
- (void) unlock;
@end

@interface FLAssetQueueLock : NSObject {
@private
    __unsafe_unretained FLAssetQueue* _assetQueue;
}
- (id) initWithAssetQueue:(FLAssetQueue*) queue;
+ (id) assetQueueLock:(FLAssetQueue*) queue;
@end

@implementation FLAssetQueueLock

- (id) initWithAssetQueue:(FLAssetQueue*) queue  {
    if((self = [super init])) {
        _assetQueue = queue;
        [_assetQueue lock];
    }
    return self;
}

+ (id) assetQueueLock:(FLAssetQueue*) queue {
    return autorelease_([[[self class] alloc] initWithAssetQueue:queue]);
}

- (void) dealloc {
    [_assetQueue unlock];
    super_dealloc_();
}
@end

@implementation FLAssetQueue

synthesize_(lockCount);
synthesize_(queueUID);
synthesize_(assets);
synthesize_(state);
//synthesize_(locks);

FLAssertDefaultInitNotCalled_v(nil);

- (id) initWithQueueUID:(NSString*) uid
{
	if((self = [super init]))
	{	
		FLAssertIsNotNil_v(uid, nil);
		_queueUID = retain_(uid);
	}
	
	return self;
}

- (void) unload {
}

dealloc_(
    
        [_state release];
        [_queueUID release];
        [_assets release];
//        [_locks release];
    )


- (void) unlock {
    --self.lockCount;
    if(self.lockCount == 0) {
        [self unload];
    }
}

- (void) lock {
    ++self.lockCount;
}

- (FLDatabase*) database {
    return nil;
}

- (void) openService {
    FLConfirmNotNil_(self.database);
    
    self.state = nil;
    
    FLAssetQueueState* input = [FLAssetQueueState assetQueueState];
    input.queueUID = _queueUID;
    
    FLAssetQueueState* state = [self.database loadObject:input];
    if(!state) {
        state = input;
        state.firstQueuePositionValue = 0;
        state.lastQueuePositionValue = 1;
        state.sortOrder = FLAssetQueueSortOrderOldestFirst;
    }
    
    self.state = state;

    [super openService];
}

- (void) closeService {
    if(self.assets)
    {
        @synchronized(self) {
            self.assets = nil;
            
//            for(NSValue* value in _locks)
//            {
//                [[value nonretainedObjectValue] clearQueueReference];
//            }
//            
//            FLReleaseWithNil_(_locks);
        }
    }

    [super closeService];
}

- (NSUInteger) count {
    FLAssertNotNil_(self.database);

    if(_assets) {
        return _assets.count;
    }
    
    return	[self.database rowCountForTable:[[self queueClass] sharedDatabaseTable]];
}

- (unsigned long) totalAssetsAdded {
	return _state.totalAssetsAddedValue;
}

- (FLAssetQueueSortOrder) sortOrder {
	return _state.sortOrderValue;
}

- (BOOL) isLoaded {
	return _assets != nil;
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

    if(_assets && _assets.count)
    {
        @synchronized(self) {

            _state.sortOrderValue = sortOrder;

            if(sortOrder == FLAssetQueueSortOrderNewestFirst)
            {
                [_assets sortUsingComparator:^(id obj1, id obj2) { return [[obj2 performSelector:selector] compare:[obj1 performSelector:selector]]; }];
            }
            else
            {
                [_assets sortUsingComparator:^(id obj1, id obj2) { return [[obj1 performSelector:selector] compare:[obj2 performSelector:selector]]; }];
            }

            // normalize list and save it.

            int sortId = 0; // _assets.count;
            for(FLQueuedAsset* photo in _assets) 
            {
                photo.positionInQueueValue = ++sortId;
            }

            _state.firstQueuePosition = [[_assets firstObject] positionInQueue];
            _state.lastQueuePosition = [[_assets lastObject] positionInQueue];
        
            [self saveQueueToDatabase];
        }
    }
}

#pragma GCC diagnostic pop


- (void) exchangeAssetsInSort:(NSUInteger) lhs rhs:(NSUInteger) rhs
{
	FLQueuedAsset* obj1 = nil;
   	FLQueuedAsset* obj2 = nil;

    FLDatabase* database = self.database;
	FLAssertIsNotNil_v(database, nil);

	@synchronized(self) {
		obj1 = [_assets objectAtIndex:lhs];
		obj2 = [_assets objectAtIndex:rhs];

		NSNumber* temp = retain_(obj1.positionInQueue);
		obj1.positionInQueue = obj2.positionInQueue;
		obj2.positionInQueue = temp;
		
        release_(temp);
		
        [_assets exchangeObjectAtIndex:lhs withObjectAtIndex:rhs];
    }

    [database saveObject:obj1];
    [database saveObject:obj2];

    [self didChangeAssetQueue];
} 

- (NSUInteger) indexOfAsset:(FLQueuedAsset*) aAsset
{
	@synchronized(self) {
		NSUInteger idx = 0;
		for(FLQueuedAsset* asset in _assets)
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
		FLAssert_v(idx >= 0 && idx < _assets.count, @"bad idx");
		
		if(idx < _assets.count)
		{
			return [_assets objectAtIndex:idx];
		}
	}
	
	return nil;
}

- (void) deleteAsset:(FLQueuedAsset*) asset
{	
    FLAssertIsNotNil_v(asset, nil);
    FLAssertIsNotNil_v(asset.assetObject, nil);

    if(_assets)
    {
        @synchronized(self) {
            NSUInteger idx = [self indexOfAsset:asset];
            if(idx != NSNotFound)
            {
                [_assets removeObjectAtIndex:idx];
            }
        }
    }

    asset.queueUID = self.queueUID;
    [asset.assetObject deleteFromAssetStorage];
    [self.database deleteObject:asset];
    [self didChangeAssetQueue];
}

- (void) deleteAssetAtIndex:(NSUInteger) idx
{
    FLAssert_v(self.isLoaded, @"queue not loaded");
    FLAssert_v(idx >= 0 && idx < _assets.count, @"bad idx");

    FLQueuedAsset* asset = nil;
		
	@synchronized(self) {
		asset = [_assets objectAtIndex:idx];
		[_assets removeObjectAtIndex:idx];
    }

    [asset.assetObject deleteFromAssetStorage];
	[self.database deleteObject:asset];
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
        
        FLDatabase* database = self.database;
        FLAssertIsNotNil_v(database, nil);

        for(int i = _assets.count - 1; i >= 0; i--)
        {
            FLQueuedAsset* asset = [_assets objectAtIndex:i];
            if( type == FLAssetTypeNone ||
                type == (FLAssetType) asset.assetTypeValue) 
            {
                [asset.assetObject deleteFromAssetStorage];
                [database deleteObject:asset];
                [_assets removeObjectAtIndex:i];
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
			
			if(_assets)
			{
				[_assets addObject:asset];
			}
		break;
		
		case FLAssetQueueSortOrderNewestFirst:
			_state.firstQueuePositionValue = _state.firstQueuePositionValue - 1;
			asset.positionInQueue = _state.firstQueuePosition;
			
			if(_assets)
			{
				[_assets insertObject:asset atIndex:0];
			}
		break;
	}
	_state.totalAssetsAddedValue = _state.totalAssetsAddedValue + 1;
}

- (void) batchAddAssets:(NSArray*) assets
{
    NSDate* date = [[NSDate alloc] init];

    FLDatabase* database = self.database;
	FLAssertIsNotNil_v(database, nil);
		
	@synchronized(self) {
		for(FLQueuedAsset* asset in assets)
		{
			[self _addAssetToQueue:asset];
			asset.queueUID = self.queueUID;
			asset.queuedDate = date;
		}
    }

	release_(date);
    
    [database batchSaveObjects:assets];
    [database saveObject:_state];
    
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
    release_(date);

    FLDatabase* database = self.database;
	FLAssertIsNotNil_v(database, nil);
    
    [self saveAsset:asset];
    [database saveObject:_state];

    [self didChangeAssetQueue];
	
}

- (Class) queueClass
{
	return [FLQueuedAsset class];
}

- (void) beginLoadingFirstAsset:(FLAssetQueueLoadAssetBlock) completionBlock {
    completionBlock = autorelease_([completionBlock copy]);
    
    FLDatabase* database = self.database;
	FLAssertIsNotNil_v(database, nil);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), 
    ^{
        FLDatabaseTable* table = [[self queueClass] sharedDatabaseTable];
        FLDatabaseIterator* statement = [FLDatabaseIterator databaseIterator:database table:table];
        
        __block FLQueuedAsset* asset = nil;
        @try 
        {
            [statement selectObjects:^(BOOL* stop){ // LIMIT 1
                    [statement appendFormat:@"SELECT * FROM %@ ORDER BY %@ ASC LIMIT 1",
                            table.tableName,
                            FLDatabaseNameEncode([FLQueuedAsset positionInQueueKey])];

                }
                didSelectObject:^(id object, BOOL* stop) {
                    FLRetainObject_(asset, object);
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

- (void) didUploadAsset:(FLQueuedAsset*) asset {
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
    FLAssertNotNil_(self.database);
    [self.database	saveObject:uploadedAsset];
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
		FLQueuedAsset* oldAsset = [_assets objectAtIndex:idx];
		asset.positionInQueue = oldAsset.positionInQueue;
		[_assets replaceObjectAtIndex:idx withObject:asset];
	}	
	
    [self saveAsset:asset];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id *)stackbuf count:(NSUInteger)len
{
	if(state->state >= _assets.count) {
		return 0;
	}
	
	NSRange range = NSMakeRange(state->state, len);
	if(range.length + range.location >= _assets.count) {
		range.length -= ((range.length + range.location) - _assets.count);
	}
	
	__unsafe_unretained id objects[len];
	
	[_assets getObjects:objects range:range];
	
	for(NSUInteger i = 0; i < range.length; i++) {
		stackbuf[i] = objects[i];
	}
	
	state->state = state->state + range.length;
	state->itemsPtr = stackbuf;
    
// TODO: add a real mutationsPtr here.    
	state->mutationsPtr = bridge_(void*, self);

	return range.length;
}

- (void) saveQueueToDatabase {
    FLAssertNotNil_(self.database);

	@synchronized(self) {
        if(_assets)
        {
            [self.database batchSaveObjects:_assets];
        }
        if(_state)
        {
            [self.database saveObject:_state];
        }
    }
	[self didChangeAssetQueue];
}

- (void) finishLoadingFromDatabase:(NSMutableArray*) queue
{
    @synchronized(self) {
        FLRetainObject_(_assets, queue);
    }
}

- (id) loadLock {
    FLAssert_v(self.isLoaded, @"can't get a load lock on an unloaded queue");
//
//    if(!_locks)
//    {
//        _locks = [[NSMutableArray alloc] init];
//    }
//
//    FLLog(@"Added lock");
//
//    FLAssetQueueLoadLock* lock = autorelease_([[FLAssetQueueLoadLock alloc] initWithAssetQueue:self]);
//    [_locks addObject:[NSValue valueWithNonretainedObject:lock]];
    return [FLAssetQueueLock assetQueueLock:self];
}

//- (void) releaseLoadLock:(FLAssetQueueLoadLock*) lock
//{
//    for(NSInteger i = _locks.count - 1; i >= 0; i--)
//    {
//        if([[_locks objectAtIndex:i] nonretainedObjectValue] == lock)
//        {
//            [_locks removeObjectAtIndex:i];
//            FLLog(@"released lock");
//        }
//    }
//    
//    if(_locks.count == 0)
//    {
//        [self unload];
//        FLLog(@"unloaded asset queue");
//    }
//}

@end

//#import "FLAssetsLibraryImageAsset.h"

@interface FLAssetQueueLoader ()
@property (readwrite, strong) FLAssetQueue* assetQueue;
@property (readwrite, strong) NSMutableArray* assets;

@end

@implementation FLAssetQueueLoader

@synthesize wasCancelled = _cancelled;

synthesize_(assets)
synthesize_(assetQueue)
synthesize_(error);

- (id) initWithAssetQueue:(FLAssetQueue*) queue {
    if((self = [super init])) {
        self.assetQueue = queue;
    }
    
    return self;
}

+ (FLAssetQueueLoader*) assetQueueLoader:(FLAssetQueue*) queue {
    return autorelease_([[FLAssetQueueLoader alloc] initWithAssetQueue:queue]);
}

dealloc_ (
    release_(_assets);
    release_(_assetQueue);
    release_(_error);
)

- (void) cancelLoading {
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
                        FLRetainObject_(_error, error);
                        
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
         completionBlock:autorelease_([completionBlock copy])];
}

- (void) _didFinishLoading:(FLAssetQueueLoaderBlock) callback
{
    [self performBlockOnMainThread:^{
        if(_cancelled)
        {
            FLRetainObject_(_error, [NSError cancelError]);
        }
        
        if(!_cancelled && !_error)
        {
            [_assetQueue finishLoadingFromDatabase:_assets];
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

    completionBlock = autorelease_([completionBlock copy]);
    
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
        mrc_autorelease_(queue);

        if(_cancelled)
        {
            [self _didFinishLoading:completionBlock];
            return;
        }
        
        if(!queue || queue.count == 0)
        {
            self.assets = [NSMutableArray array];
            [self _didFinishLoading:completionBlock];
        }
        else
        {
            NSMutableArray* newQueue = autorelease_([queue mutableCopy]);
                    
            [self beginLoadingAssets:newQueue completionBlock:^{ 
                
                if(!_error && !_cancelled)
                {
                    [newQueue sortUsingComparator:^(id obj1, id obj2) {
                        return [[obj1 positionInQueue] compare:[obj2 positionInQueue]];
                    }];
                    
                    self.assets = newQueue;
                }
                
                [self _didFinishLoading:completionBlock];
            }];
        }
    });
}

@end

