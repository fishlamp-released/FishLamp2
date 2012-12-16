//
//  FLDatabase+Objects.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabase+Objects.h"
#import "FLDatabase.h"
#import "FLDatabase_Internal.h"


@implementation FLDatabase (Objects)

- (void) loadObject:(id) inputObject 
		outputObject:(id*) outputObject {
	
    if(!inputObject) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	
    if(!outputObject) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}

	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultObjects:&array];
	
	if(array) {
		if(outputObject && array.count == 1) {
			*outputObject = FLRetain([array objectAtIndex:0]);
		}
		else if(array.count > 1) {
			FLRelease(array);
			FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorTooManyObjectsReturned,
                             ([NSString stringWithFormat:@"Too many objects returned for input object of type: %@", NSStringFromClass([inputObject class])]));
		}
		FLRelease(array);
	}
}

- (id) loadObject:(id) inputObject {
	id output = nil;
	[self loadObject:inputObject outputObject:&output];
	return FLAutorelease(output);
}

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject {
	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:nil resultObjects:&array];
	return FLAutorelease(array);
}

- (NSArray*) selectObjectsMatchingInputObject:(id) inputObject
                            resultColumnNames:(NSArray*) resultColumnNames {
	NSArray* array = nil;
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:resultColumnNames resultObjects:&array];

	return FLAutorelease(array);
}

- (void) selectObjectsMatchingInputObject:(id) inputObject 
				 resultObjects:(NSArray**) outObjects {
	[self selectObjectsMatchingInputObject:inputObject resultColumnNames:nil resultObjects:outObjects];
}

//			NSString* selectWhat = resultColumnNames && resultColumnNames.count ? [NSString stringWithFormat:@"(%@)", [NSString concatStringArray:resultColumnNames]] : @"*";
//			
//			BOOL boundOk = [iterator prepareStatement:[NSMutableString stringWithFormat:@"SELECT %@ FROM %@ WHERE", selectWhat, table.tableName]
//                                             forObject:inputObject];
            

- (void) selectObjectsMatchingInputObject:(id) inputObject 
						resultColumnNames:(NSArray*) resultColumnNames
						resultObjects:(NSArray**) outObjects {
	if(!inputObject) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}

	FLDatabaseTable* table = [[inputObject class] sharedDatabaseTable];
    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    NSMutableArray* results = [NSMutableArray array];
    
    
    NSString* resultColumns = [FLSqlBuilder sqlListFromArray:resultColumnNames delimiter:@"," withinParens:NO prefixDelimiterWithSpace:NO emptyString:SQL_ALL];

    [statement appendString:SQL_SELECT andString:resultColumns];
    [statement appendString:SQL_FROM andString:table.tableName];
    
    if(![statement appendWhereClauseForSelectingObject:inputObject]) {
        return;
    }
    
    statement.objectResultBlock = ^(id object, BOOL* stop) {
        [results addObject:object];
    };
    
    statement.finished = ^(NSError* error){
        if(outObjects && !error) {
            *outObjects = FLRetain(results);
        }
    };
    
    [self executeStatement:statement];
}

- (BOOL) objectExistsInDatabase:(id) inputObject
{
	if(!inputObject) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}

    __block BOOL foundIt = NO;

	FLDatabaseTable* table = [[inputObject class] sharedDatabaseTable];
    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    
    // TODO: it'd be faster to just load only primary key columns instead of all columns

    [statement appendString:SQL_SELECT andString:SQL_ALL];
    [statement appendString:SQL_FROM andString:table.tableName];
    
    if(![statement appendWhereClauseForSelectingObject:inputObject]) {

        FLAssertFailed_v(@"No.")
    }
    
    statement.rowResultBlock = ^(NSDictionary* row, BOOL* stop) {
        foundIt = YES;
        *stop = YES;
    };
    
    [self executeStatement:statement];
    
    
