//
//  FLDatabase+FLTestCase.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDatabase.h"
#import "FishLampCore.h"

#if TEST

@interface FLDatabaseTests : FLFrameworkUnitTest {
    FLDatabase* _database;
}

@end

#endif