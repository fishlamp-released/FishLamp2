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
#import "FLColor+FLExtras.h"
#import "FLCocoaCompatibility.h"
#import "NSValue+FLCocoaCompatibility.h"

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
			*outString = FLReturnRetained([_numberFormatter stringFromNumber:data]);
		break;
		
		case FLDataTypeString:
			*outString = FLReturnRetained([data xmlEncode]);
		break;
		
		case FLDataTypeData:
			*outString = [[NSString alloc] initWithBytes:[data bytes] 
									length:[data length] 
									encoding:NSUTF8StringEncoding];
		break;
		
		case FLDataTypeDate:
			*outString = FLReturnRetained([[FLDateMgr instance] ISO8601DateToString:(NSDate*) data]); 
		break;
	
        case FLDataTypePoint:
            *outString = FLReturnRetained(NSStringFromFLPoint([data FLPointValue]));
            break;
            
        case FLDataTypeRect:
            *outString = FLReturnRetained(NSStringFromFLRect([data FLRectValue]));
            break;

        case FLDataTypeSize:
            *outString = FLReturnRetained(NSStringFromFLSize([data FLSizeValue]));
            break;

        case FLDataTypeValue:
        case FLDataTypeUnknown:
        case FLDataTypeObject:
            break;
    
        case FLDataTypeColor:
            *outString = FLReturnRetained([data toRgbString]);
        break;
     
        case FLDataTypeURL:
            *outString = FLReturnRetained([data absoluteString]); 
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
				*outDecodedObject = FLReturnRetained(number);
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
			*outDecodedObject = FLReturnRetained([[FLDateMgr instance] ISO8601StringToDate:encodedDataString]);
		break;
	
		case FLDataTypeString:
			*outDecodedObject = FLReturnRetained([encodedDataString xmlDecode]);
		break;
        
        case FLDataTypeColor:
            *outDecodedObject = FLReturnRetained([FLColor colorWithRgbString:encodedDataString]);
        break;
	
        case FLDataTypePoint:
            *outDecodedObject = FLReturnRetained([NSValue valueWithFLPoint:FLPointFromString(encodedDataString)]);
            break;
            
        case FLDataTypeRect:
            *outDecodedObject = FLReturnRetained([NSValue valueWithFLRect:FLRectFromString(encodedDataString)]);
            break;
        
        case FLDataTypeSize:
            *outDecodedObject = FLReturnRetained([NSValue valueWithFLSize:FLSizeFromString(encodedDataString)]);
            break;
        
        case FLDataTypeURL:
            *outDecodedObject = FLReturnRetained([[NSURL alloc] initWithString:encodedDataString]);
            break;
        
        case FLDataTypeValue:
        case FLDataTypeUnknown:
        case FLDataTypeObject:
            break;

	}
}
@end
