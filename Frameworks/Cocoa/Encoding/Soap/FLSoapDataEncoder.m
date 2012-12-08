//
//  FLSoapDataEncoder.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSoapDataEncoder.h"

#import "FLDateMgr.h"
#import "FLStringUtils.h"
#import "FLBase64Encoding.h"
#import "FLColor.h"


@implementation FLSoapDataEncoder

FLSynthesizeSingleton(FLSoapDataEncoder);

- (id) init {
	if((self = [super init])) {
		_numberFormatter = [[NSNumberFormatter alloc] init];
	}
	
	return self;
}

- (void) encodeDataToString:(id) data 
				forType:(FLDataTypeID) type
		      outEncodedString:(NSString**) outString {
	
    switch(type) {
		case FLDataTypeChar:
		case FLDataTypeUnsignedChar:
		case FLDataTypeShort:
		case FLDataTypeUnsignedShort:
		case FLDataTypeNSInteger:
		case FLDataTypeInteger:
		case FLDataTypeNSUInteger:
		case FLDataTypeEnum:
		case FLDataTypeUnsignedInteger:
		case FLDataTypeLong:
		case FLDataTypeUnsignedLong:
		case FLDataTypeLongLong:
		case FLDataTypeUnsignedLongLong:
		case FLDataTypeFloat:
		case FLDataTypeDouble:
		case FLDataTypeBool:
			FLAssert_v([data isKindOfClass:[NSNumber class]], @"expecting a NSNumber here");
			*outString = FLRetain([_numberFormatter stringFromNumber:data]);
		break;
		
		case FLDataTypeString:
			*outString = FLRetain([data xmlEncode]);
		break;
		
		case FLDataTypeData:
			*outString = [[NSString alloc] initWithBytes:[data bytes] 
									length:[data length] 
									encoding:NSUTF8StringEncoding];
		break;
		
		case FLDataTypeDate:
			*outString = FLRetain([[FLDateMgr instance] ISO8601DateToString:(NSDate*) data]); 
		break;
	
        case FLDataTypePoint:
            *outString = FLRetain(NSStringFromCGPoint([data CGPointValue]));
            break;
            
        case FLDataTypeRect:
            *outString = FLRetain(NSStringFromCGRect([data CGRectValue]));
            break;

        case FLDataTypeSize:
            *outString = FLRetain(NSStringFromCGSize([data CGSizeValue]));
            break;

        case FLDataTypeValue:
        case FLDataTypeUnknown:
        case FLDataTypeObject:
            break;
    
        case FLDataTypeColor:
            *outString = FLRetain([data toRgbString]);
        break;
     
        case FLDataTypeURL:
            *outString = FLRetain([data absoluteString]); 
        break;
    }
} 

- (void) decodeDataFromString:(NSString*) encodedDataString
				forType:(FLDataTypeID) type
		   outObject:(id*) outDecodedObject	
{
	switch(type) {
		case FLDataTypeChar:
		case FLDataTypeUnsignedChar:
		case FLDataTypeShort:
		case FLDataTypeUnsignedShort:
		case FLDataTypeNSInteger:
		case FLDataTypeInteger:
		case FLDataTypeNSUInteger:
		case FLDataTypeEnum:
		case FLDataTypeUnsignedInteger:
		case FLDataTypeLong:
		case FLDataTypeUnsignedLong:
		case FLDataTypeLongLong:
		case FLDataTypeUnsignedLongLong:
		case FLDataTypeFloat:
		case FLDataTypeDouble: {
			NSNumber* number = [_numberFormatter numberFromString:encodedDataString];
			if(number) {
				*outDecodedObject = FLRetain(number);
			}
		}
		break;
		
		case FLDataTypeData:
			[NSData base64DecodeString:encodedDataString outData:outDecodedObject];
		break;
		
		case FLDataTypeBool:
			*outDecodedObject = [[NSNumber alloc] initWithBool:[encodedDataString boolValue]];
		break;
		
		case FLDataTypeDate:
			*outDecodedObject = FLRetain([[FLDateMgr instance] ISO8601StringToDate:encodedDataString]);
		break;
	
		case FLDataTypeString:
			*outDecodedObject = FLRetain([encodedDataString xmlDecode]);
		break;
        
        case FLDataTypeColor:
            *outDecodedObject = FLRetain([FLColor colorWithRgbString:encodedDataString]);
        break;
	
        case FLDataTypePoint:
            *outDecodedObject = FLRetain([NSValue valueWithCGPoint:CGPointFromString(encodedDataString)]);
            break;
            
        case FLDataTypeRect:
            *outDecodedObject = FLRetain([NSValue valueWithCGRect:CGRectFromString(encodedDataString)]);
            break;
        
        case FLDataTypeSize:
            *outDecodedObject = FLRetain([NSValue valueWithCGSize:CGSizeFromString(encodedDataString)]);
            break;
        
        case FLDataTypeURL:
            *outDecodedObject = FLRetain([[NSURL alloc] initWithString:encodedDataString]);
            break;
        
        case FLDataTypeValue:
        case FLDataTypeUnknown:
        case FLDataTypeObject:
            break;

	}
}
@end
