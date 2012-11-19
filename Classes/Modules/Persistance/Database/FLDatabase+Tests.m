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

#if TEST
#import "FLUnitTest.h"

@implementation FLDatabaseTests

- (void) setupTests {
    FLTempFolder* folder = [FLTempFolder tempFolder];
    [folder createIfNeeded];
    
    _database = [[FLDatabase alloc] initWithFilePath:[folder pathForFile:@"tempdb.sqlite"]];
    [_database openDatabase:FLDatabaseOpenFlagsDefault];
    FLAssert_v(_database.isOpen, @"database is not open");
}

- (void) teardownTests {

    [_database closeDatabase];
    [_database deleteOnDisk];
}

- (void) testIsOpen {
    FLAssertIsNotNil_v(_database, nil);
    FLAssert_v(_database.isOpen, @"database is not open");
}

@end


#endif