//
//  FLJsonDataEncoder.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonDataEncoder.h"
#import "FLGeometry.h"
#import "FLStringUtils.h"
#import "FLBase64Encoding.h"
#import "FLDateMgr.h"
#import "FLColor.h"

@implementation FLJsonDataEncoder

FLSynthesizeSingleton(FLJsonDataEncoder);

- (id) init
{
	if((self = [super init]))
	{
		_numberFormatter = [[NSNumberFormatter alloc] init];
	}
	
	return self;
}

// TODO: pretty sure this has never worked. Written and never used or tested

- (void) encodeDataToString:(id) data 
					forType:(FLDataTypeID) type
		   outEncodedString:(NSString**) outString
{
	switch(type)
	{
        
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
			FLAssert_v([data isKindOfClass:[NSNumber class]], @"expecting a NSNumber here");
			*outString = FLRetain([_numberFormatter stringFromNumber:data]);
		break;
		
		case FLDataTypeBool:
			FLAssert_v([data isKindOfClass:[NSNumber class]], @"expecting a NSNumber here");
			*outString = [data boolValue] ? @"true" : @"false";
		break;
		
		case FLDataTypeString:
			*outString = [[NSString alloc] initWithFormat:@"\"%@\"", [data jsonEncode]];
		break;
		
		case FLDataTypeData:
			*outString = [[NSString alloc] initWithBytes:[data bytes] 
									length:[data length] 
									encoding:NSUTF8StringEncoding];
		break;
		
		case FLDataTypeDate:
			*outString = [[NSString alloc] initWithFormat:@"\"%@\"", [[[FLDateMgr instance] ISO3339DateToString:(NSDate*) data] jsonEncode]]; 
		break;
        
        case FLDataTypeRect: {   
            CGRect r = [data FLRectValue];
            *outString = [NSString stringWithFormat:@"{\"x\"=%f,\"y\"=%f,\"width\"=%f,height=\"%f\"}",
                r.origin.x,
                r.origin.y,
                r.size.width,
                r.size.height];
            break;
        }
        case FLDataTypePoint: {
            CGPoint pt = [data FLPointValue];
            *outString = [NSString stringWithFormat:@"{\"x\"=%f,\"y\"=%f}",
                pt.x,
                pt.y];
            break;
        }
        
        case FLDataTypeSize:{   
            FLSize size = [data FLSizeValue];
            *outString = [NSString stringWithFormat:@"{\"width\"=%f,height=\"%f\"}",
                size.width,
                size.height];
            break;
        }

        break;
        
        case FLDataTypeColor: {
            FLColor_t color = [data color_t];
            *outString = [NSString stringWithFormat:@"{\"red\"=%d,\"green\"=%d,\"blue\"=%d,\"alpha=\"%f\"}",
                (int)color.red,
                (int)color.blue,
                (int)color.green,
                color.alpha];
        }
        break;
        
        case FLDataTypeURL:
        // TBD
        break;
        
        case FLDataTypeValue:
        case FLDataTypeObject:
            FLAssertFailed_v(@"don't know how to encode object");
        break;
        
        case FLDataTypeUnknown:
            FLAssertFailed_v(@"unknown type!");
        break;
		
	}

} 
@end

@implementation NSString (FLJsonDataEncoder)

- (NSString*) jsonEncode
{
	NSMutableString* json = [NSMutableString string];
	NSUInteger length = [self length];
	for (NSUInteger i = 0; i < length; i++) 
	{
		unichar c = [self characterAtIndex:i];
		switch (c) 
		{
			case '"':   
				[json appendString:@"\\\""];       
				break;

			case '\\':  
				[json appendString:@"\\\\"];       
				break;

			case '\t':  
				[json appendString:@"\\t"];        
				break;

			case '\n':  
				[json appendString:@"\\n"];        
				break;

			case '\r':  
				[json appendString:@"\\r"];        
				break;

			case '\b':  
				[json appendString:@"\\b"];        
				break;

			case '\f':  
				[json appendString:@"\\f"];        
				break;

			default:    
				if (c < 0x20) 
				{
					[json appendFormat:@"\\u%04x", c];
				} 
				else 
				{
					CFStringAppendCharacters(bridge_(CFMutableStringRef, json), &c, 1);
				}
				break;
				
		}
	}
	return json;
}
@end

//@interface NSString (FLJsonDataEncoder)
//- (NSString*) jsonEncode
//{
//	NSString* encoded = self;
//	encoded = [encoded stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
//	encoded = [encoded stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];	
//	return encoded;
//}
//
//@end
