//
//	FLDatabaseCacheOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLOperation.h"
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

@interface FLDatabaseCacheOperation : FLOperation {
@private
	FLCacheOperationType _operation;
	FLDatabase* _cache;
}

@property (readwrite, assign, nonatomic) FLCacheOperationType operation;

- (id) initWithObjectAndOperationType:(FLDatabase*) cache
	object:(id) object 
	operation:(FLCacheOperationType) operation;
	
@end
