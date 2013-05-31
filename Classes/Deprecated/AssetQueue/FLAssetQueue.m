//
//  FLAssetQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/16/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "FLAssetQueue.h"
#import "FLUploadedAsset.h"
#import "NSObject+Blocks.h"
#import "NSString+GUID.h"
#import "FLDatabase.h"


@interface FLAssetQueue ()
@property (readwrite, strong) FLAssetQueueState* state;
@property (readwrite, strong) NSArray* assets;
@property (readwrite, strong) FLDatabase* database;

#if QUEUE_LOCKING
//@property (readwrite, strong) NSMutableArray* locks;
@property (readwrite, assign) NSInteger lockCount;
- (void) lock;
- (void) unlock;
#endif

@end

#if QUEUE_LOCKING
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
    return FLAutorelease([[[self class] alloc] initWithAssetQueue:queue]);
}

- (void) dealloc {
    [_assetQueue unlock];
    FLSuperDealloc();
}
@end
#endif

@implementation FLAssetQueue

@synthesize database = _database;
#if QUEUE_LOCKING
@synthesize lockCount = _lockCount;
#endif
@synthesize assets = _assets;
@synthesize state = _state;
@synthesize queueUID = _queueUID;


//synthesize_(locks);

FLAssertDefaultInitNotCalledWithComment(@"hello");

- (id) initWithQueueUID:(NSString*) uid
{
	if((self = [super init]))
	{	
		FLAssertIsNotNilWithComment(uid, nil);
		_queueUID = FLRetain(uid);
	}
	
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_database release];
    [_state release];
    [_queueUID release];
    [_assets release];
//        [_locks release];
    [super dealloc];
}
#endif

#if QUEUE_LOCKING
- (void) unlock {
    --self.lockCount;
    if(self.lockCount == 0) {
        [self unloadQueue];
    }
}

- (void) lock {
    ++self.lockCount;
}
#endif

- (void) unloadQueue  {

    if(self.assets)
    {
        @synchronized(self) {
            self.assets = nil;
            
//            for(NSValue* value in _locks)
//            {
//                [[value nonretainedObjectValue] clearQueueReference];
//            }
//            
//            FLReleaseWithNil(_locks);

            self.state = nil;
            self.database = nil;
        }
    }
}


- (void) loadQueue:(FLDatabase*) database {
    self.database = database;

    FLConfirmNotNil(self.database);
    
    self.state = nil;
    
    FLAssetQueueState* input = [FLAssetQueueState assetQueueState];
    input.queueUID = _queueUID;
    
    FLAssetQueueState* state = [self.database readObject:input];
    if(!state) {
        state = input;
        state.firstQueuePositionValue = 0;
        state.lastQueuePositionValue = 1;
        state.sortOrder = FLAssetQueueSortOrderOldestFirst;
    }
    
    self.state = state;
}

- (NSUInteger) count {
    FLAssertNotNil(self.database);

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
    FLAssertIsNotNilWithComment(self.database, nil);

    asset.queueUID = self.queueUID;
    [self.database writeObject:asset];
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) sort:(FLAssetQueueSortOrder) sortOrder assetSortPropertySelector:(SEL) selector
{
    FLAssertIsNotNilWithComment(self.database, nil);

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
	FLAssertIsNotNilWithComment(database, nil);

	@synchronized(self) {
		obj1 = [_assets objectAtIndex:lhs];
		obj2 = [_assets objectAtIndex:rhs];

		NSNumber* temp = FLRetain(obj1.positionInQueue);
		obj1.positionInQueue = obj2.positionInQueue;
		obj2.positionInQueue = temp;
		
        FLRelease(temp);
		
        [_assets exchangeObjectAtIndex:lhs withObjectAtIndex:rhs];
    }

    [database writeObject:obj1];
    [database writeObject:obj2];

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
		FLAssertWithComment(self.isLoaded, @"queue not loaded");
		FLAssertWithComment(idx >= 0 && idx < _assets.count, @"bad idx");
		
		if(idx < _assets.count)
		{
			return [_assets objectAtIndex:idx];
		}
	}
	
	return nil;
}

