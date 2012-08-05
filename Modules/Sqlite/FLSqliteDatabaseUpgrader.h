//
//  FLSqliteDatabaseUpgrader.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLLengthyTask.h"

#import "FLSqlite.h"
#import "FLSqliteDatabase.h"

@interface FLSqliteDatabaseUpgrader : FLLengthyTask {
@private
	FLSqliteDatabase* _database;
}

@property (readonly, retain, nonatomic) FLSqliteDatabase* database;

- (id) initWithSqliteDatabase:(FLSqliteDatabase*) database;
+ (FLSqliteDatabaseUpgrader*) sqliteDatabaseUpgrader:(FLSqliteDatabase*) database;

@end

