//
//	FLDatabaseCacheOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLOperation.h"
#import "FLObjectDatabase.h"

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
	FLObjectDatabase* _cache;
}

@property (readwrite, assign, nonatomic) FLCacheOperationType operation;

- (id) initWithObjectAndOperationType:(FLObjectDatabase*) cache
	object:(id) object 
	operation:(FLCacheOperationType) operation;
	
@end
