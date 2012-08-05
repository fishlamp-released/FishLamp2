//
//  FLSqliteColumn.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLSqlite.h"
#import "FLSqliteIndex.h"

#define FLSqliteColumnConstraintPrimaryKeyAsc @"PRIMARY KEY ASC NOT NULL UNIQUE"

typedef enum {
	FLSqliteOnConflictActionAbort,
	FLSqliteOnConflictActionRollback,
	FLSqliteOnConflictActionFail,
	FLSqliteOnConflictActionIgnore,
	FLSqliteOnConflictActionReplace,
	
	FLSqliteOnConflictActionDefault = FLSqliteOnConflictActionAbort
} FLSqliteOnConflictAction;
	
typedef enum { 
	FLSqliteSortOrderAsc,
	FLSqliteSortOrderDesc
} FLSqliteSortOrder;	

@interface FLSqliteColumn : NSObject<NSCopying> {
@private
	NSString* _name;
	NSString* _decodedColumnName;
	NSArray* _constraints;
	struct { 
		FLSqliteType columnType : 4;
		unsigned int isIndexed: 1;
		unsigned int isPrimaryKey: 1;
	} _state;
}

@property (readonly, assign, nonatomic) FLSqliteType columnType;
@property (readonly, retain, nonatomic) NSString* columnName;
@property (readonly, retain, nonatomic) NSString* decodedColumnName;
@property (readonly, retain, nonatomic) NSArray* columnConstraints;
@property (readonly, retain, nonatomic) NSString* columnConstraintsAsString;
@property (readonly, assign, nonatomic, getter=isIndexed) BOOL indexed;
@property (readonly, assign, nonatomic, getter=isPrimaryKey) BOOL primaryKey;

- (id) initWithColumnName:(NSString*) name columnType:(FLSqliteType) columnType columnConstraints:(NSArray*) columnConstraints;

+ (FLSqliteColumn*) sqliteColumnWithColumnName:(NSString*) name columnType:(FLSqliteType) columnType  columnConstraints:(NSArray*) columnConstraints;

@end


@interface FLSqliteColumn (Constraints)
+ (NSString*) primaryKeyConstraint;

+ (NSString*) primaryKeyConstraintWithSortOrder:(FLSqliteSortOrder) sortOrder 
	conflictAction:(FLSqliteOnConflictAction) conflictAction 
	autoIncrement:(BOOL) autoIncrement; // auto increment only valid if type is INTEGER

+ (NSString*) uniqueConstraint;
+ (NSString*) uniqueConstraintWithConflictAction:(FLSqliteOnConflictAction) conflictAction;

+ (NSString*) notNullConstraint;
+ (NSString*) notNullConstraintWithConflictAction:(FLSqliteOnConflictAction) conflictAction;

// TODO: add check constraint
// TODO: add default constraint
// TODO: add collation contraint

@end