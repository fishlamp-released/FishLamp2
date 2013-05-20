//
//  GtJsonDataEncoder.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtJsonDataEncoder.h"

#import "GtStringUtils.h"
#import "GtBase64Encoding.h"
#import "GtDateMgr.h"
#import "UIColor+More.h"

@implementation GtJsonDataEncoder

GtSynthesizeSingleton(GtJsonDataEncoder);

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
			GtAssert([data isKindOfClass:[NSNumber class]], @"expecting a NSNumber here");
			*outString = [[m_numberFormatter stringFromNumber:data] retain];
		break;
		
		case GtDataTypeBool:
			GtAssert([data isKindOfClass:[NSNumber class]], @"expecting a NSNumber here");
			*outString = [data boolValue] ? @"true" : @"false";
		break;
		
		case GtDataTypeString:
			*outString = [[NSString alloc] initWithFormat:@"\"%@\"", [data jsonEncode]];
		break;
		
		case GtDataTypeData:
			*outString = [[NSString alloc] initWithBytes:[data bytes] 
									length:[data length] 
									encoding:NSUTF8StringEncoding];
		break;
		
		case GtDataTypeDate:
			*outString = [[NSString alloc] initWithFormat:@"\"%@\"", [[[GtDateMgr instance] ISO3339DateToString:(NSDate*) data] jsonEncode]]; 
		break;
        
        case GtDataTypeRect: {   
            CGRect r = [data CGRectValue];
            *outString = [NSString stringWithFormat:@"{\"x\"=%f,\"y\"=%f,\"width\"=%f,height=\"%f\"}",
                r.origin.x,
                r.origin.y,
                r.size.width,
                r.size.height];
            break;
        }
        case GtDataTypePoint: {
            CGPoint pt = [data CGPointValue];
            *outString = [NSString stringWithFormat:@"{\"x\"=%f,\"y\"=%f}",
                pt.x,
                pt.y];
            break;
        }
        
        case GtDataTypeSize:{   
            CGSize size = [data CGSizeValue];
            *outString = [NSString stringWithFormat:@"{\"width\"=%f,height=\"%f\"}",
                size.width,
                size.height];
            break;
        }

        break;
        
        case GtDataTypeColor: {
            GtColorStruct color = [data colorStruct];
            *outString = [NSString stringWithFormat:@"{\"red\"=%d,\"green\"=%d,\"blue\"=%d,\"alpha=\"%f\"}",
                (int)color.red,
                (int)color.blue,
                (int)color.green,
                color.alpha];
        }
        break;
        
        case GtDataTypeValue:
        case GtDataTypeObject:
            GtAssertFailed(@"don't know how to encode object");
        break;
        
        case GtDataTypeUnknown:
            GtAssertFailed(@"unknown type!");
        break;
		
	}

} 
@end

@implementation NSString (GtJsonDataEncoder)

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
					CFStringAppendCharacters((CFMutableStringRef)json, &c, 1);
				}
				break;
				
		}
	}
	return json;
}
@end

//@interface NSString (GtJsonDataEncoder)
//- (NSString*) jsonEncode
//{
//	NSString* encoded = self;
//	encoded = [encoded stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
//	encoded = [encoded stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];	
//	return encoded;
//}
//
//@end
