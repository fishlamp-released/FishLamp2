//
//  FLDatabase+FLTestCase.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDatabase.h"
#import "FishLampCore.h"
#import "FLUnitTest.h"

@interface FLDatabaseTests : FLUnitTest {
@private
    id _database;
}
- (id) createDatabase:(NSString*) filePath;
@property (readonly, strong, nonatomic) id database;

@end

