//
//  GtSqliteColumn.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqliteColumn.h"

@implementation GtSqliteColumn

GtSynthesizeStructProperty(columnType, setColumnType, GtSqliteType, m_state); 
GtSynthesizeStructProperty(isIndexed, setIndexed, BOOL, m_state); 
GtSynthesizeStructProperty(isPrimaryKey, setPrimaryKey, BOOL, m_state); 

@synthesize columnName = m_name;
@synthesize columnConstraints = m_constraints;
@synthesize decodedColumnName = m_decodedColumnName;

- (void) setColumnName:(NSString*) columnName
{
	GtAssignObject(m_name, GtSqliteNameEncode(columnName));
	GtAssignObject(m_decodedColumnName, GtSqliteNameDecode(columnName));
}

- (void) dealloc
{
	GtRelease(m_decodedColumnName);
	GtRelease(m_constraints);
	GtRelease(m_name);
	GtSuperDealloc();
}

- (BOOL) hasPrimaryKeyConstraint
{
	for(NSString* constraint in m_constraints)
	{
		if(GtStringsAreEqual(constraint, [GtSqliteColumn primaryKeyConstraint]))
		{
			return YES;
		}
	}
	
	return NO;
}

- (id) initWithColumnName:(NSString*) name 
	columnType:(GtSqliteType) columnType  
	columnConstraints:(NSArray*) constraints
{
	if((self = [super init]))
	{
		GtAssignObject(m_constraints, constraints);
		m_state.isPrimaryKey = self.hasPrimaryKeyConstraint;
		m_state.isIndexed = m_state.isPrimaryKey;
		self.columnName = name;
		self.columnType = columnType;
	}
	return self;
}

- (id) copyWithZone:(NSZone *)zone
{
	GtSqliteColumn* column = [[GtSqliteColumn alloc] initWithColumnName:self.columnName columnType:self.columnType columnConstraints:GtReturnAutoreleased([self.columnConstraints copy])];
	return column;
}

+ (GtSqliteColumn*) sqliteColumnWithColumnName:(NSString*) name columnType:(GtSqliteType) columnType  columnConstraints:(NSArray*) columnConstraints
{
	return GtReturnAutoreleased([[GtSqliteColumn alloc] initWithColumnName:name columnType:columnType columnConstraints:columnConstraints]);
}

NSString* _GtSqlConflictActionString(GtSqliteOnConflictAction action)
{
	switch(action)
	{
		case GtSqliteOnConflictActionAbort: // this is default. 
			return @"";
			
		case GtSqliteOnConflictActionRollback:
			return @" ON CONFLICT ROLLBACK";
			
		case GtSqliteOnConflictActionFail:
			return @" ON CONFLICT FAIL";
		
		case GtSqliteOnConflictActionIgnore:
			return @" ON CONFLICT IGNORE";
			
		case GtSqliteOnConflictActionReplace:
			return @" ON CONFLICT REPLACE";
	}

	return nil;
}

- (NSString*) columnConstraintsAsString
{
	if(m_constraints && m_constraints.count)
	{
		NSMutableString* str = [NSMutableString string];
		
		for(NSString* constraint in m_constraints)
		{
			if(str.length)
			{
				[str appendFormat:@" %@", constraint];
			}
			else
			{
				[str appendString:constraint];
			}
		}
			
		return str;
	}
	
	return @"";
}

+ (NSString*) primaryKeyConstraint
{
	return @"PRIMARY KEY ASC NOT NULL";
}

+ (NSString*) primaryKeyConstraintWithSortOrder:(GtSqliteSortOrder) sortOrder 
	conflictAction:(GtSqliteOnConflictAction) conflictAction 
	autoIncrement:(BOOL) autoIncrement
{
	return [NSString stringWithFormat:@"PRIMARY KEY %@ NOT NULL %@%@", 
		sortOrder == GtSqliteSortOrderAsc ? @"ASC" : @"DESC",
		_GtSqlConflictActionString(conflictAction),
		autoIncrement ? @" AUTOINCREMENT" : @""];
}
+ (NSString*) uniqueConstraintWithConflictAction:(GtSqliteOnConflictAction) conflictAction
{
	return [NSString stringWithFormat:@"UNIQUE%@", _GtSqlConflictActionString(conflictAction)];
}
+ (NSString*) notNullConstraintWithConflictAction:(GtSqliteOnConflictAction) conflictAction
{
	return [NSString stringWithFormat:@"NOT NULL%@", _GtSqlConflictActionString(conflictAction)];
}
+ (NSString*) uniqueConstraint
{
	return @"UNIQUE";
}
+ (NSString*) notNullConstraint
{
	return @"NOT NULL";
}


@end
