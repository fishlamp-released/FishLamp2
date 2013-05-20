//
//	GtBaseXmlParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/6/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBaseXmlParser.h"
#import "GtDataEncoder.h"

@implementation GtBaseXmlParser
@synthesize dataDecoder = m_dataDecoder;

@synthesize error = m_error;
@synthesize parser = m_parser;

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (void) dealloc
{
	m_parser.delegate = nil;
	GtRelease(m_parser);
	GtRelease(m_error);
	GtRelease(m_dataDecoder);
	GtSuperDealloc();
}

- (void) setError:(NSError*) error
{
	if(!m_error)
	{
		GtAssignObject(m_error, error);
		[m_parser abortParsing];
	}
}

- (void) parse:(NSData*) data
{
	GtAssertNil(m_parser);

	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	@try
	{
		m_parser = [[NSXMLParser alloc] initWithData:data]; 
		[m_parser setDelegate:self];
		
		[self onConfigureParser:m_parser];
		
		[m_parser parse];
		
		GtDrainPool(&pool);
	}
	@catch(NSException* ex)
	{
		GtDrainPoolAndRethrow(&pool, ex);
	}
	@finally
	{
		m_parser.delegate = nil;
	}
	
	if(m_error)
	{
		GtThrowError(GtReturnAutoreleased(GtRetain(m_error)));
	}
}

/* delegate callbacks */

- (void)parser:(NSXMLParser *)parser 
			didStartElement:(NSString *)elementName 
			  namespaceURI:(NSString *)namespaceURI 
			 qualifiedName:(NSString *)qName 
				attributes:(NSDictionary *)attributeDict
{
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{	  
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
}

- (void) onConfigureParser:(NSXMLParser*) parser
{
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	self.error = parseError;
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
	self.error = validationError;
}


@end
