//
//  FLDefaultSqlColumnDecoder.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDatabaseColumnDecoder.h"
#import "FLDatabase.h"
#import "FLDatabaseTable.h"
#import "FLDatabaseColumn.h"

#import "FLObjectDescriber.h"

#import "FLDatabaseIterator.h"

#import "FLBase64Encoding.h"

id FLDefaultDatabaseColumnDecoder( FLDatabase* database,
                             FLDatabaseTable* table,
                             FLDatabaseColumn* column,
                             id inObject) {
    
    id newObject = inObject;
    
    switch(column.columnType) {
        case FLDatabaseTypeNone:
        case FLDatabaseTypeNull:
            newObject = nil;
            break;
            
        case FLDatabaseTypeFloat:
        case FLDatabaseTypeInteger: 
            FLCConfirmIsNotNil_(newObject);
            FLCAssert_v([newObject isKindOfClass:[NSNumber class]], @"expecting a number here");
        break;
        
        case FLDatabaseTypeText:{
            FLCConfirmIsKindOfClass_(inObject, NSString);
            FLObjectDescriber* objectDescriber = [[table classRepresentedByTable] sharedObjectDescriber];
            if(objectDescriber) {
                FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:column.decodedColumnName];
                if(desc) {
                    newObject = [desc.propertyClass decodeObjectWithSqliteColumnString:inObject];
                }
            }
        }
        break;
			
        case FLDatabaseTypeDate:
            switch(column.columnType) {

                case FLDatabaseTypeFloat:
                    FLCConfirmIsKindOfClass_(inObject, NSNumber);
                    newObject = [NSDate dateWithTimeIntervalSinceReferenceDate:[inObject doubleValue]];
                    break;
                    
                case FLDatabaseTypeInteger:
                    FLCConfirmIsKindOfClass_(inObject, NSNumber);
                    newObject = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval) [inObject longLongValue]];
                    break;
                    
                default:
                    newObject = nil;
                    break;
            }
            
            FLCConfirmIsNotNil_(newObject);
            FLCAssert_v([newObject isKindOfClass:[NSDate class]], @"date deserialization failed");
        break;
			
        case FLDatabaseTypeBlob:
            FLCConfirmIsNotNil_(newObject);
            FLCConfirmIsKindOfClass_(newObject, NSData);
        break;
			           
        case FLDatabaseTypeObject: {
            FLObjectDescriber* objectDescriber = [[table classRepresentedByTable] sharedObjectDescriber];
            if(objectDescriber) {
                FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:column.decodedColumnName];
                if(desc) {
                    FLCConfirmIsKindOfClass_(inObject, NSData);
                    newObject = [desc.propertyClass decodeObjectWithSqliteColumnData:inObject];
                }
            }
        }
        break;
    }
    
    return newObject;
}


id FLLegacyDatabaseColumnDecoder(FLDatabase* database,
                                 FLDatabaseTable* table,
                                 FLDatabaseColumn* column,
                                 id object) {
   
    switch(column.columnType) {
            
        case FLDatabaseTypeInteger:
            if(column.columnType == FLDatabaseTypeText) {
                FLCConfirmIsKindOfClass_(object, NSString);
                object = [NSNumber numberWithInteger:[object integerValue]];
            }
        break;
        
        case FLDatabaseTypeFloat:
        case FLDatabaseTypeDate:
            if(column.columnType == FLDatabaseTypeText) {
                FLCConfirmIsKindOfClass_(object, NSString);
                object = [NSNumber numberWithDouble:[object doubleValue]];
            }
        break;
        
        case FLDatabaseTypeObject:
        case FLDatabaseTypeBlob:
            if(column.columnType == FLDatabaseTypeText) {
                FLCConfirmIsKindOfClass_(object, NSString);
                NSData* newData = nil;
                [NSData base64DecodeString:object outData:&newData];
                object = FLReturnAutoreleased(newData);

#if TRACE
                FLDebugLog(@"converted base64encoded object");
#endif                        
            }
        break;
        
        default:
        break;
    }
    return FLDefaultDatabaseColumnDecoder(database, table, column, object);
}

#if IOS
@implementation FLImage (SqlObjectDatabase)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data {
	return [FLImage imageWithData:data];
}
- (void) bindToStatement:(FLDatabaseIterator*) statement parameterIndex:(int) parameterIndex {
	NSData* data = UIImageJPEGRepresentation(self, 1.0f);
	[data bindToStatement:statement parameterIndex:parameterIndex];
}
+ (FLDatabaseType) sqlType {
	return FLDatabaseTypeObject;
}
@end
#endif