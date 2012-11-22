//
//  FLDefaultSqlColumnDecoder.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLDatabase;
@class FLDatabaseTable;
@class FLDatabaseColumn;

// sends in the normal object (e.g value created with integerForColumn). 
// The handler should returns a new object, or the object passed in. 
// The resulting object is assigned to column in row dictionary.
typedef id (*FLDatabaseColumnDecoder)( FLDatabase* database,
                                         FLDatabaseTable* table,
                                         FLDatabaseColumn* column,
                                         id object);

// default implementations

extern id FLDefaultDatabaseColumnDecoder(FLDatabase* database,
                                         FLDatabaseTable* table,
                                         FLDatabaseColumn* column,
                                         id object);

// some of the older versions of the FishLamp apps have incorrect encoding in the database
// this is essentially a translator to the proper type so the user decoder can do it's work.
                                 
extern id FLLegacyDatabaseColumnDecoder(FLDatabase* database,
                                        FLDatabaseTable* table,
                                        FLDatabaseColumn* column,
                                        id object);
                                        
