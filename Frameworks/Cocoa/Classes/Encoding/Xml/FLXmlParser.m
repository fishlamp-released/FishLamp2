//
//  FLXmlParser.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLXmlParser.h"

@interface FLXmlParser ()
@property (readwrite, strong, nonatomic) NSMutableArray* stack;
@property (readwrite, strong, nonatomic) NSXMLParser* parser; // only valid during parse
@property (readwrite, strong, nonatomic) NSError* error; // only valid during parse
@property (readwrite, strong, nonatomic) FLParsedItem* rootElement;
@end



@implementation FLXmlParser
@synthesize stack = _stack;
@synthesize parser = _parser;
@synthesize error = _error;
@synthesize rootElement = _rootElement;


+ (id) xmlParser {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
	_parser.delegate = nil;

#if FL_MRC
    [_rootElement release];
    [_parser release];
    [_stack release];
    [_error release];
    [super dealloc];
#endif
}

- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser {
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
}

- (void) pushElement:(FLParsedItem*) newElement {
    if(!_rootElement) {
        self.rootElement = newElement;
    }
    else {
        FLParsedItem* item = [self.stack lastObject];
        [item addElement:newElement];
    }
    
    [self.stack addObject:newElement];
}

- (void) popElement {
    [self.stack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributes {
        
    FLParsedItem* newElement = [FLParsedItem parsedItem];
    newElement.elementName = elementName;
    newElement.namespaceURI = namespaceURI;
    newElement.qualifiedName = qName;
    
    if(attributes && attributes.count) {
        newElement.attributes = attributes;
        for(NSString* attributeName in attributes) {
            [newElement addElement:[FLParsedItem parsedItem:attributeName elementValue:[attributes objectForKey:attributeName]]];
        }
    }

    [self pushElement:newElement];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [[self.stack lastObject] appendStringToValue:string];
}

- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName {
    
#if DEBUG    
    FLParsedItem* lastElement = FLRetainWithAutorelease([self.stack lastObject]);
    FLAssertObjectsAreEqual(elementName, lastElement.elementName);
#endif
    
    [self popElement];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    self.error = parseError;
    [parser abortParsing];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    self.error = validationError;
    [parser abortParsing];
}

- (FLParsedItem*) parseData:(NSData*) data {

    self.stack = [NSMutableArray array];
//    [self.stack addObject:[FLParsedItem parsedItem]];

    @try {
        FLAutoreleasePool(
            _parser = [[NSXMLParser alloc] initWithData:data]; 
            [_parser setDelegate:self];
            
            [self willParseXMLData:data withXMLParser:_parser];
            [_parser parse];
        ) 

        FLThrowIfError(self.error);
        
        return FLRetainWithAutorelease(self.rootElement);
    }
    @finally {
		_parser.delegate = nil;
        self.parser = nil;
        self.stack = nil;
        self.error = nil;
        self.rootElement = nil;
    }
}

- (FLParsedItem*) parseFileAtPath:(NSString*) path {
    return [self parseFileAtURL:[NSURL fileURLWithPath:path]];
}

- (FLParsedItem*) parseFileAtURL:(NSURL*) url {
    NSError* err = nil;
    NSData* data = [NSData dataWithContentsOfURL:url options:0  error:&err];
    FLThrowIfError(FLAutorelease(err));
        
    return [self parseData:data];
}
@end