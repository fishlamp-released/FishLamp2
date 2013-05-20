//
//  GtJsonBuilder.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtJsonBuilder.h"

@implementation GtJsonBuilder

@synthesize dataEncoder = m_dataEncoder;

-(void)dealloc
{
	GtRelease(m_dataEncoder);
	GtSuperDealloc();
}


- (void) addElementValueWithString:(NSString*) dataString
{
	if(dataString)
	{
		[self appendLine:dataString];
	}
}

// TODO: fix this
//- (void) beginStreamingObjectForType:(GtDataTypeStruct*) type
//{
//	if(type->typeID == GtDataTypeObject)
//	{
//		[self appendFormat:@"\"%@\": {", type->key];
//		[self appendLine];
//	}
//	else
//	{
//		[self appendFormat:@"\"%@\": ", type->key];
//	}
//}


//- (void) addElementValueWithObject:(id) object	forType:(GtDataTypeStruct*) type
//{
//	if(object)
//	{
//		NSString* string = nil;
//		[self.dataEncoder encodeDataToString:object forType:type->typeID outEncodedString:&string];
//		@try
//		{
//			[self addElementValueWithString:string];
//		}
//		@finally
//		{
//			GtRelease(string);
//		}
//	}
//}
//
//- (void) writeObjectToStream:(id) object forType:(GtDataTypeStruct*) type
//{
//	if(type->typeID == GtDataTypeObject)
//	{
//		[object streamSelfTo:self dataType:type];
//	}
//	else
//	{
//		[self addElementValueWithObject:object forType:type];
//	}
//}
//
//- (void) endStreamingObjectForType:(GtDataTypeStruct*) type
//{
//	if(type->typeID == GtDataTypeObject)
//	{
//		[self appendString:@"}"];
//	}
//	[self appendLine];
//}
//
- (void) streamObject:(id) object
{
//	[object streamSelfTo:self dataType:[[object class] dataTypeStruct]];
}


@end
