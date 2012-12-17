//
//  FLDatabaseColumn.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

@class FLDatabase;
@class FLDatabaseTable;
@class FLDatabaseColumn;

#import "FLDatabaseIndex.h"
#import "FLDatabaseDefines.h"

#define FLDatabaseColumnConstraintPrimaryKeyAsc @"PRIMARY KEY ASC NOT NULL UNIQUE"

typedef enum {
	FLDatabaseOnConflictActionAbort,
	FLDatabaseOnConflictActionRollback,
	FLDatabaseOnConflictActionFail,
	FLDatabaseOnConflictActionIgnore,
	FLDatabaseOnConflictActionReplace,
	
	FLDatabaseOnConflictActionDefault = FLDatabaseOnConflictActionAbort
} FLDatabaseOnConflictAction;
	
typedef enum { 
	FLDatabaseSortOrderAsc,
	FLDatabaseSortOrderDesc
} FLDatabaseSortOrder;	

@interface FLDatabaseColumn : NSObject<NSCopying> {
@private
	NSString* _name;
	NSString* _decodedColumnName;
	NSArray* _constraints;
	struct { 
		FLDatabaseType columnType : 4;
		unsigned int isIndexed: 1;
		unsigned int isPrimaryKey: 1;
	} _state;
}

@property (readonly, assign, nonatomic) FLDatabaseType columnType;
@property (readonly, retain, nonatomic) NSString* columnName;
@property (readonly, retain, nonatomic) NSString* decodedColumnName;
@property (readonly, retain, nonatomic) NSArray* columnConstraints;
@property (readonly, retain, nonatomic) NSString* columnConstraintsAsString;
@property (readonly, assign, nonatomic, getter=isIndexed) BOOL indexed;
@property (readonly, assign, nonatomic, getter=isPrimaryKey) BOOL primaryKey;

- (id) initWithColumnName:(NSString*) name
               columnType:(FLDatabaseType) columnType
        columnConstraints:(NSArray*) columnConstraints;

+ (FLDatabaseColumn*) databaseColumnWithName:(NSString*) name
                                    columnType:(FLDatabaseType) columnType
                             columnConstraints:(NSArray*) columnConstraints;

@end


@interface FLDatabaseColumn (Constraints)
+ (NSString*) primaryKeyConstraint;

+ (NSString*) primaryKeyConstraintWithSortOrder:(FLDatabaseSortOrder) sortOrder 
	conflictAction:(FLDatabaseOnConflictAction) conflictAction 
	autoIncrement:(BOOL) autoIncrement; // auto increment only valid if type is INTEGER

+ (NSString*) uniqueConstraint;
+ (NSString*) uniqueConstraintWithConflictAction:(FLDatabaseOnConflictAction) conflictAction;

+ (NSString*) notNullConstraint;
+ (NSString*) notNullConstraintWithConflictAction:(FLDatabaseOnConflictAction) conflictAction;

// TODO: add check constraint
// TODO: add default constraint
// TODO: add collation contraint

@end