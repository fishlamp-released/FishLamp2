//
//	GtDatabaseCacheOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperation.h"
#import "GtObjectDatabase.h"

typedef enum 
{
	gtLoadFromCacheOperation,
	gtDeleteFromCacheOperation,
	gtSaveToCacheOperation,

	// these don't pay attention to cache settings for object
	gtLoadFromDatabaseOperation, 
	gtSaveToDatabaseOperation,
	gtDeleteFromDatabase
} GtCacheOperationType;

@interface GtDatabaseCacheOperation : GtOperation {
@private
	GtCacheOperationType m_operation;
	GtObjectDatabase* m_cache;
}

@property (readwrite, assign, nonatomic) GtCacheOperationType operation;

- (id) initWithObjectAndOperationType:(GtObjectDatabase*) cache
	object:(id) object 
	operation:(GtCacheOperationType) operation;
	
@end