//	[iterator selectRows:^(BOOL* stop){
//
//            // TODO: it'd be faster to just load only primary key columns instead of all columns
//
//            [iterator appendString:SQL_SELECT andString:SQL_ALL];
//            [iterator appendString:SQL_FROM andString:table.tableName];
//            
//            if(![iterator appendWhereClauseForSelectingObject:inputObject]) {
//                *stop = YES;
//            }
//		}
//		didSelectRow:^(NSDictionary* row, BOOL* stop) {
//            foundIt = YES;
//			*stop = YES;
//		}
//		didFinish:^(NSError* error){
//		}
//		];

    return foundIt;
}

- (void) loadAllObjectsForTypeWithClass:(Class) objectClass
                             outObjects:(NSArray**) outObjects {

	[self loadAllObjectsForTypeWithTable:[objectClass sharedDatabaseTable] outObjects:outObjects];
}

- (void) loadAllObjectsForTypeWithTable:(FLDatabaseTable*) table
                             outObjects:(NSArray**) outObjects
{
	if(!table) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidInputObject, @"null input object");
	}
	if(!outObjects) {
		FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorInvalidOutputObject, @"null output object");
	}
	
    
    NSMutableArray* results = [NSMutableArray array];

    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];

    [statement appendString:SQL_SELECT andString:SQL_ALL];
    [statement appendString:SQL_FROM andString:table.tableName];
    
    statement.objectResultBlock = ^(id object, BOOL* stop) {
        [results addObject:object];
    };
    
    statement.finished = ^(NSError* error){
        if(outObjects && !error) {
            *outObjects = FLRetain(results);
        }
    };
    
    [self executeStatement:statement];
}

- (void) loadAllObjectsForType:(id) object 
                    outObjects:(NSArray**) outObjects
{
	[self loadAllObjectsForTypeWithTable:[[object class] sharedDatabaseTable] outObjects:outObjects];
}

- (void) deleteObject:(id) inputObject
{
    [self executeTransaction:^{
        FLAssertIsNotNil_v(inputObject, nil);
            
        FLDatabaseTable* table = [[inputObject class] sharedDatabaseTable];
        
        FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
        [statement appendString:SQL_DELETE];
        [statement appendString:SQL_FROM andString:table.tableName];

        if(![statement appendWhereClauseForSelectingObject:inputObject]) {
            FLThrowErrorCode_v(FLObjectDatabaseErrorDomain, FLDatabaseErrorNoParametersSpecified, @"No parameters specified");
        }

        [self executeStatement:statement];
    }];
    
    FLPerformSelector1(inputObject, @selector(wasRemovedFromDatabase:), self);
}

- (void) saveObject:(id) object {
	[self executeTransaction:^{
        [self _saveOneObject:object];
    }];
}

- (void) batchSaveObjects:(NSArray*) array {
	if(array && array.count) {
        [self executeTransaction:^{
            for(id object in array) {
                [self _saveOneObject:object];
            }
        }];
    }
}


@end

@implementation FLDatabase (ObjectsInternal)
- (void) _saveOneObject:(id) object {
    FLDatabaseTable* table = [[object class] sharedDatabaseTable];
    FLDatabaseStatement* statement = [FLDatabaseStatement databaseStatement:table];
    [statement appendString:SQL_INSERT];
    [statement appendString:SQL_OR];
    [statement appendString:SQL_REPLACE];
    [statement appendString:SQL_INTO andString:table.tableName];
    [statement appendInsertClauseForObject:object];
    [self executeStatement:statement];
    
    FLPerformSelector1(object, @selector(wasSavedToDatabase:), self);
}

@end

@implementation NSObject (FLDatabase)
- (void) saveInDatabase:(FLDatabase*) database {
    [database saveObject:database];
}

+ (id) readObjectFromDatabase:(FLDatabase*) database withSearchValue:(id) value forKey:(id) key {
    id objectInput = FLAutorelease([[[self class] alloc] init]);
    
    if(objectInput) {
        [objectInput setValue:value forKey:key];
    }
    return [database loadObject:objectInput];
    
}

@end
