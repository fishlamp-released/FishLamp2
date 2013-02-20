//
//  FLDatabase+Objects.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabase.h"

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

@interface FLDatabase (Objects)

// Objects

- (void) writeObject:(id) object;

- (void) batchWriteObjects:(NSArray*) array; 

- (id) readObject:(id) inputObject;

- (void) readObject:(id) inputObject 
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

- (void) loadAllObjectsForTypeWithTable:(FLDatabaseTable*) table 
								outObjects:(NSArray**) outObjects;
								
- (void) deleteObject:(id) object;

/** looks to see if this object is in the database */
- (BOOL) containsObject:(id) inputObject;

@end

@interface NSObject (FLDatabase)
- (void) saveInDatabase:(FLDatabase*) database;
+ (id) readObjectFromDatabase:(FLDatabase*) database withSearchValue:(id) value forKey:(id) key;
@end

@protocol FLOptionalDatabaseEvents <NSObject>
@optional
- (void) wasRemovedFromDatabase:(FLDatabase*) database;
- (void) wasSavedToDatabase:(FLDatabase*) database;
@end
