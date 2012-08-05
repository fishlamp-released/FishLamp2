//
//	FLObjectDatabase.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLSqliteDatabase.h"
#import "FLSqliteTable.h"
#import "FLObjectDatabaseIterator.h"
#import "FLBlockQueue.h"

#define FLObjectDatabaseErrorDomain @"FLObjectDatabaseErrorDomain"

typedef enum {
    FLDatabaseErrorNoError = 0,
	FLDatabaseErrorTooManyObjectsReturned,
	FLDatabaseErrorAlreadyOpen,
	FLDatabaseErrorInvalidInputObject,
	FLDatabaseErrorInvalidOutputObject,
	FLDatabaseErrorNoParametersSpecified,
	FLDatabaseErrorRequiredColumnIsNull,
    FLDatabaseErrorObjectNotFound
} FLDatabaseError;

typedef enum {
    FLObjectDatabaseEventHintNone,
    FLObjectDatabaseEventHintLoaded,
    FLObjectDatabaseEventHintSaved
} FLObjectDatabaseEventHint;


@interface FLObjectDatabase : FLSqliteDatabase {
@private
	struct {
		unsigned int disableCancel:1;
	} _dbFlags;
}

- (id) initWithDefaultName:(NSString*) directory; // eg appname.sqlite
- (id) initWithName:(NSString*) fileName directory:(NSString*) directory;

- (void) cancelCurrentOperation;

- (id) loadObjectFromMemoryCache:(id) inputObject;

- (NSDate*) saveObject:(id) object;

- (NSDate*) batchSaveObjects:(NSArray*) array; // all of same type.

- (id) loadObject:(id) inputObject;

- (void) loadObject:(id) inputObject 
	   outputObject:(id*) outputObject;

// TODO: not loading from cache
- (void) selectObjectsMatchingInputObject:(id) inputObject 
						resultObjects:(NSArray**) outObjects;

- (void) selectObjectsMatchingInputObject:(id) inputObject 
						resultColumnNames:(NSArray*) resultColumnNames
						resultObjects:(NSArray**) outObjects;

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject;

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject
						resultColumnNames:(NSArray*) resultColumnNames;


// no params, loads everything
- (void) loadAllObjectsForType:(id) object 
						outObjects:(NSArray**) outObjects;

- (void) loadAllObjectsForTypeWithClass:(Class) class 
								outObjects:(NSArray**) outObjects;

- (void) loadAllObjectsForTypeWithTable:(FLSqliteTable*) table 
								outObjects:(NSArray**) outObjects;
								
- (void) deleteObject:(id) object;

/** looks to see if this object is in the database */
- (BOOL) objectExistsInDatabase:(id) inputObject;

@end

@interface NSObject (FLObjectDatabase)
- (void) wasSavedToDatabase:(FLObjectDatabase*) database;
- (BOOL) canSaveToDatabase:(FLObjectDatabase*) database;
@end

#import "FLAsyncEventHandler.h"

@interface FLObjectDatabase (FLAsyncEventHandler) 
- (void) loadObject:(id) inputObject 
   withEventHandler:(FLAsyncEventHandler*) handler;
@end