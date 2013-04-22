//
//  FLDatabaseColumn.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/27/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDatabaseColumn.h"
#import "FLDatabase_Internal.h"

@interface FLDatabaseColumn ()
@property (readwrite, strong, nonatomic) NSString* columnName;
@property (readwrite, strong, nonatomic) NSString* decodedColumnName;
@property (readwrite, strong, nonatomic) NSSet* columnConstraints;
@property (readwrite, assign, nonatomic) FLDatabaseType columnType;
@end

@implementation FLDatabaseColumn

@synthesize columnName = _name;
@synthesize columnConstraints = _columnConstraints;
@synthesize decodedColumnName = _decodedColumnName;
@synthesize columnType = _columnType;
@synthesize hasPrimaryKeyConstraint = _hasPrimaryKeyConstraint;

- (id) initWithColumnName:(NSString*) name 
               columnType:(FLDatabaseType) columnType  {

    FLAssertStringIsNotEmpty(name);
    FLAssert(columnType != FLDatabaseTypeInvalid);

	if((self = [super init])) {
		self.columnName = name;
		self.columnType = columnType;
	}
	return self;
}

- (id) initWithColumnName:(NSString*) name 
               columnType:(FLDatabaseType) columnType  
        columnConstraints:(NSArray*) constraints {

	if((self = [self initWithColumnName:name columnType:columnType])) {
        for(id constraint in constraints) {
            [self addColumnConstraint:constraint];
        }
    }
	return self;
}

- (id) init {
    return [self initWithColumnName:nil columnType:FLDatabaseTypeInvalid];
}


+ (FLDatabaseColumn*) databaseColumnWithName:(NSString*) name 
                                  columnType:(FLDatabaseType) columnType {
                           
	return FLAutorelease([[FLDatabaseColumn alloc] initWithColumnName:name columnType:columnType]);
}

+ (FLDatabaseColumn*) databaseColumnWithName:(NSString*) name 
                                  columnType:(FLDatabaseType) columnType  
                           columnConstraints:(NSArray*) columnConstraints {
                           
	return FLAutorelease([[FLDatabaseColumn alloc] initWithColumnName:name columnType:columnType columnConstraints:columnConstraints]);
}

- (void) setColumnName:(NSString*) columnName {
	FLSetObjectWithRetain(_name, FLDatabaseNameEncode(columnName));
	FLSetObjectWithRetain(_decodedColumnName, FLDatabaseNameDecode(columnName));
}

#if FL_MRC
- (void) dealloc {
	[_decodedColumnName release];
    [_columnConstraints release];
    [_name release];
    [super dealloc];
}
#endif

- (void) addColumnConstraint:(FLDatabaseColumnConstraint*) constraint {
    if(!_columnConstraints) {
        _columnConstraints = [[NSMutableSet alloc] init];
    }
    
    if([constraint isKindOfClass:[FLPrimaryKeyConstraint class]]) {
        _hasPrimaryKeyConstraint = YES;
    }

    [_columnConstraints addObject:constraint];
}


- (id) copyWithZone:(NSZone *)zone {
	FLDatabaseColumn* column = [[FLDatabaseColumn alloc] initWithColumnName:self.columnName 
                                                                 columnType:self.columnType];
                                                          
    for(id constraint in _columnConstraints) {
        [column addColumnConstraint:constraint];
    }
                                                          
	return column;
}

- (NSString*) columnConstraintsAsString {
	if(_columnConstraints && _columnConstraints.count) {
		NSMutableString* str = [NSMutableString string];
		
		for(id constraint in _columnConstraints) {
			if(str.length) {
				[str appendFormat:@" %@", [constraint sqlString]];
			}
			else {
				[str appendString:constraint];
			}
		}
			
		return str;
	}
	
	return @"";
}

- (BOOL)isEqual:(id)object {
    return [object isKindOfClass:[self class]] && FLStringsAreEqual(self.columnName, [object columnName]);
}

- (NSUInteger)hash {
    return [self.columnName hash];
}



@end
