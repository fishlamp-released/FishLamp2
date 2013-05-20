//
//  GtApplicationDataMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtApplicationDataMgr.h"
#import "GtSqliteDatabaseVersioner.h"
#import "GtSqliteDatabaseUpgrader.h"

@implementation GtApplicationDataMgr

GtSynthesizeSingleton(GtApplicationDataMgr);

@synthesize database = m_database;

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
	
		GtAssertFailed(@"set app support/app name folder");
#endif
		m_database = [[GtObjectDatabase alloc] initWithName:@"session.sqlite" directory:directory];

	}
	
	return self;
}

- (void) dealloc
{
	[m_database closeDatabase];
	GtRelease(m_database);
	GtSuperDealloc();
}

- (void) openDatabase
{
	[m_database openDatabase:GtSqliteDatabaseOpenFlagsDefault];

	if(![[GtSqliteDatabaseVersioner instance] databaseVersionEqualToAppVersion:m_database])
	{
		GtSqliteDatabaseUpgrader* upgrader = [GtSqliteDatabaseUpgrader sqliteDatabaseUpgrader:m_database];
		[upgrader prepareTask];
		[upgrader executeTask];
	}
}




@end

