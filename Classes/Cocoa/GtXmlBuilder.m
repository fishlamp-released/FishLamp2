//
//	GtXmlBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtXmlBuilder.h"
#import "GtStringUtils.h"
#import "GtDataEncoder.h"

#define EOL @"\r\n"

@implementation GtXmlBuilder

@synthesize dataEncoder = m_dataEncoder;

// NOTE: init in superclass calls initWithPrettyPrint.

- (id) initWithPrettyPrint:(BOOL) prettyPrint
{
	if((self = [super initWithPrettyPrint:prettyPrint]))
	{
	}
	return self;
}

+ (GtXmlBuilder*) xmlBuilder
{
	return GtReturnAutoreleased([[GtXmlBuilder alloc] init]);
}

+ (GtXmlBuilder*) xmlBuilderWithPrettyPrint:(BOOL) prettyPrint
{
	return GtReturnAutoreleased([[GtXmlBuilder alloc] initWithPrettyPrint:prettyPrint]);
}

-(void)dealloc
{
	GtRelease(m_attribute);
	GtRelease(m_dataEncoder);
	GtRelease(m_attributes);
	GtSuperDealloc();
}

-(void) addVersionAndEncodingHeader
{
	[self appendLine:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
}

- (NSString*) eol
{
	return EOL;
}

-(void) openElementWithAttributes:(NSString*) elementName
{
	if(m_attributes && [m_attributes count] > 0)
	{
		[self appendFormat:@"<%@", elementName];
		for(int i = [m_attributes count]-1; i >= 0; i--)
		{
			[self appendFormat:@" %@", [m_attributes objectAtIndex:i]];
		}
		[self appendString:@">"];
		[m_attributes removeAllObjects];
	}
	else
	{
		[self appendFormat:@"<%@>", elementName];
	}
//	[self tabIn];
}	

- (void) openAttribute
{
	GtReleaseWithNil(m_attribute);
	m_attribute = [[NSMutableString alloc] init];
}

- (void) addDataToAttribute:(NSString*) data
{
	[m_attribute appendString:data];
}

- (void) addDataWithFormatToAttribute:(NSString*) data, ...
{
	va_list va;
	va_start(va, data);
	NSString *string = [[NSString alloc] initWithFormat:data arguments:va];
	va_end(va);
	[m_attribute appendString:string];
	GtReleaseWithNil(string);
}

- (void) closeAttribute:(NSString*) attrName
{
	[self pushAttributeString:m_attribute attributeName:attrName];
	GtReleaseWithNil(m_attribute);
}

- (void) addComments
{
	for(NSString* comment in m_comments)
	{
		[self addComment:comment];
	}
	
	[m_comments removeAllObjects];
}



-(void)openElement:(NSString*) elementName
{
	[self openElementWithAttributes:elementName];
	[self appendLine];
	[self addComments];
	
	NSString* closeTag = [[NSString alloc] initWithFormat:@"</%@>", elementName];
	[self appendString:closeTag];
	GtRelease(closeTag);
}

- (void) addElementValueWithString:(NSString*) dataString
{
	if(dataString)
	{
		[self appendLine:dataString];
	}
}

//- (void) createElement:(NSString*) elementName	forType:(GtDataTypeStruct*) type
//{
//}

- (void) addComment:(NSString*) comment
{
	if(GtStringIsNotEmpty(comment))
	{
		[self appendLineWithFormat:@"<!-- %@ -->", comment];
	}
}

#ifndef NEW_BUILDER

- (void) streamObject:(id) object
{
	[object streamSelfTo:self dataType:[[object class] dataTypeStruct]];
}

- (void) beginStreamingObjectForType:(GtDataTypeStruct*) type
{
	[self openElement:type->key];
}

- (void) writeObjectToStream:(id) object forType:(GtDataTypeStruct*) type
{
	if(type->typeID == GtDataTypeObject)
	{
		[object streamSelfTo:self dataType:type];
	}
	else
	{
		[self addElementValueWithObject:object forType:type];
	}
}

- (void) endStreamingObjectForType:(GtDataTypeStruct*) type
{
	[self closeElement];
}


- (void) addElementValueWithObject:(id) object	forType:(GtDataTypeStruct*) type
{
	if(object)
	{
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:type->typeID outEncodedString:&string];
		@try
		{
			[self addElementValueWithString:string];
		}
		@finally
		{
			GtRelease(string);
		}
	}
}

- (void) pushAttributeObject:(id) object attributeName:(NSString*)name forType:(GtDataTypeStruct*) type
{
	if(object)
	{
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:type->typeID outEncodedString:&string];
		@try
		{
			[self pushAttributeString:string attributeName:name];
		}
		@finally
		{
			GtRelease(string);
		}
	}
}


- (void) addElementWithObjectValue:(id) object elementName:(NSString*) elementName forType:(GtDataTypeStruct*) type
{
	if(object)
	{
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:type->typeID outEncodedString:&string];
		@try
		{
			[self addElementWithStringValue:string elementName:elementName];
		}
		@finally
		{
			GtRelease(string);
		}
	}
}


#endif

-(void)closeElement
{
// FIXME
//	[self closeScope];
}

- (void) pushComment:(NSString*) comment
{
	if(!m_comments)
	{
		m_comments = [[NSMutableArray alloc] init];
	}

	[m_comments addObject:comment];
}

- (void) pushAttributeString:(NSString*) string attributeName:(NSString*)name
{
	if(!m_attributes)
	{
		m_attributes = [[NSMutableArray alloc] init];
	}

	NSString* attr = [[NSString alloc] initWithFormat:@"%@=\"%@\"", name, string];
	[m_attributes addObject:attr];
	GtRelease(attr);
}


- (void) addElementWithStringValue:(NSString*) string elementName:(NSString*) elementName
{
	if(m_comments.count)
	{
		[self openElement:elementName];
		[self addElementValueWithString:string];
		[self closeElement];
	}
	else
	{
		[self openElementWithAttributes:elementName];
		[self appendFormat:@"%@</%@>", string ? string : @"", elementName];
		[self appendLine];
//		[self tabOut];
	}
}


@end
