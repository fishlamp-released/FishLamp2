//
//  FLDatabase+Introspection.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabase+Introspection.h"

@implementation FLDatabase (Introspection)

- (NSArray*) tableNamesInDatabase {
	NSArray* rows = nil; 
	[self runQueryWithString:@"SELECT name FROM sqlite_master WHERE type='table'" outRows:&rows];
	
	NSMutableArray* outArray = [NSMutableArray arrayWithCapacity:rows.count];
	for(NSDictionary* row in rows) {	
		NSString* name = [row objectForKey:@"name"];
		if(name) {
			[outArray addObject:name];
		}
	}
	release_(rows);
	
	return outArray;
}

- (NSArray*) columnNamesForTableNamed:(NSString*) tableName {
    return [[self detailsForTableNamed:tableName] allKeys];
}

- (NSDictionary*) detailsForTableNamed:(NSString*) tableName {
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA table_info(%@)", tableName] outRows:&rows];
	
	NSMutableDictionary* info = [NSMutableDictionary dictionary];
	for(NSDictionary* row in rows) {
		[info setObject:row forKey:[row objectForKey:@"name"]];
	}
	release_(rows);
	
	return info;
}

- (NSArray*) indexesForTableNamed:(NSString*) tableName {
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_list(%@)", tableName] outRows:&rows];
	return autorelease_(rows);
}

- (NSArray*) detailsForIndexedNamed:(NSString*) indexName {
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_info(%@)", indexName] outRows:&rows];
	return autorelease_(rows);
}

- (NSUInteger) tableCount {
    __block NSUInteger count = 0;

    FLSqlBuilder* sql = [FLSqlBuilder sqlBuilder];
    [sql appendString:@"SELECT COUNT(*) FROM sqlite_master WHERE type='table'"];
    
    [self executeSql:sql rowResultBlock:^(NSDictionary* row, BOOL* stop) {
        NSNumber* number = [row objectForKey:@"COUNT(*)"];
        if(number) {
            count = [number integerValue];
        }
    }];
    
	return count;
}

@end
