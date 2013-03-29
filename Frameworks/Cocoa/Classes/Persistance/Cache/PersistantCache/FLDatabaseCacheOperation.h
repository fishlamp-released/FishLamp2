//
//	FLDatabaseCacheOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLSynchronousOperation.h"
#import "FLDatabase.h"

typedef enum 
{
	gtLoadFromCacheOperation,
	gtDeleteFromCacheOperation,
	gtSaveToCacheOperation,

	// these don't pay attention to cache settings for object
	gtLoadFromDatabaseOperation, 
	gtSaveToDatabaseOperation,
	gtDeleteFromDatabase
} FLCacheOperationType;

@interface FLDatabaseCacheOperation : FLSynchronousOperation {
@private
	FLCacheOperationType _operationType;
	FLDatabase* _database;
    id _input;
}

- (id) initWithObjectAndOperationType:(FLDatabase*) cache
                                input:(id) input 	
                            operation:(FLCacheOperationType) operation;
	
@end
