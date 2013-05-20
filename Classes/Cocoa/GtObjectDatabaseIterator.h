//
//  GtObjectDatabaseIterator.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/16/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtSqliteStatement.h"
#import "GtSqliteTable.h"

@class GtObjectDatabase;

typedef BOOL (^GtObjectDatabaseIteratorPrepareStatementBlock)();
typedef BOOL (^GtObjectDatabaseIteratorDidSelectObject)(id object);
typedef BOOL (^GtObjectDatabaseIteratorDidSelectRow)(NSDictionary* row);

@interface GtObjectDatabaseIterator : GtSqliteStatement {
@private
	GtObjectDatabase* m_objectDatabase;
	NSMutableArray* m_resultObjects;
}

- (id) initWithObjectDatabase:(GtObjectDatabase*) database;

+ (GtObjectDatabaseIterator*) objectDatabaseIterator:(GtObjectDatabase*) database;

// just here for convienience, nothing is added to it automatically.
// this array is deleted when statement is finalized!
@property (readonly, retain, nonatomic) NSArray* resultObjects;
- (void) addResultObject:(id) object;

// for complex selects
- (void) selectObjectsInTable:(GtSqliteTable*) table
	willPrepareBlock:(GtObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectObjectBlock:(GtObjectDatabaseIteratorDidSelectObject) didSelectObject
	didFinishBlock:(GtBlock) didFinishBlock;

- (void) selectRowsInTable:(GtSqliteTable*) table
	willPrepareBlock:(GtObjectDatabaseIteratorPrepareStatementBlock) prepare
	didSelectRowBlock:(GtObjectDatabaseIteratorDidSelectRow) didSelectRow
	didFinishBlock:(GtBlock) didFinishBlock;

// call this after preparing statement
- (BOOL) bindParametersForSql:(NSString*) sql
	inputObject:(id) object
	table:(GtSqliteTable*) table;
			
@end

@interface NSObject (SqlObjectDatabase)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data;
@end
