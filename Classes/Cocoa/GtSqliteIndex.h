//
//  GtSqliteIndex.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/3/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtSqlite.h"

typedef enum {
	GtSqliteColumnIndexPropertyNone				= 0,
	GtSqliteColumnIndexPropertyUnique			= (1 << 1),
	
	// use either of these (default is ASC if nothing is specified)
	GtSqliteColumnIndexPropertyAsc				= (1 << 3),
	GtSqliteColumnIndexPropertyDesc				= (1 << 4),
	
	// use 1 collating type (default if nothing is specified is binary)
	GtSqliteColumnIndexPropertyCollateBinary	= (1 << 5),
	GtSqliteColumnIndexPropertyCollateNoCase	= (1 << 6),
	GtSqliteColumnIndexPropertyCollateTrim		= (1 << 7)

} GtSqliteColumnIndexProperties;

@interface GtSqliteIndex : NSObject<NSCopying> {
@private
	NSString* m_columnName;
	GtSqliteColumnIndexProperties m_indexMask;
}

@property (readonly, retain, nonatomic) NSString* columnName;
@property (readonly, assign, nonatomic) GtSqliteColumnIndexProperties indexProperties;

- (id) initWithColumnName:(NSString*) columnName indexProperties:(GtSqliteColumnIndexProperties) indexProperties;

+ (GtSqliteIndex*) sqliteIndex:(NSString*) columnName indexProperties:(GtSqliteColumnIndexProperties) indexProperties;

- (NSString*) createIndexSqlForTableName:(NSString*) tableName;

@end
