//
//  FLApplicationDataMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLApplicationDataMgr.h"
#import "FLSqliteDatabaseVersioner.h"
#import "FLSqliteDatabaseUpgrader.h"

@implementation FLApplicationDataMgr

FLSynthesizeSingleton(FLApplicationDataMgr);

@synthesize database = _database;

- (id) init
{
	if((self = [super init]))
	{
#if IOS
		NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString* directory = [paths lastObject];
#else
		NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
		NSString* directory = [paths lastObject];
	
		FLAssertFailed(@"set app support/app name folder");

// TODO(not implemented)

#pragma unused (directory)     
        
#endif
		_database = [[FLObjectDatabase alloc] initWithName:@"session.sqlite" directory:directory];

	}
	
	return self;
}

- (void) dealloc
{
	[_database closeDatabase];
	FLRelease(_database);
	FLSuperDealloc();
}

- (void) openDatabase
{
	[_database openDatabase:FLSqliteDatabaseOpenFlagsDefault];

	if(![[FLSqliteDatabaseVersioner instance] databaseVersionEqualToAppVersion:_database])
	{
		FLSqliteDatabaseUpgrader* upgrader = [FLSqliteDatabaseUpgrader sqliteDatabaseUpgrader:_database];
		[upgrader prepareTask];
		[upgrader executeTask];
	}
}




@end

