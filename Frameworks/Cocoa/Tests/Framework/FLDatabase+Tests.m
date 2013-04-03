//
//  FLDatabase+FLTestCase.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDatabase+Tests.h"
#import "FLTempFolder.h"
#import "FLDatabase.h"

#import "FLUnitTest.h"

@implementation FLDatabaseTests

+ (FLUnitTestGroup*) unitTestGroup {
    return [self frameworkTestGroup];
}

- (void) setupTests {
    FLTempFolder* folder = [FLTempFolder tempFolder];
    [folder createIfNeeded];
    
    _database = [[FLDatabase alloc] initWithFilePath:[folder pathForFile:@"tempdb.sqlite"]];
    [_database openDatabase:FLDatabaseOpenFlagsDefault];
    FLAssertWithComment(_database.isOpen, @"database is not open");
}

- (void) teardownTests {

    [_database closeDatabase];
    [_database deleteOnDisk];
}

- (void) testIsOpen {
    FLAssertIsNotNilWithComment(_database, nil);
    FLAssertWithComment(_database.isOpen, @"database is not open");
}

@end

