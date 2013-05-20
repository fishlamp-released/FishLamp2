//
//  GtSoapDataEncoder.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapDataEncoder.h"

#import "GtDateMgr.h"
#import "GtStringUtils.h"
#import "GtBase64Encoding.h"
#import "UIColor+More.h"

@implementation GtSoapDataEncoder

GtSynthesizeSingleton(GtSoapDataEncoder);

- (id) init
{
	if((self = [super init]))
	{
		m_numberFormatter = [[NSNumberFormatter alloc] init];
	}
	
	return self;
}

- (void) encodeDataToString:(id) data 
				forType:(GtDataTypeID) type
		      outEncodedString:(NSString**) outString;
{
	switch(type)
	{
		case GtDataTypeChar:
		case GtDataTypeUnsignedChar:
		case GtDataTypeShort:
		case GtDataTypeUnsignedShort:
		case GtDataTypeNSInteger:
		case GtDataTypeInteger:
		case GtDataTypeNSUInteger:
		case GtDataTypeEnum:
		case GtDataTypeUnsignedInteger:
		case GtDataTypeLong:
		case GtDataTypeUnsignedLong:
		case GtDataTypeLongLong:
		case GtDataTypeUnsignedLongLong:
		case GtDataTypeFloat:
		case GtDataTypeDouble:
		case GtDataTypeBool:
			GtAssert([data isKindOfClass:[NSNumber class]], @"expecting a NSNumber here");
			*outString = [[m_numberFormatter stringFromNumber:data] retain];
		break;
		
		case GtDataTypeString:
			*outString = GtRetain([data xmlEncode]);
		break;
		
		case GtDataTypeData:
			*outString = [[NSString alloc] initWithBytes:[data bytes] 
									length:[data length] 
									encoding:NSUTF8StringEncoding];
		break;
		
		case GtDataTypeDate:
			*outString = [[[GtDateMgr instance] ISO8601DateToString:(NSDate*) data] retain]; 
		break;
	
        case GtDataTypePoint:
            *outString = NSStringFromCGPoint([data CGPointValue]);
            break;
            
        case GtDataTypeRect:
            *outString = NSStringFromCGRect([data CGRectValue]);
            break;

        case GtDataTypeSize:
            *outString = NSStringFromCGSize([data CGSizeValue]);
            break;

        case GtDataTypeValue:
        case GtDataTypeUnknown:
        case GtDataTypeObject:
            break;
    
        case GtDataTypeColor:
            *outString = [data toRgbString];
        break;
        
	}

} 

- (void) decodeDataFromString:(NSString*) encodedDataString
				forType:(GtDataTypeID) type
		   outObject:(id*) outDecodedObject		
{
	switch(type)
	{
		case GtDataTypeChar:
		case GtDataTypeUnsignedChar:
		case GtDataTypeShort:
		case GtDataTypeUnsignedShort:
		case GtDataTypeNSInteger:
		case GtDataTypeInteger:
		case GtDataTypeNSUInteger:
		case GtDataTypeEnum:
		case GtDataTypeUnsignedInteger:
		case GtDataTypeLong:
		case GtDataTypeUnsignedLong:
		case GtDataTypeLongLong:
		case GtDataTypeUnsignedLongLong:
		case GtDataTypeFloat:
		case GtDataTypeDouble:
		{
			NSNumber* number = [m_numberFormatter numberFromString:encodedDataString];
			if(number)
			{
				*outDecodedObject = GtRetain(number);
			}
		}
		break;
		
		case GtDataTypeData:
			[NSData base64DecodeString:encodedDataString outData:outDecodedObject];
		break;
		
		case GtDataTypeBool:
			*outDecodedObject = [[NSNumber alloc] initWithBool:[encodedDataString boolValue]];
		break;
		
		case GtDataTypeDate:
			*outDecodedObject = GtRetain([[GtDateMgr instance] ISO8601StringToDate:encodedDataString]);
		break;
	
		case GtDataTypeString:
			*outDecodedObject = GtRetain([encodedDataString xmlDecode]);
		break;
        
        case GtDataTypeColor:
            *outDecodedObject = GtRetain([UIColor colorWithRgbString:encodedDataString]);
        break;
	
        case GtDataTypePoint:
            *outDecodedObject = GtRetain([NSValue valueWithCGPoint:CGPointFromString(encodedDataString)]);
            break;
            
        case GtDataTypeRect:
            *outDecodedObject = GtRetain([NSValue valueWithCGRect:CGRectFromString(encodedDataString)]);
            break;
        
        case GtDataTypeSize:
            *outDecodedObject = GtRetain([NSValue valueWithCGSize:CGSizeFromString(encodedDataString)]);
            break;
        
        case GtDataTypeValue:
        case GtDataTypeUnknown:
        case GtDataTypeObject:
            break;

	}
}
@end
