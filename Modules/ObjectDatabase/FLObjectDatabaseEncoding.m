//
//  FLDatabaseObjectEncoding.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLObjectDatabaseEncoding.h"

@implementation FLObjectDatabaseIterator (FLObjectDatabaseEncoding);

+ (id) decodeColumnObject:(NSString*) columnName 
                    object:(id) object 
                   sqlType:(FLSqliteType) sqlType 
           objectDescriber:(FLObjectDescriber*) objectDescriber
                     table:(FLSqliteTable*) table {
   
	FLAssertIsNotNil(table);
	
	if(!object) {
		return nil;
	}
	
	FLSqliteColumn* column = [table columnByName:columnName];
	if(column) {
		switch(column.columnType) {
            case FLSqliteTypeNone:
            case FLSqliteTypeNull:
                return nil;
                break;
                
			case FLSqliteTypeFloat:
			case FLSqliteTypeInteger: {
                static NSNumberFormatter* s_numberFormatter = nil;
                if(!s_numberFormatter) {
                    s_numberFormatter = [[NSNumberFormatter alloc] init];
                }			
				switch(sqlType) {
#if FL_LEGACY_DB_ENCODING
					case FLSqliteTypeText:
						FLAssertIsType(object, NSString);
						object = [s_numberFormatter numberFromString:object];
						break;
#endif					
					case FLSqliteTypeInteger:
					case FLSqliteTypeFloat:
						// already what we expect.
						FLAssertIsType(object, NSNumber);
						break;
						
					default:
						FLAssertFailed(@"unexpected type: %d", sqlType);
						break;
				}
				FLAssertIsNotNil(object);
				FLAssert([object isKindOfClass:[NSNumber class]], @"expecting a number here");
            }
			break;
			
			case FLSqliteTypeText:{
             	FLAssertIsType(object, NSString);
				FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:column.decodedColumnName];
				object = [desc.propertyClass decodeObjectWithSqliteColumnString:object];
            }
			break;
			
			case FLSqliteTypeDate:
				switch(sqlType) {
#if FL_LEGACY_DB_ENCODING
					case FLSqliteTypeText:
						FLAssertIsType(NSString);
						object = [NSDate dateWithTimeIntervalSinceReferenceDate:[object doubleValue]];
						break;
#endif						
					case FLSqliteTypeFloat:
						FLAssertIsType(object, NSNumber);
						object = [NSDate dateWithTimeIntervalSinceReferenceDate:[object doubleValue]];
						break;
						
					case FLSqliteTypeInteger:
						FLAssertIsType(object, NSNumber);
						object = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval) [object longLongValue]];
						break;
						
					default:
						//FLAssertFailed(@"unexpected type: %d", sqlType);
						object = nil;
						break;
				}
				
				FLAssertIsNotNil(object);
				FLAssert([object isKindOfClass:[NSDate class]], @"date deserialization failed");
			break;
			
			case FLSqliteTypeBlob:
				FLAssert([object isKindOfClass:[NSObject class]], @"expecting NSData");
				switch(sqlType) {
#if FL_LEGACY_DB_ENCODING
					case FLSqliteTypeText:
						FLAssertIsType(NSString);
						[NSData base64DecodeString:object outData:&object];
						FLAutorelease(object);
						
#if TRACE
						FLDebugLog(@"converted base64encoded object");
#endif                        

						break;
#endif					
					case FLSqliteTypeBlob:
						FLAssertIsType(object, NSData);
						// already what we expected.
						break;
						
					default:
						FLAssertFailed(@"unexpected type: %d", sqlType);
						break;
					
				}
				FLAssertIsNotNil(object);
			break;
			           
			case FLSqliteTypeObject: {
				FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:column.decodedColumnName];
				switch(sqlType) {

#if FL_LEGACY_DB_ENCODING
					case FLSqliteTypeText: {
						NSData* decodedData = nil;
						FLAssertIsType(NSString);
					
						@try {
							if([object length] > 0) {
								[NSData base64DecodeString:object outData:&decodedData];
								
								object = [desc.propertyClass decodeObjectWithSqliteColumnData:decodedData];
							
#if TRACE
								FLDebugLog(@"converted base64encoded object");
#endif                                
							}
							else  {
								object = nil;
							}
						}
						@finally {
							 FLRelease(decodedData);
						}
					}
					
					break;
#endif					
					case FLSqliteTypeBlob:
						FLAssertIsType(object, NSData);
//							object = [NSKeyedUnarchiver unarchiveObjectWithData:object];
						object = [desc.propertyClass decodeObjectWithSqliteColumnData:object];

					break;
			
					default:
						FLAssertFailed(@"unexpected type: %d", sqlType);
					break;
			
				}
			}
			break;
			

				
		}
	}
	return object;
}

@end



#if IOS
@implementation CocoaImage (SqlObjectDatabase)
+ (id) decodeObjectWithSqliteColumnData:(NSData*) data {
	return [CocoaImage imageWithData:data];
}
- (void) bindToStatement:(FLSqliteStatement*) statement parameterIndex:(int) parameterIndex {
	NSData* data = UIImageJPEGRepresentation(self, 1.0f);
	[data bindToStatement:statement parameterIndex:parameterIndex];
}
+ (FLSqliteType) sqlType {
	return FLSqliteTypeObject;
}
@end
#endif

