//
//	GtXmlParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtXmlParser.h"
#import "GtBase64Encoding.h"
#import "GtStringBuilder.h"
#import "NSObject+GtStreamableObject.h"
#import "GtDataEncoder.h"
#import "NSObject+XML.h"

#import "GtPropertyDescription.h"

@interface GtXmlParser ()
@property (readwrite, retain, nonatomic) NSData* data;
@property (readwrite, retain, nonatomic) GtObjectInflatorState* parseState;
@end

@implementation GtXmlParser

@synthesize data = m_data;
@synthesize parseState = m_parseState;

+ (GtXmlParser*) xmlParser:(NSData*) data
{
	return GtReturnAutoreleased([[GtXmlParser alloc] initWithXmlData:data]);
}

- (void) buildObjects:(id) rootObject
{
	GtReleaseWithNil(m_parseState);
	m_parseState = [[GtObjectInflatorState alloc] init];
	m_parseState.object = rootObject;	 
	[super parse:self.data];
}

- (id) initWithXmlData:(NSData*) data
{
	if((self = [super init]))
	{
		self.data = data;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_parseState);
	GtRelease(m_data);
	GtSuperDealloc();
}

- (void) startParsing:(NSString*) elementName isAttribute:(BOOL) isAttribute
{
	GtObjectInflatorState* newState = [[GtObjectInflatorState alloc] init];
	newState.key = elementName;
	newState.prev = m_parseState;
	newState.object = m_parseState.object;

#if NEW_PARSER
	newState.objectDescriber = [[newState.object class] sharedObjectDescriber];
#else
	newState.type = m_parseState.type;
#endif

	newState.dataIsAttribute = isAttribute;
	self.parseState = newState;

#if NEW_PARSER
	if(![newState.object beginParsingFrom:self state:newState])
#else	
	if(![newState.object beginStreamingFrom:newState] || !newState.type)
#endif
	{
		self.error = [NSError errorWithDomain:GtXmlParserDomain code:GtXmlParserErrorCodeUnknownElement localizedDescription:[NSString stringWithFormat:@"Unknown XML %@: %@", isAttribute ? @"attribute" : @"element", elementName]];
	}
	
	GtAssertNotNil(newState.object);
	GtRelease(newState);
}

- (void) finishParsing:(NSString*) elementName
{
	GtAssertNotNil(m_parseState.object);
	NSString* unparsedData = m_parseState.data; 
	if(unparsedData	 && unparsedData.length > 0)
	{
		unparsedData = [unparsedData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
		if(unparsedData.length > 0)
		{
#if NEW_PARSER
			if(m_parseState.parsedDataType != GtDataTypeUnknown)
			{	
				id inflatedObject = nil;
				[self.dataDecoder decodeDataFromString:unparsedData forType:m_parseState.parsedDataType outObject:&inflatedObject]; 
#else			
			if(m_parseState.type)
			{	
				id inflatedObject = nil;
				[self.dataDecoder decodeDataFromString:unparsedData forType:m_parseState.type->typeID outObject:&inflatedObject]; 
#endif

				if(inflatedObject)
				{
					m_parseState.data = inflatedObject;
				}
				else
				{
					m_parseState.data = unparsedData; // trimmed.
				}
				
#if NEW_PARSER
				[m_parseState.object finishParsingFrom:self state:m_parseState];
#else
				[m_parseState.object finishStreamingFrom:m_parseState];
#endif
				GtRelease(inflatedObject);
			}
#if DEBUG	 
			else
			{
				GtLog(@"Warning: %@ doesn't know about %@: %@: data: %@", NSStringFromClass([m_parseState.object class]), m_parseState.dataIsAttribute ? @"attribute" : @"element", elementName, unparsedData); 
			
			}
#endif				  
		}
	}
	

	self.parseState = m_parseState.prev;
}

- (void)parser:(NSXMLParser *)parser 
			didStartElement:(NSString *)elementName 
			  namespaceURI:(NSString *)namespaceURI 
			 qualifiedName:(NSString *)qName 
				attributes:(NSDictionary *)attributes
{
	@try
	{
		if(!m_xmlParserFlags.gotFirstElement)
		{
			m_xmlParserFlags.gotFirstElement = YES;
		}
		else
		{
			[self startParsing:elementName isAttribute:NO];
		}
		
		if(attributes && attributes.count > 0)
		{
			for(NSString* key in attributes)
			{
			// what if object doesn't want attributes?
				[self startParsing:key isAttribute:YES];
				self.parseState.data = [attributes valueForKey:key];
				[self finishParsing:key];
			}
		}
	}
	@catch(NSException* ex)
	{
		self.error = ex.error;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(m_parseState && string.length > 0)
	{
		if(!m_parseState.data)
		{
			m_parseState.data = [NSMutableString stringWithString:string];
		}
		else
		{
			[m_parseState.data appendString:string];
		}
	}
}

- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName
{
	@try
	{
		[self finishParsing:elementName];
	}
	@catch(NSException* ex)
	{
		self.error = ex.error;
	}
}

@end





