//
//  GtSqliteColumn.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtSqlite.h"
#import "GtSqliteIndex.h"

#define GtSqliteColumnConstraintPrimaryKeyAsc @"PRIMARY KEY ASC NOT NULL UNIQUE"

typedef enum {
	GtSqliteOnConflictActionAbort,
	GtSqliteOnConflictActionRollback,
	GtSqliteOnConflictActionFail,
	GtSqliteOnConflictActionIgnore,
	GtSqliteOnConflictActionReplace,
	
	GtSqliteOnConflictActionDefault = GtSqliteOnConflictActionAbort
} GtSqliteOnConflictAction;
	
typedef enum { 
	GtSqliteSortOrderAsc,
	GtSqliteSortOrderDesc
} GtSqliteSortOrder;	

@interface GtSqliteColumn : NSObject<NSCopying> {
@private
	NSString* m_name;
	NSString* m_decodedColumnName;
	NSArray* m_constraints;
	struct { 
		GtSqliteType columnType : 4;
		unsigned int isIndexed: 1;
		unsigned int isPrimaryKey: 1;
	} m_state;
}

@property (readonly, assign, nonatomic) GtSqliteType columnType;
@property (readonly, retain, nonatomic) NSString* columnName;
@property (readonly, retain, nonatomic) NSString* decodedColumnName;
@property (readonly, retain, nonatomic) NSArray* columnConstraints;
@property (readonly, retain, nonatomic) NSString* columnConstraintsAsString;
@property (readonly, assign, nonatomic, getter=isIndexed) BOOL indexed;
@property (readonly, assign, nonatomic, getter=isPrimaryKey) BOOL primaryKey;

- (id) initWithColumnName:(NSString*) name columnType:(GtSqliteType) columnType columnConstraints:(NSArray*) columnConstraints;

+ (GtSqliteColumn*) sqliteColumnWithColumnName:(NSString*) name columnType:(GtSqliteType) columnType  columnConstraints:(NSArray*) columnConstraints;

@end


@interface GtSqliteColumn (Constraints)
+ (NSString*) primaryKeyConstraint;

+ (NSString*) primaryKeyConstraintWithSortOrder:(GtSqliteSortOrder) sortOrder 
	conflictAction:(GtSqliteOnConflictAction) conflictAction 
	autoIncrement:(BOOL) autoIncrement; // auto increment only valid if type is INTEGER

+ (NSString*) uniqueConstraint;
+ (NSString*) uniqueConstraintWithConflictAction:(GtSqliteOnConflictAction) conflictAction;

+ (NSString*) notNullConstraint;
+ (NSString*) notNullConstraintWithConflictAction:(GtSqliteOnConflictAction) conflictAction;

// TODO: add check constraint
// TODO: add default constraint
// TODO: add collation contraint

@end