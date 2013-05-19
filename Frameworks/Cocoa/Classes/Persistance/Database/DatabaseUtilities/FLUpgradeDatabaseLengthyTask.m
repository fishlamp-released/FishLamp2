//
//  FLDatabaseUpgrader.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUpgradeDatabaseLengthyTask.h"
#import "FLDatabase.h"

#import "FLDatabase+Introspection.h"

@implementation FLUpgradeDatabaseLengthyTask

@synthesize database = _database;

- (id) initWithDatabase:(FLDatabase*) database {
	if((self = [super init])) {
		_database = FLRetain(database);
	}

	return self;
}

+ (FLUpgradeDatabaseLengthyTask*) upgradeDatabaseLengthyTask:(FLDatabase*) database {
	return FLAutorelease([[FLUpgradeDatabaseLengthyTask alloc] initWithDatabase:database]);
}

- (void) dealloc {
	FLRelease(_database);
	FLSuperDealloc();
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



