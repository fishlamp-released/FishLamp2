//
//  FLDatabaseUpgrader.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
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
