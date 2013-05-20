//
//  GtSqliteDatabaseUpgrader.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLengthyTask.h"

#import "GtSqlite.h"
#import "GtSqliteDatabase.h"

@interface GtSqliteDatabaseUpgrader : GtLengthyTask {
@private
	GtSqliteDatabase* m_database;
}

@property (readonly, retain, nonatomic) GtSqliteDatabase* database;

- (id) initWithSqliteDatabase:(GtSqliteDatabase*) database;
+ (GtSqliteDatabaseUpgrader*) sqliteDatabaseUpgrader:(GtSqliteDatabase*) database;

@end

