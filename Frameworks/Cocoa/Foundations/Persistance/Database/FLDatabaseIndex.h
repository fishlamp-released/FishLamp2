//
//  FLDatabaseIndex.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

typedef enum {
	FLDatabaseColumnIndexPropertyNone				= 0,
	FLDatabaseColumnIndexPropertyUnique			= (1 << 1),
	
	// use either of these (default is ASC if nothing is specified)
	FLDatabaseColumnIndexPropertyAsc				= (1 << 3),
	FLDatabaseColumnIndexPropertyDesc				= (1 << 4),
	
	// use 1 collating type (default if nothing is specified is binary)
	FLDatabaseColumnIndexPropertyCollateBinary	= (1 << 5),
	FLDatabaseColumnIndexPropertyCollateNoCase	= (1 << 6),
	FLDatabaseColumnIndexPropertyCollateTrim		= (1 << 7)

} FLDatabaseColumnIndexProperties;

@interface FLDatabaseIndex : NSObject<NSCopying> {
@private
	NSString* _columnName;
	FLDatabaseColumnIndexProperties _indexMask;
}

@property (readonly, retain, nonatomic) NSString* columnName;
@property (readonly, assign, nonatomic) FLDatabaseColumnIndexProperties indexProperties;

- (id) initWithColumnName:(NSString*) columnName indexProperties:(FLDatabaseColumnIndexProperties) indexProperties;

+ (FLDatabaseIndex*) databaseIndex:(NSString*) columnName indexProperties:(FLDatabaseColumnIndexProperties) indexProperties;

- (NSString*) createIndexSqlForTableName:(NSString*) tableName;

@end