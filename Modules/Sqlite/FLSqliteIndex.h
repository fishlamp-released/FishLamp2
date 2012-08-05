//
//  FLSqliteIndex.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLSqlite.h"

typedef enum {
	FLSqliteColumnIndexPropertyNone				= 0,
	FLSqliteColumnIndexPropertyUnique			= (1 << 1),
	
	// use either of these (default is ASC if nothing is specified)
	FLSqliteColumnIndexPropertyAsc				= (1 << 3),
	FLSqliteColumnIndexPropertyDesc				= (1 << 4),
	
	// use 1 collating type (default if nothing is specified is binary)
	FLSqliteColumnIndexPropertyCollateBinary	= (1 << 5),
	FLSqliteColumnIndexPropertyCollateNoCase	= (1 << 6),
	FLSqliteColumnIndexPropertyCollateTrim		= (1 << 7)

} FLSqliteColumnIndexProperties;

@interface FLSqliteIndex : NSObject<NSCopying> {
@private
	NSString* _columnName;
	FLSqliteColumnIndexProperties _indexMask;
}

@property (readonly, retain, nonatomic) NSString* columnName;
@property (readonly, assign, nonatomic) FLSqliteColumnIndexProperties indexProperties;

- (id) initWithColumnName:(NSString*) columnName indexProperties:(FLSqliteColumnIndexProperties) indexProperties;

+ (FLSqliteIndex*) sqliteIndex:(NSString*) columnName indexProperties:(FLSqliteColumnIndexProperties) indexProperties;

- (NSString*) createIndexSqlForTableName:(NSString*) tableName;

@end
