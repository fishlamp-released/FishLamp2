//
//  FLDatabaseColumn.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDatabaseColumn.h"
#import "FLDatabase_Internal.h"


@implementation FLDatabaseColumn

FLSynthesizeStructProperty(columnType, setColumnType, FLDatabaseType, _state); 
FLSynthesizeStructProperty(isIndexed, setIndexed, BOOL, _state); 
FLSynthesizeStructProperty(isPrimaryKey, setPrimaryKey, BOOL, _state); 

@synthesize columnName = _name;
@synthesize columnConstraints = _constraints;
@synthesize decodedColumnName = _decodedColumnName;

- (void) setColumnName:(NSString*) columnName {
	FLAssignObject(_name, FLDatabaseNameEncode(columnName));
	FLAssignObject(_decodedColumnName, FLDatabaseNameDecode(columnName));
}

- (void) dealloc {
	FLRelease(_decodedColumnName);
	FLRelease(_constraints);
	FLRelease(_name);
	FLSuperDealloc();
}

- (BOOL) hasPrimaryKeyConstraint {
	for(NSString* constraint in _constraints) {
		if(FLStringsAreEqual(constraint, [FLDatabaseColumn primaryKeyConstraint])) {
			return YES;
		}
	}
	
	return NO;
}

- (id) initWithColumnName:(NSString*) name 
	columnType:(FLDatabaseType) columnType  
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
	FLDatabaseColumn* column = [[FLDatabaseColumn alloc] initWithColumnName:self.columnName columnType:self.columnType columnConstraints:FLReturnAutoreleased([self.columnConstraints copy])];
	return column;
}

+ (FLDatabaseColumn*) databaseColumnWithName:(NSString*) name columnType:(FLDatabaseType) columnType  columnConstraints:(NSArray*) columnConstraints {
	return FLReturnAutoreleased([[FLDatabaseColumn alloc] initWithColumnName:name columnType:columnType columnConstraints:columnConstraints]);
}

NSString* _FLSqlConflictActionString(FLDatabaseOnConflictAction action) {
	switch(action) {
		case FLDatabaseOnConflictActionAbort: // this is default. 
			return @"";
			
		case FLDatabaseOnConflictActionRollback:
			return @" ON CONFLICT ROLLBACK";
			
		case FLDatabaseOnConflictActionFail:
			return @" ON CONFLICT FAIL";
		
		case FLDatabaseOnConflictActionIgnore:
			return @" ON CONFLICT IGNORE";
			
		case FLDatabaseOnConflictActionReplace:
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

+ (NSString*) primaryKeyConstraintWithSortOrder:(FLDatabaseSortOrder) sortOrder 
	conflictAction:(FLDatabaseOnConflictAction) conflictAction 
	autoIncrement:(BOOL) autoIncrement {
	return [NSString stringWithFormat:@"PRIMARY KEY %@ NOT NULL %@%@", 
		sortOrder == FLDatabaseSortOrderAsc ? @"ASC" : @"DESC",
		_FLSqlConflictActionString(conflictAction),
		autoIncrement ? @" AUTOINCREMENT" : @""];
}
+ (NSString*) uniqueConstraintWithConflictAction:(FLDatabaseOnConflictAction) conflictAction {
	return [NSString stringWithFormat:@"UNIQUE%@", _FLSqlConflictActionString(conflictAction)];
}

+ (NSString*) notNullConstraintWithConflictAction:(FLDatabaseOnConflictAction) conflictAction {
	return [NSString stringWithFormat:@"NOT NULL%@", _FLSqlConflictActionString(conflictAction)];
}

+ (NSString*) uniqueConstraint {
	return @"UNIQUE";
}

+ (NSString*) notNullConstraint {
	return @"NOT NULL";
}

- (BOOL)isEqual:(id)object {
    return [object isKindOfClass:[self class]] && FLStringsAreEqual(self.columnName, [object columnName]);
}

- (NSUInteger)hash {
    return [self.columnName hash];
}



@end
