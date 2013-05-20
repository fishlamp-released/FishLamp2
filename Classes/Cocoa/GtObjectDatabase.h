//
//	GtObjectDatabase.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteDatabase.h"
#import "GtSqliteTable.h"
#import "GtObjectDatabaseIterator.h"

#define GtDatabaseDomain @"GtDatabaseDomain"

typedef enum {
	GtDatabaseErrorTooManyObjectsReturned = 1,
	GtDatabaseErrorAlreadyOpen,
	GtDatabaseErrorInvalidInputObject,
	GtDatabaseErrorInvalidOutputObject,
	GtDatabaseErrorNoParametersSpecified,
	GtDatabaseErrorRequiredColumnIsNull
} GtDatabaseError;

@interface GtObjectDatabase : GtSqliteDatabase {
@private
	struct {
		unsigned int disableCancel:1;
	} m_dbFlags;
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

- (void) loadAllObjectsForTypeWithTable:(GtSqliteTable*) table 
								outObjects:(NSArray**) outObjects;
								
- (void) deleteObject:(id) object;

/** looks to see if this object is in the database */
- (BOOL) objectExistsInDatabase:(id) inputObject;

@end

@interface NSObject (GtObjectDatabase)
- (void) wasSavedToDatabase:(GtObjectDatabase*) database;
- (BOOL) canSaveToDatabase:(GtObjectDatabase*) database;
@end

