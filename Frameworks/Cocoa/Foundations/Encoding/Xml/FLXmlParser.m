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
@end



@implementation FLXmlParser
@synthesize stack = _stack;
@synthesize parser = _parser;
@synthesize error = _error;

+ (id) xmlParser {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
	_parser.delegate = nil;

#if FL_MRC
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

//- (void) addElement:(NSDictionary*) newElement toElement:(NSMutableDictionary*) parentElement {
//    
//    NSString* name = [newElement objectForKey:@"elementName"];
//    NSMutableArray* elementList = [parentElement objectForKey:@"elements"];
//    if(elementList) {
//        [elementList addObject:name];
//    }
//    else {
//        [parentElement setObject:[NSMutableArray arrayWithObject:name] forKey:@"elements"];
//    }
//    [parentElement setObject:newElement forKey:name];
//}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributes {
        
    FLParsedXmlElement* newElement = [FLParsedXmlElement parsedXmlElement];
    newElement.elementName = elementName;
    newElement.namespaceURI = namespaceURI;
    newElement.qualifiedName = qName;
    
    if(attributes && attributes.count) {
        newElement.attributes = attributes;
    }

    [[self.stack lastObject] addElement:newElement];
    [self.stack addObject:newElement];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [[self.stack lastObject] appendStringToValue:string];
}

- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName {
    
    FLParsedXmlElement* lastElement = FLRetainWithAutorelease([self.stack lastObject]);
    FLAssertObjectsAreEqual_(elementName, lastElement.elementName);
    [self.stack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    self.error = parseError;
    [parser abortParsing];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    self.error = validationError;
    [parser abortParsing];
}

- (FLParsedXmlElement*) parseData:(NSData*) data {

    self.stack = [NSMutableArray array];
    [self.stack addObject:[FLParsedXmlElement parsedXmlElement]];

    @try {
        FLAutoreleasePool(
            _parser = [[NSXMLParser alloc] initWithData:data]; 
            [_parser setDelegate:self];
            
            [self willParseXMLData:data withXMLParser:_parser];
            [_parser parse];
        ) 

        FLThrowIfError(self.error);
        
        return [self.stack firstObject];
    }
    @finally {
		_parser.delegate = nil;
        self.parser = nil;
        self.stack = nil;
        self.error = nil;
    }
}
@end