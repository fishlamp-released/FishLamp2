//
//  FLDatabaseUpgrader.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLLengthyTask.h"
#import "FLDatabase.h"

@interface FLUpgradeDatabaseLengthyTask : FLLengthyTask {
@private
	FLDatabase* _database;
}

@property (readonly, retain, nonatomic) FLDatabase* database;

- (id) initWithDatabase:(FLDatabase*) database;

+ (FLUpgradeDatabaseLengthyTask*) upgradeDatabaseLengthyTask:(FLDatabase*) database;

@end

