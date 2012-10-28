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
	FLRelease(rows);
	
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
	FLRelease(rows);
	
	return info;
}

- (NSArray*) indexesForTableNamed:(NSString*) tableName {
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_list(%@)", tableName] outRows:&rows];
	return FLReturnAutoreleased(rows);
}

- (NSArray*) detailsForIndexedNamed:(NSString*) indexName {
	NSArray* rows = nil; 
	[self runQueryWithString:[NSString stringWithFormat:@"PRAGMA index_info(%@)", indexName] outRows:&rows];
	return FLReturnAutoreleased(rows);
}

- (NSUInteger) tableCount {
    __block NSUInteger count = 0;

    FLDatabaseIterator* statement = [FLDatabaseIterator databaseIterator:self table:nil];
    [statement appendString:@"SELECT COUNT(*) FROM sqlite_master WHERE type='table'"];
    [statement execute:^(NSDictionary* row, BOOL* stop) {
        NSNumber* number = [row objectForKey:@"COUNT(*)"];
        if(number) {
            count = [number integerValue];
        }
    }];
    
	return count;
}

@end