- (void) deleteAsset:(FLQueuedAsset*) asset
{	
    FLAssertIsNotNilWithComment(asset, nil);
    FLAssertIsNotNilWithComment(asset.assetObject, nil);

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
    
FIXME("asset q")
//    [asset.assetObject deleteFromAssetStorage];
//    [self.database deleteObject:asset];
    [self didChangeAssetQueue];
}

- (void) deleteAssetAtIndex:(NSUInteger) idx
{
#if REFACTOR
    FLAssertWithComment(self.isLoaded, @"queue not loaded");
    FLAssertWithComment(idx >= 0 && idx < _assets.count, @"bad idx");

    FLQueuedAsset* asset = nil;
		
	@synchronized(self) {
		asset = [_assets objectAtIndex:idx];
		[_assets removeObjectAtIndex:idx];
    }

FIXME("asset q")

//    [asset.assetObject deleteFromAssetStorage];
//	[self.database deleteObject:asset];
    [self didChangeAssetQueue];
#endif    
}

- (void) removeAllAssets
{
	[self removeAssetsByType:FLAssetTypeNone];
}

- (void) removeAssetsByType:(FLAssetType) type
{
	@synchronized(self) {
    
		FLAssertWithComment(self.isLoaded, @"queue not loaded");
        
        FLDatabase* database = self.database;
        FLAssertIsNotNilWithComment(database, nil);

        for(int i = _assets.count - 1; i >= 0; i--)
        {
            FLQueuedAsset* asset = [_assets objectAtIndex:i];
            if( type == FLAssetTypeNone ||
                type == (FLAssetType) asset.assetTypeValue) 
            {
FIXME("asset q")

//                [asset.assetObject deleteFromAssetStorage];
//                [database deleteObject:asset];
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
    NSDate* date = [NSDate date];

    FLDatabase* database = self.database;
	FLAssertIsNotNilWithComment(database, nil);
		
	@synchronized(self) {
		for(FLQueuedAsset* asset in assets)
		{
			[self _addAssetToQueue:asset];
			asset.queueUID = self.queueUID;
			asset.queuedDate = date;
		}
    }

	
    [database writeObjectsInArray:assets];
    [database writeObject:_state];
    
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

    FLDatabase* database = self.database;
	FLAssertIsNotNilWithComment(database, nil);
    
    [self saveAsset:asset];
    [database writeObject:_state];

    [self didChangeAssetQueue];
	
}

- (Class) queueClass
{
	return [FLQueuedAsset class];
}

- (void) beginLoadingFirstAsset:(FLAssetQueueLoadAssetBlock) completionBlock {

FIXME("load first asset")

/*
    completionBlock = FLAutorelease([completionBlock copy]);
    
    FLDatabase* database = self.database;
	FLAssertIsNotNilWithComment(database, nil);
    
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
                    FLSetObjectWithRetain(asset, object);
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
*/    
}

- (void) didUploadAsset:(FLQueuedAsset*) asset {
    FLUploadedAsset* uploadedAsset = [FLUploadedAsset uploadedAsset];
    uploadedAsset.queueUID = asset.queueUID;
    uploadedAsset.assetName = asset.displayName;
    uploadedAsset.assetType = asset.assetType;
    uploadedAsset.assetUID = asset.assetUID;
    uploadedAsset.assetURL = asset.assetURL;
FIXME("compatability")    
    uploadedAsset.thumbnail = nil; // [asset.assetObject thumbnailImage];
    uploadedAsset.uploadDestinationId = asset.uploadDestinationId;
    uploadedAsset.uploadDestinationName = asset.uploadDestinationName;
    uploadedAsset.uploadDestinationURL = asset.uploadDestinationURL;
    uploadedAsset.uploadedAssetId = asset.uploadedAssetId;
    uploadedAsset.uploadedAssetURL = asset.uploadedAssetURL;
    uploadedAsset.uploadedDate = [NSDate date];
    FLAssertNotNil(self.database);
    [self.database	writeObject:uploadedAsset];
    [self deleteAsset:asset];
}

- (BOOL) assetForURL:(NSString*) assetUrl existsInTable:(FLDatabaseTable*) table {

    __block BOOL foundIt = NO;

    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    [statement appendString:SQL_SELECT andString:FLDatabaseNameEncode(@"assetUID")];
    [statement appendString:SQL_FROM andString:table.tableName];
    [statement appendString:SQL_WHERE];
    [statement appendObject:assetUrl comparedToString:FLDatabaseNameEncode(@"assetURL") withComparer:SQL_EQUAL];
    
    statement.rowResultBlock = ^(NSDictionary* row, BOOL* stop) {
        foundIt = [row objectForKey:FLDatabaseNameEncode(@"assetUID")] != nil;
        if(foundIt) {
            *stop = YES;
        }
    };
    
    [self.database executeStatement:statement];

//    FLDatabaseIterator* statement = [FLDatabaseIterator databaseIterator:self.database table:table];
//    [statement appendString:SQL_SELECT andString:FLDatabaseNameEncode(@"assetUID")];
//    [statement appendString:SQL_FROM andString:table.tableName];
//    [statement appendString:SQL_WHERE];
//    [statement appendObject:assetUrl comparedToString:FLDatabaseNameEncode(@"assetURL") withComparer:SQL_EQUAL];
//
//    [statement execute:^(NSDictionary* row, BOOL* stop) {
//        foundIt = [row objectForKey:FLDatabaseNameEncode(@"assetUID")] != nil;
//        if(foundIt) {
//            *stop = YES;
//        }
//    }];

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
	FLAssertWithComment(self.isLoaded, @"queue not loaded");

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
    FLAssertNotNil(self.database);

	@synchronized(self) {
        if(_assets)
        {
            [self.database writeObjectsInArray:_assets];
        }
        if(_state)
        {
            [self.database writeObject:_state];
        }
    }
	[self didChangeAssetQueue];
}

- (void) finishLoadingFromDatabase:(NSMutableArray*) queue
{
    @synchronized(self) {
        FLSetObjectWithRetain(_assets, queue);
    }
}

#if QUEUE_LOCKING
- (id) loadLock {
    FLAssertWithComment(self.isLoaded, @"can't get a load lock on an unloaded queue");
//
//    if(!_locks)
//    {
//        _locks = [[NSMutableArray alloc] init];
//    }
//
//    FLLog(@"Added lock");
//
//    FLAssetQueueLoadLock* lock = FLAutorelease([[FLAssetQueueLoadLock alloc] initWithAssetQueue:self]);
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
#endif

@end

//#import "FLAssetsLibraryImageAsset.h"

@interface FLAssetQueueLoader ()
@property (readwrite, strong) FLAssetQueue* assetQueue;
@end

@implementation FLAssetQueueLoader

@synthesize assetQueue = _assetQueue;

- (id) initWithAssetQueue:(FLAssetQueue*) queue {
    if((self = [super init])) {
        self.assetQueue = queue;
    }
    
    return self;
}

+ (FLAssetQueueLoader*) assetQueueLoader:(FLAssetQueue*) queue {
    return FLAutorelease([[FLAssetQueueLoader alloc] initWithAssetQueue:queue]);
}

#if FL_MRC
- (void) dealloc {
    [_assetQueue release];
    [super dealloc];
}
#endif
 
- (id) performSynchronously {
    
    // TODO: Load with sort. eg USE TSQL: ORDER BY
    NSArray* queue = nil;
    [_assetQueue.database loadAllObjectsForTypeWithClass:[_assetQueue queueClass] outObjects:&queue];
    FLAutoreleaseObject(queue);

    if(queue) {
        [self abortIfNeeded];

        NSMutableArray* newQueue = FLAutorelease([queue mutableCopy]);

        if(newQueue.count > 0) {
            for(FLQueuedAsset* asset in newQueue) {
                [self abortIfNeeded];
                [asset createAssetIfNeeded];

// FIXME: this is all effed up
//                [asset.assetObject beginLoadingRepresentation:^(NSError* error) {
//                // TODO: convert to Async abstraction
//                }];
                
                [newQueue addObject:asset];
            }
                
            [newQueue sortUsingComparator:^(id obj1, id obj2) {
                return [[obj1 positionInQueue] compare:[obj2 positionInQueue]];

            }];

            [self abortIfNeeded];
        }
     
        return newQueue;
    }
    
    return FLFailedResult;
}

@end

#endif