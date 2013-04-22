//
//  FLDatabaseColumn.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

@class FLDatabase;
@class FLDatabaseTable;
@class FLDatabaseColumn;

#import "FLDatabaseIndex.h"
#import "FLDatabaseDefines.h"
#import "FLDatabaseColumnConstraint.h"

@interface FLDatabaseColumn : NSObject<NSCopying> {
@private
	NSString* _name;
	NSString* _decodedColumnName;
	NSMutableSet* _columnConstraints;
	FLDatabaseType _columnType;
    BOOL _hasPrimaryKeyConstraint;
}

@property (readonly, strong, nonatomic) NSString* columnName;
@property (readonly, strong, nonatomic) NSString* decodedColumnName;

@property (readonly, strong, nonatomic) NSSet* columnConstraints;
@property (readonly, strong, nonatomic) NSString* columnConstraintsAsString;
@property (readonly, assign, nonatomic) BOOL hasPrimaryKeyConstraint;

@property (readonly, assign, nonatomic) FLDatabaseType columnType;

- (id) initWithColumnName:(NSString*) name
               columnType:(FLDatabaseType) columnType;

+ (FLDatabaseColumn*) databaseColumnWithName:(NSString*) name
                                  columnType:(FLDatabaseType) columnType;

// must be added before column is used in database!
- (void) addColumnConstraint:(FLDatabaseColumnConstraint*) constraint;


@end


@interface FLDatabaseColumn (Deprecated)
- (id) initWithColumnName:(NSString*) name
               columnType:(FLDatabaseType) columnType
        columnConstraints:(NSArray*) columnConstraints;

+ (FLDatabaseColumn*) databaseColumnWithName:(NSString*) name
                                    columnType:(FLDatabaseType) columnType
                             columnConstraints:(NSArray*) columnConstraints;
@end
