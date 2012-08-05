//
//  FLSqliteDatabase+FLUnitTest.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLSqliteDatabase+FLUnitTest.h"
#import "FLTempFolder.h"

#if TEST
#import "FLUnitTest.h"

@implementation FLSqliteDatabase (FLUnitTest)

+ (void) _willStartUnitTestsForGroup:(FLUnitTestGroup*) unitTestGroup {
    FLTempFolder* folder = [FLTempFolder tempFolder];
    [folder createIfNeeded];
    
    FLSqliteDatabase* db = [[FLSqliteDatabase alloc] initWithFilePath:[folder pathForFile:@"tempdb.sqlite"]];
    [db openDatabase:FLSqliteDatabaseOpenFlagsDefault];
    
    [unitTestGroup setObject:db forKey:@"db"];
    
    [unitTestGroup log:@"Setup database"];
}

+ (void) _didFinishUnitTestsForGroup:(FLUnitTestGroup*) unitTestGroup {

    FLSqliteDatabase* db = [unitTestGroup objectForKey:@"db"];
    [db closeDatabase];
    [db deleteOnDisk];
    [unitTestGroup log:@"Deleted database"];
}

+ (void) _unitTest001CreateDatabase:(FLUnitTest*) unitTest {
    [unitTest log:@"HI"];
    
    FLSqliteDatabase* db = [unitTest objectForKey:@"db"];
    
    if(db) {
        [unitTest log:@"Got my db"];
    }
    
}

@end


#endif