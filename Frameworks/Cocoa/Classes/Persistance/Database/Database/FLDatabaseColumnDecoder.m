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
#import "FLBase64Encoding.h"
#import "FLSqlStatement.h"

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
            FLConfirmIsNotNil(newObject);
            FLAssertWithComment([newObject isKindOfClass:[NSNumber class]], @"expecting a number here");
        break;
        
        case FLDatabaseTypeText:{
            FLConfirmIsKindOfClass(inObject, NSString);
            FLObjectDescriber* objectDescriber = [[table classRepresentedByTable] objectDescriber];
            if(objectDescriber) {
                FLObjectDescriber* property = [objectDescriber childDescriberForObjectName:column.decodedColumnName];
                if(property) {
                    newObject = [property.objectClass decodeObjectWithSqliteColumnString:inObject];
                }
            }
        }
        break;
			
        case FLDatabaseTypeDate:
            switch(column.columnType) {

                case FLDatabaseTypeFloat:
                    FLConfirmIsKindOfClass(inObject, NSNumber);
                    newObject = [NSDate dateWithTimeIntervalSinceReferenceDate:[inObject doubleValue]];
                    break;
                    
                case FLDatabaseTypeInteger:
                    FLConfirmIsKindOfClass(inObject, NSNumber);
                    newObject = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval) [inObject longLongValue]];
                    break;
                    
                default:
                    newObject = nil;
                    break;
            }
            
            FLConfirmIsNotNil(newObject);
            FLAssertWithComment([newObject isKindOfClass:[NSDate class]], @"date deserialization failed");
        break;
			
        case FLDatabaseTypeBlob:
            FLConfirmIsNotNil(newObject);
            FLConfirmIsKindOfClass(newObject, NSData);
        break;
			           
        case FLDatabaseTypeObject: {
            FLObjectDescriber* objectDescriber = [[table classRepresentedByTable] objectDescriber];
            if(objectDescriber) {
                FLObjectDescriber* property = [objectDescriber childDescriberForObjectName:column.decodedColumnName];
                if(property) {
                    FLConfirmIsKindOfClass(inObject, NSData);
                    newObject = [property.objectClass decodeObjectWithSqliteColumnData:inObject];
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
                FLConfirmIsKindOfClass(object, NSString);
                object = [NSNumber numberWithInteger:[object integerValue]];
            }
        break;
        
        case FLDatabaseTypeFloat:
        case FLDatabaseTypeDate:
            if(column.columnType == FLDatabaseTypeText) {
                FLConfirmIsKindOfClass(object, NSString);
                object = [NSNumber numberWithDouble:[object doubleValue]];
            }
        break;
        
        case FLDatabaseTypeObject:
        case FLDatabaseTypeBlob:
            if(column.columnType == FLDatabaseTypeText) {
                FLConfirmIsKindOfClass(object, NSString);
                object = [object base64Decode];
//                [NSData base64DecodeString:object outData:&newData];
//                object = FLAutorelease(newData);

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


