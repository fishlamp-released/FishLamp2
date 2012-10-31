//
//  FLDatabaseUpgrader.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLUpgradeDatabaseLengthyTask.h"
#import "FLDatabase.h"

@implementation FLUpgradeDatabaseLengthyTask

@synthesize database = _database;

- (id) initWithDatabase:(FLDatabase*) database {
	if((self = [super init])) {
		_database = retain_(database);
	}

	return self;
}

+ (FLUpgradeDatabaseLengthyTask*) upgradeDatabaseLengthyTask:(FLDatabase*) database {
	return autorelease_([[FLUpgradeDatabaseLengthyTask alloc] initWithDatabase:database]);
}

- (void) dealloc {
	mrc_release_(_database);
	mrc_super_dealloc_();
}

- (NSUInteger) calculateTotalStepCount {
	return [_database tableCount];
}

- (void) executeSelf {
	self.taskName = NSLocalizedString(@"Upgrading Database", nil);
	
    [self.database upgradeDatabase:^(NSUInteger count, NSUInteger total) {
        [self setStepCount:count totalStepCount:total];
    }
    tableUpgraded:^(FLDatabaseTable* table, NSString* version) {
    }];
}

@end



