//
//  FLObjectDatabaseIterator.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLSqliteStatement.h"
#import "FLSqliteTable.h"

@class FLObjectDatabase;

typedef BOOL (^FLObjectDatabaseIteratorPrepareStatementBlock)();
typedef BOOL (^FLObjectDatabaseIteratorDidSelectObject)(id object);
typedef BOOL (^FLObjectDatabaseIteratorDidSelectRow)(NSDictionary* row);

@interface FLObjectDatabaseIterator : FLSqliteStatement {
@private
	FLObjectDatabase* _objectDatabase;
	NSMutableArray* _resultObjects;
}

- (id) initWithObjectDatabase:(FLObjectDatabase*) database;

+ (FLObjectDatabaseIterator*) objectDatabaseIterator:(FLObjectDatabase*) database;

// just here for convienience, nothing is added to it automatically.
// this array is deleted when statement is finalized!
@property (readonly, retain, nonatomic) NSArray* resultObjects;
- (void) addResultObject:(id) object;

// for complex selects
- (void) selectObjectsInTable:(FLSqliteTable*) table
	willPrepareBlock:(FLObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectObjectBlock:(FLObjectDatabaseIteratorDidSelectObject) didSelectObject
	didFinishBlock:(FLEventCallback) didFinishBlock;

- (void) selectRowsInTable:(FLSqliteTable*) table
	willPrepareBlock:(FLObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectRowBlock:(FLObjectDatabaseIteratorDidSelectRow) didSelectRow
	didFinishBlock:(FLEventCallback) didFinishBlock;

// call this after preparing statement
- (BOOL) bindParametersForSql:(NSString*) sql
	inputObject:(id) object
	table:(FLSqliteTable*) table;
			
@end

