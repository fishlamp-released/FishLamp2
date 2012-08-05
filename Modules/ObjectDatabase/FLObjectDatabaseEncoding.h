//
//  FLDatabaseObjectEncoding.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLObjectDescriber.h"
#import "FLSqliteTable.h"
#import "FLObjectDatabaseIterator.h"

@interface FLObjectDatabaseIterator (FLObjectDatabaseEncoding);

+ (id) decodeColumnObject:(NSString*) columnName 
                   object: (id) object 
                  sqlType:(FLSqliteType) sqlType 
          objectDescriber:(FLObjectDescriber*) objectDescriber
                    table:(FLSqliteTable*) table;

@end