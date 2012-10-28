//
//	FLXmlParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLXmlParser.h"
#import "FLBase64Encoding.h"
#import "FLDataEncoder.h"
#import "NSObject+XML.h"
#import "FLPropertyDescription.h"

// TODO: seperate XML encoder?
#import "FLSoapDataEncoder.h"

@interface FLXmlParser ()
@property (readwrite, retain, nonatomic) NSData* data;
@end

@implementation FLXmlParser

@synthesize data = _data;
@synthesize saveParsePositions = _saveParsePositions;
@synthesize fileName = _fileName;

+ (id) xmlParser:(NSData*) data {
	return FLReturnAutoreleased([[[self class] alloc] initWithXmlData:data]);
}

- (void) buildObjects:(id) rootObject
{
    [_parseState removeAllObjects];
    
    [_parseState pushObject:[FLObjectInflatorState objectInflatorState:rootObject key:nil]];
	[super parse:self.data];
}

- (id) initWithXmlData:(NSData*) data
{
	if((self = [super init]))
	{
        _parseState = [[FLLinkedList alloc] init];
    
		self.data = data;
	}
	
	return self;
}

- (void) dealloc
{
    FLRelease(_fileName);
	FLRelease(_parseState);
	FLRelease(_data);
	FLSuperDealloc();
}

- (id<FLDataDecoder>) onCreateDataDecoder {
    return [FLSoapDataEncoder instance];
}

- (NSString*) stateString {
    NSMutableString* string = [NSMutableString string];
    
    for(FLObjectInflatorState* state in _parseState) {
        
        NSString* key = state.key;
        if(!key) {
            key = NSStringFromClass([state.object class]);
        }
        
        if(string.length > 0) {
            [string appendFormat:@".%@", key];
        } else {
            [string appendString:key];
        }
    }
    
    return string;
}

- (void) setError:(NSError*) error errorHint:(NSString*) errorHint {

    [super setError:error errorHint:errorHint != nil ? errorHint : [self stateString]];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	[self setError:parseError errorHint:[self stateString]];
}

- (void) startParsing:(NSString*) elementName isAttribute:(BOOL) isAttribute {
    
    FLObjectInflatorState* newState = [[FLObjectInflatorState alloc] initWithObject:[_parseState.lastObject object] key:elementName];
    if(_saveParsePositions) {
        newState.parseInfo = [FLParseInfo parseInfo:elementName file:_fileName line:self.parser.lineNumber column:self.parser.columnNumber];
    }
	newState.objectDescriber = [[newState.object class] sharedObjectDescriber];
	newState.dataIsAttribute = isAttribute;
    [_parseState addObject:newState];

	if(![newState.object beginParsingFrom:self state:newState]) {
        [self setError:[NSError errorWithDomain:FLXmlParserDomain 
                                           code:FLXmlParserErrorCodeUnknownElement 
                           localizedDescription:[NSString stringWithFormat:@"Unknown XML %@: %@", isAttribute ? @"attribute" : @"element", elementName]]
                                    errorHint:[self  stateString]];
    }
	
#if DEBUG
    FLAutorelease(newState);
	FLAssertIsNotNil_(newState.object);
#else
	FLRelease(newState);
#endif    
}

- (void) finishParsing:(NSString*) elementName
{
	FLObjectInflatorState* lastState = _parseState.lastObject;
    
    FLAssertIsNotNil_(lastState.object);
	
    NSString* unparsedData = lastState.data; 
	
    if(unparsedData	 && unparsedData.length > 0)
	{
		unparsedData = [unparsedData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
		if(unparsedData.length > 0)
		{
			if(lastState.parsedDataType != FLDataTypeUnknown)
			{	
				id inflatedObject = nil;
                FLAssertIsNotNil_(self.dataDecoder);
                
				[self.dataDecoder decodeDataFromString:unparsedData forType:lastState.parsedDataType outObject:&inflatedObject]; 

				if(inflatedObject)
				{
					lastState.data = inflatedObject;
				}
				else
				{
					lastState.data = unparsedData; // trimmed.
				}
				
				[lastState.object finishParsingFrom:self state:lastState];
				FLRelease(inflatedObject);
			}
#if DEBUG	 
			else
			{
				FLDebugLog(@"Warning: %@ doesn't know about %@: %@: data: %@", NSStringFromClass([lastState.object class]), lastState.dataIsAttribute ? @"attribute" : @"element", elementName, unparsedData); 
			
			}
#endif				  
		}
	}
	
    [_parseState removeLastObject];
}

- (void)parser:(NSXMLParser *)parser 
			didStartElement:(NSString *)elementName 
			  namespaceURI:(NSString *)namespaceURI 
			 qualifiedName:(NSString *)qName 
				attributes:(NSDictionary *)attributes
{
	@try
	{
		if(!_gotFirstElement)
		{
			_gotFirstElement = YES;
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
				FLObjectInflatorState* lastState = _parseState.lastObject;
                lastState.data = [attributes valueForKey:key];
				[self finishParsing:key];
			}
		}
	}
    @catch(NSException* ex) {
        [self setError:ex.error errorHint:[self stateString]];
	}

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(_parseState && string.length > 0)
	{
        FLObjectInflatorState* lastState = _parseState.lastObject;
    
		if(!lastState.data)
		{
			lastState.data = [NSMutableString stringWithString:string];
		}
		else
		{
			[lastState.data appendString:string];
		}
	}
}

- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName
{
	@try {
		[self finishParsing:elementName];
	}
	@catch(NSException* ex) {
	    [self setError:ex.error errorHint:[self stateString]];
	}
 
}

@end





