//
//  FLDatabase+Versioning.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabase.h"


typedef void (^FLDatabaseUpgradeProgressBlock)(   NSUInteger checkedCount, NSUInteger total);

typedef void (^FLDatabaseTableUpgradedBlock)(     FLDatabaseTable* table, NSString* toVersion);

@interface FLDatabase (Versioning)

/// Reads version saved in database
- (NSString*) readDatabaseVersion;

/// returns YES if version saved in database is not the same version as the current version
- (BOOL) databaseNeedsUpgrade;

/// upgrades to runtime version
- (void) upgradeDatabase:(FLDatabaseUpgradeProgressBlock) progress
           tableUpgraded:(FLDatabaseTableUpgradedBlock) tableUpgraded;

// this is the app version by default. This means the database will want an upgraded each time
// the app version changes.
+ (NSString*) currentRuntimeVersion;

+ (void) setCurrentRuntimeVersion:(NSString*) version;

@end
