//
//  FLSqliteColumn.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSqliteColumn.h"

@implementation FLSqliteColumn

FLSynthesizeStructProperty(columnType, setColumnType, FLSqliteType, _state); 
FLSynthesizeStructProperty(isIndexed, setIndexed, BOOL, _state); 
FLSynthesizeStructProperty(isPrimaryKey, setPrimaryKey, BOOL, _state); 

@synthesize columnName = _name;
@synthesize columnConstraints = _constraints;
@synthesize decodedColumnName = _decodedColumnName;

- (void) setColumnName:(NSString*) columnName {
	FLAssignObject(_name, FLSqliteNameEncode(columnName));
	FLAssignObject(_decodedColumnName, FLSqliteNameDecode(columnName));
}

- (void) dealloc {
	FLRelease(_decodedColumnName);
	FLRelease(_constraints);
	FLRelease(_name);
	FLSuperDealloc();
}

- (BOOL) hasPrimaryKeyConstraint {
	for(NSString* constraint in _constraints) {
		if(FLStringsAreEqual(constraint, [FLSqliteColumn primaryKeyConstraint])) {
			return YES;
		}
	}
	
	return NO;
}

- (id) initWithColumnName:(NSString*) name 
	columnType:(FLSqliteType) columnType  
	columnConstraints:(NSArray*) constraints {
	if((self = [super init])) {
		FLAssignObject(_constraints, constraints);
		_state.isPrimaryKey = self.hasPrimaryKeyConstraint;
		_state.isIndexed = _state.isPrimaryKey;
		self.columnName = name;
		self.columnType = columnType;
	}
	return self;
}

- (id) copyWithZone:(NSZone *)zone {
	FLSqliteColumn* column = [[FLSqliteColumn alloc] initWithColumnName:self.columnName columnType:self.columnType columnConstraints:FLReturnAutoreleased([self.columnConstraints copy])];
	return column;
}

+ (FLSqliteColumn*) sqliteColumnWithColumnName:(NSString*) name columnType:(FLSqliteType) columnType  columnConstraints:(NSArray*) columnConstraints {
	return FLReturnAutoreleased([[FLSqliteColumn alloc] initWithColumnName:name columnType:columnType columnConstraints:columnConstraints]);
}

NSString* _FLSqlConflictActionString(FLSqliteOnConflictAction action) {
	switch(action) {
		case FLSqliteOnConflictActionAbort: // this is default. 
			return @"";
			
		case FLSqliteOnConflictActionRollback:
			return @" ON CONFLICT ROLLBACK";
			
		case FLSqliteOnConflictActionFail:
			return @" ON CONFLICT FAIL";
		
		case FLSqliteOnConflictActionIgnore:
			return @" ON CONFLICT IGNORE";
			
		case FLSqliteOnConflictActionReplace:
			return @" ON CONFLICT REPLACE";
	}

	return nil;
}

- (NSString*) columnConstraintsAsString {
	if(_constraints && _constraints.count) {
		NSMutableString* str = [NSMutableString string];
		
		for(NSString* constraint in _constraints) {
			if(str.length) {
				[str appendFormat:@" %@", constraint];
			}
			else {
				[str appendString:constraint];
			}
		}
			
		return str;
	}
	
	return @"";
}

+ (NSString*) primaryKeyConstraint {
	return @"PRIMARY KEY ASC NOT NULL";
}

+ (NSString*) primaryKeyConstraintWithSortOrder:(FLSqliteSortOrder) sortOrder 
	conflictAction:(FLSqliteOnConflictAction) conflictAction 
	autoIncrement:(BOOL) autoIncrement {
	return [NSString stringWithFormat:@"PRIMARY KEY %@ NOT NULL %@%@", 
		sortOrder == FLSqliteSortOrderAsc ? @"ASC" : @"DESC",
		_FLSqlConflictActionString(conflictAction),
		autoIncrement ? @" AUTOINCREMENT" : @""];
}
+ (NSString*) uniqueConstraintWithConflictAction:(FLSqliteOnConflictAction) conflictAction {
	return [NSString stringWithFormat:@"UNIQUE%@", _FLSqlConflictActionString(conflictAction)];
}

+ (NSString*) notNullConstraintWithConflictAction:(FLSqliteOnConflictAction) conflictAction {
	return [NSString stringWithFormat:@"NOT NULL%@", _FLSqlConflictActionString(conflictAction)];
}

+ (NSString*) uniqueConstraint {
	return @"UNIQUE";
}

+ (NSString*) notNullConstraint {
	return @"NOT NULL";
}


@end
