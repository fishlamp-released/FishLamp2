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
			*outString = retain_([_numberFormatter stringFromNumber:data]);
		break;
		
		case FLDataTypeString:
			*outString = retain_([data xmlEncode]);
		break;
		
		case FLDataTypeData:
			*outString = [[NSString alloc] initWithBytes:[data bytes] 
									length:[data length] 
									encoding:NSUTF8StringEncoding];
		break;
		
		case FLDataTypeDate:
			*outString = retain_([[FLDateMgr instance] ISO8601DateToString:(NSDate*) data]); 
		break;
	
        case FLDataTypePoint:
            *outString = retain_(FLStringFromPoint([data SDKPointValue]));
            break;
            
        case FLDataTypeRect:
            *outString = retain_(NSStringFromSDKRect([data SDKRectValue]));
            break;

        case FLDataTypeSize:
            *outString = retain_(NSStringFromSDKSize([data SDKSizeValue]));
            break;

        case FLDataTypeValue:
        case FLDataTypeUnknown:
        case FLDataTypeObject:
            break;
    
        case FLDataTypeColor:
            *outString = retain_([data toRgbString]);
        break;
     
        case FLDataTypeURL:
            *outString = retain_([data absoluteString]); 
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
				*outDecodedObject = retain_(number);
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
			*outDecodedObject = retain_([[FLDateMgr instance] ISO8601StringToDate:encodedDataString]);
		break;
	
		case FLDataTypeString:
			*outDecodedObject = retain_([encodedDataString xmlDecode]);
		break;
        
        case FLDataTypeColor:
            *outDecodedObject = retain_([SDKColor colorWithRgbString:encodedDataString]);
        break;
	
        case FLDataTypePoint:
            *outDecodedObject = retain_([NSValue valueWithSDKPoint:FLPointFromString(encodedDataString)]);
            break;
            
        case FLDataTypeRect:
            *outDecodedObject = retain_([NSValue valueWithSDKRect:FLRectFromString(encodedDataString)]);
            break;
        
        case FLDataTypeSize:
            *outDecodedObject = retain_([NSValue valueWithSDKSize:FLSizeFromString(encodedDataString)]);
            break;
        
        case FLDataTypeURL:
            *outDecodedObject = retain_([[NSURL alloc] initWithString:encodedDataString]);
            break;
        
        case FLDataTypeValue:
        case FLDataTypeUnknown:
        case FLDataTypeObject:
            break;

	}
}
@end
