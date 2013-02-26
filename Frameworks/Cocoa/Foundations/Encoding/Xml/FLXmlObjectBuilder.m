//
//	FLXmlObjectBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLXmlObjectBuilder.h"
#import "FLBase64Encoding.h"
#import "FLDataEncoder.h"
#import "FLPropertyDescription.h"

// TODO: seperate XML encoder?
#import "FLSoapDataEncoder.h"

@interface FLXmlObjectBuilder ()
@property (readwrite, strong, nonatomic) FLObjectBuilder* objectBuilder;
@property (readwrite, strong, nonatomic) NSXMLParser* parser; // only valid during parse
+ (NSString*) errorStringForCode:(NSXMLParserError) code;
@end

@implementation FLXmlObjectBuilder

@synthesize parser = _parser;
@synthesize objectBuilder = _objectBuilder;

+ (id) xmlObjectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
	_parser.delegate = nil;

#if FL_MRC
    FLRelease(_objectBuilder);
	FLRelease(_parser);
    [super dealloc];
#endif
}

//- (void) didParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser withResult:(FLResult) result {
//}

- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser {
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
}

- (id) buildObjectWithClass:(Class) aClass 
                           withData:(NSData*) data 
                    withDataDecoder:(id<FLDataDecoding>) decoder {

    FLAssertIsNil_(_parser);
    FLAssertIsNil_(_objectBuilder);
        
    self.objectBuilder = [FLObjectBuilder objectBuilder];
//    self.objectBuilder.delegate = self;
    [self.objectBuilder openWithRootObjectClass:aClass withDataDecoder:decoder];

    @try {
        FLAutoreleasePool(
            _parser = [[NSXMLParser alloc] initWithData:data]; 
            [_parser setDelegate:self];
            
            [self willParseXMLData:data withXMLParser:_parser];
            [_parser parse];
        ) 

        return [self.objectBuilder finishBuilding];
    }
    @catch(NSException* ex) {
        return ex.error;
    }
    @finally {
		_parser.delegate = nil;
        self.parser = nil;
        self.objectBuilder = nil;
    }
}

- (void) objectBuilder:(FLObjectBuilder*) objectBuilder willInflateProperty:(FLPropertyInflator*)object {
//    if(_saveParsePositions) {
//        object.parseInfo = [FLParseInfo parseInfo:object.key file:_fileName line:self.parser.lineNumber column:self.parser.columnNumber];
//    }
}

//- (FLPropertyInflator*) openXMLElement:(NSString*) elementName isAttribute:(BOOL) isAttribute {
//    
//    
//    FLPropertyInflator* newState = [[FLPropertyInflator alloc] initWithObject:[_parseStack.lastObject object] key:elementName];
//    
//    
//	newState.objectDescriber = [[newState.object class] sharedObjectDescriber];
//	newState.dataIsAttribute = isAttribute;
//    [_parseStack addObject:newState];
//
//	if(![newState.object beginParsingFrom:self state:newState]) {
//        [self setError:[NSError errorWithDomain:FLXmlParserDomain 
//                                           code:FLXmlParserErrorCodeUnknownElement 
//                           localizedDescription:[NSString stringWithFormat:@"Unknown XML %@: %@", isAttribute ? @"attribute" : @"element", elementName]]
//                                    errorHint:[self  stateString]];
//    }
//	
//#if DEBUG
//    FLAutoreleaseObject(newState);
//	FLAssertIsNotNil_(newState.object);
//#else
//	FLRelease(newState);
//#endif    
//}

//- (void) closeXMLElement:(FLPropertyInflator*) element {
//    
//    FLAssertIsNotNil_(lastState.object);
//	
//    NSString* unparsedData = element.data; 
//	
//    if(unparsedData	 && unparsedData.length > 0) {
//		unparsedData = [unparsedData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//	
//		if(unparsedData.length > 0) {
//			if(lastState.propertyType) {
//
//                FLAssertIsNotNil_(self.dataDecoder);
//                
//				id inflatedPropertyObject = [self.dataDecoder decodeDataFromString:unparsedData forType:lastState.propertyType]; 
//
//				if(inflatedPropertyObject) {
//					lastState.data = inflatedPropertyObject;
//				}
//				else {
//					lastState.data = unparsedData; // trimmed.
//				}
//				
//				[lastState.object finishParsingFrom:self state:lastState];
//			}
//#if DEBUG	 
//			else
//			{
//				FLDebugLog(@"Warning: %@ doesn't know about %@: %@: data: %@", NSStringFromClass([lastState.object class]), lastState.dataIsAttribute ? @"attribute" : @"element", elementName, unparsedData); 
//			
//			}
//#endif				  
//		}
//	}
//	
//    [_parseStack removeLastObject];
//}

/* delegate callbacks */

- (void) objectBuilder:(FLObjectBuilder*) builder 
            encounteredError:(NSError*) error 
                   errorHint:(int) errorHint
             errorHelp:(FLPrettyString*) errorHelp {

    if(error /*&& !self.objectBuilder.error*/) {

//        if([error errorDomainEqualsDomain:NSXMLParserErrorDomain]) {
//            
//            NSString* name = [FLXmlObjectBuilder errorStringForCode:error.code];
//            
//            NSString* errorStr = [NSString stringWithFormat:@"%@ (%ld). Line: %ld, Column: %ld, Hint: %@",
//                name != nil ? name : @"Unknown",
//                (long) error.code,
//                (long)_parser.lineNumber,
//                (long)_parser.columnNumber,
//            errorHint ? errorHint : @""];
//
//            error = [NSError errorWithDomain:NSXMLParserErrorDomain code:error.code localizedDescription:errorStr];
//        }

    }

    [_parser abortParsing];
            
}            

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributes {
        
    if(!_gotFirstElement) {
        _gotFirstElement = YES;
    }
    else {
        [self.objectBuilder startInflatingPropertyWithName:elementName withState:0];
    }
    
    if(attributes && attributes.count > 0) {
        for(NSString* key in attributes) {
            [self.objectBuilder addProperty:key withEncodedString:[attributes valueForKey:key] withState:FLXmlPropertyInflationIsAttribute];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.objectBuilder.lastInflator appendEncodedString:string];
}

- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName {
    
    [self.objectBuilder finishInflatingProperty];
 }

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	[self.objectBuilder setError:parseError errorHint:FLXmlParserParseErrorHint];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
	[self.objectBuilder setError:validationError errorHint:FLXmlParserValidationErrorHint];
}

typedef struct {
    NSXMLParserError code;
    __unsafe_unretained NSString* errorString;
} FLErrorLookup;

FLErrorLookup s_lookup[] = {
    { NSXMLParserInternalError, @"InternalError" },
    { NSXMLParserOutOfMemoryError, @"OutOfMemoryError" },
    { NSXMLParserDocumentStartError,@"DocumentStartError" },
    { NSXMLParserEmptyDocumentError, @"EmptyDocumentError" },
    { NSXMLParserPrematureDocumentEndError, @"PrematureDocumentEndError" },
    { NSXMLParserInvalidHexCharacterRefError, @"InvalidHexCharacterRefError" },
    { NSXMLParserInvalidDecimalCharacterRefError, @"InvalidDecimalCharacterRefError" },
    { NSXMLParserInvalidCharacterRefError, @"InvalidCharacterRefError" },
    { NSXMLParserInvalidCharacterError , @"InvalidCharacterError" },
    { NSXMLParserCharacterRefAtEOFError , @"CharacterRefAtEOFError" },
    { NSXMLParserCharacterRefInPrologError, @"CharacterRefInPrologError" },
    { NSXMLParserCharacterRefInEpilogError, @"CharacterRefInEpilogError" },
    { NSXMLParserCharacterRefInDTDError, @"CharacterRefInDTDError" },
    { NSXMLParserEntityRefAtEOFError, @"EntityRefAtEOFError" },
    { NSXMLParserEntityRefInPrologError, @"EntityRefInPrologError" },
    { NSXMLParserEntityRefInEpilogError, @"EntityRefInEpilogError" },
    { NSXMLParserEntityRefInDTDError, @"EntityRefInDTDError" },
    { NSXMLParserParsedEntityRefAtEOFError, @"ParsedEntityRefAtEOFError" },
    { NSXMLParserParsedEntityRefInPrologError, @"ParsedEntityRefInPrologError" },
    { NSXMLParserParsedEntityRefInEpilogError, @"ParsedEntityRefInEpilogError" },
    { NSXMLParserParsedEntityRefInInternalSubsetError, @"ParsedEntityRefInInternalSubsetError" },
    { NSXMLParserEntityReferenceWithoutNameError, @"EntityReferenceWithoutNameError" },
    { NSXMLParserEntityReferenceMissingSemiError, @"EntityReferenceMissingSemiError" },
    { NSXMLParserParsedEntityRefNoNameError, @"ParsedEntityRefNoNameError" },
    { NSXMLParserParsedEntityRefMissingSemiError, @"ParsedEntityRefMissingSemiError" },
    { NSXMLParserUndeclaredEntityError, @"UndeclaredEntityError" },
    { NSXMLParserUnparsedEntityError, @"UnparsedEntityError" },
    { NSXMLParserEntityIsExternalError, @"EntityIsExternalError" },
    { NSXMLParserEntityIsParameterError, @"EntityIsParameterError" },
    { NSXMLParserUnknownEncodingError, @"UnknownEncodingError" },
    { NSXMLParserEncodingNotSupportedError, @"EncodingNotSupportedError" },
    { NSXMLParserStringNotStartedError, @"StringNotStartedError" },
    { NSXMLParserStringNotClosedError, @"StringNotClosedError" },
#if IOS
//    { NSXMLParserNamespaceHeaderError, @"NamespaceHeaderError" },
#endif    
    { NSXMLParserEntityNotStartedError, @"EntityNotStartedError" },
    { NSXMLParserEntityNotFinishedError, @"EntityNotFinishedError" },
    { NSXMLParserLessThanSymbolInAttributeError, @"LessThanSymbolInAttributeError" },
    { NSXMLParserAttributeNotStartedError, @"AttributeNotStartedError" },
    { NSXMLParserAttributeNotFinishedError, @"AttributeNotFinishedError" },
    { NSXMLParserAttributeHasNoValueError, @"AttributeHasNoValueError" },
    { NSXMLParserAttributeRedefinedError, @"AttributeRedefinedError" },
    { NSXMLParserLiteralNotStartedError, @"LiteralNotStartedError" },
    { NSXMLParserLiteralNotFinishedError, @"LiteralNotFinishedError" },
    { NSXMLParserCommentNotFinishedError, @"CommentNotFinishedError" },
    { NSXMLParserProcessingInstructionNotStartedError, @"ProcessingInstructionNotStartedError" },
    { NSXMLParserProcessingInstructionNotFinishedError, @"ProcessingInstructionNotFinishedError" },
    { NSXMLParserNotationNotStartedError, @"NotationNotStartedError" },
    { NSXMLParserNotationNotFinishedError, @"NotationNotFinishedError" },
    { NSXMLParserAttributeListNotStartedError, @"AttributeListNotStartedError" },
    { NSXMLParserAttributeListNotFinishedError, @"AttributeListNotFinishedError" },
    { NSXMLParserMixedContentDeclNotStartedError, @"MixedContentDeclNotStartedError" },
    { NSXMLParserMixedContentDeclNotFinishedError, @"MixedContentDeclNotFinishedError" },
    { NSXMLParserElementContentDeclNotStartedError, @"ElementContentDeclNotStartedError" },
    { NSXMLParserElementContentDeclNotFinishedError, @"ElementContentDeclNotFinishedError" },
    { NSXMLParserXMLDeclNotStartedError, @"XMLDeclNotStartedError" },
    { NSXMLParserXMLDeclNotFinishedError, @"XMLDeclNotFinishedError" },
    { NSXMLParserConditionalSectionNotStartedError, @"ConditionalSectionNotStartedError" },
    { NSXMLParserConditionalSectionNotFinishedError, @"ConditionalSectionNotFinishedError" },
    { NSXMLParserExternalSubsetNotFinishedError, @"ExternalSubsetNotFinishedError" },
    { NSXMLParserDOCTYPEDeclNotFinishedError, @"DOCTYPEDeclNotFinishedError" },
    { NSXMLParserMisplacedCDATAEndStringError, @"MisplacedCDATAEndStringError" },
    { NSXMLParserCDATANotFinishedError, @"CDATANotFinishedError" },
#if IOS
//    { NSXMLParserMisplacedXMLHeaderError, @"MisplacedXMLHeaderError" },
#endif
    { NSXMLParserSpaceRequiredError, @"SpaceRequiredError" },
    { NSXMLParserSeparatorRequiredError, @"SeparatorRequiredError" },
    { NSXMLParserNMTOKENRequiredError, @"NMTOKENRequiredError" },
    { NSXMLParserNAMERequiredError, @"NAMERequiredError" },
    { NSXMLParserPCDATARequiredError, @"PCDATARequiredError" },
    { NSXMLParserURIRequiredError, @"URIRequiredError" },
    { NSXMLParserPublicIdentifierRequiredError, @"PublicIdentifierRequiredError" },
    { NSXMLParserLTRequiredError, @"LTRequiredError" },
    { NSXMLParserGTRequiredError, @"GTRequiredError" },
    { NSXMLParserLTSlashRequiredError, @"LTSlashRequiredError" },
    { NSXMLParserEqualExpectedError, @"EqualExpectedError" },
    { NSXMLParserTagNameMismatchError, @"TagNameMismatchError" },
    { NSXMLParserUnfinishedTagError, @"UnfinishedTagError" },
    { NSXMLParserStandaloneValueError, @"StandaloneValueError" },
    { NSXMLParserInvalidEncodingNameError, @"InvalidEncodingNameError" },
    { NSXMLParserCommentContainsDoubleHyphenError, @"CommentContainsDoubleHyphenError" },
    { NSXMLParserInvalidEncodingError, @"InvalidEncodingError" },
    { NSXMLParserExternalStandaloneEntityError, @"ExternalStandaloneEntityError" },
    { NSXMLParserInvalidConditionalSectionError, @"InvalidConditionalSectionError" },
    { NSXMLParserEntityValueRequiredError, @"EntityValueRequiredError" },
    { NSXMLParserNotWellBalancedError, @"NotWellBalancedError" },
    { NSXMLParserExtraContentError, @"ExtraContentError" },
    { NSXMLParserInvalidCharacterInEntityError, @"InvalidCharacterInEntityError" },
    { NSXMLParserParsedEntityRefInInternalError, @"ParsedEntityRefInInternalError" },
    { NSXMLParserEntityRefLoopError, @"EntityRefLoopError" },
    { NSXMLParserEntityBoundaryError, @"EntityBoundaryError" },
    { NSXMLParserInvalidURIError, @"InvalidURIError" },
    { NSXMLParserURIFragmentError, @"URIFragmentError" },
    { NSXMLParserNoDTDError, @"NoDTDError" },
    { NSXMLParserDelegateAbortedParseError, @"DelegateAbortedParseError" } 
};

+ (NSString*) errorStringForCode:(NSXMLParserError) code {

    NSInteger count = sizeof(s_lookup) / sizeof(FLErrorLookup);
    
    for(int i = 0; i < count; i++) {
        if(s_lookup[i].code == code) {
            return s_lookup[i].errorString;
        }
    }
    
    return nil;
}


@end

@implementation NSObject (FLXmlObjectBuilder)

+ (id) objectWithContentsOfXMLFile:(NSString*) path 
                   withDataDecoder:(id<FLDataDecoding>) decoder {
    
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if(error) {
        FLThrowIfError(FLAutorelease(error));
    }

    FLXmlObjectBuilder* parser = [FLXmlObjectBuilder xmlObjectBuilder];
    
    return [parser buildObjectWithClass:[self class] withData:data withDataDecoder:decoder];
}

@end

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

- (void) addElement:(NSDictionary*) newElement toElement:(NSMutableDictionary*) parentElement {
    
    NSString* name = [newElement objectForKey:@"elementName"];
    NSMutableArray* elementList = [parentElement objectForKey:@"elements"];
    if(elementList) {
        [elementList addObject:name];
    }
    else {
        [parentElement setObject:[NSMutableArray arrayWithObject:name] forKey:@"elements"];
    }
    [parentElement setObject:newElement forKey:name];
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributes {
        
    NSMutableDictionary* newElement = [NSMutableDictionary dictionary];
    [newElement setObject:elementName forKey:@"elementName"];
    [newElement setObject:namespaceURI forKey:@"namespace"];
    [newElement setObject:qName forKey:@"qName"];
    if(attributes && attributes.count) {
        [newElement setObject:attributes forKey:@"attributes"];
    }

    [self addElement:newElement toElement:[self.stack lastObject]];
    [self.stack addObject:newElement];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    string = [string trimmedString];
    if(FLStringIsNotEmpty(string)) {
        NSMutableString* value = [[self.stack lastObject] objectForKey:@"value"];
        if(value) {
            [value appendString:string];
        }
        else {
            [[self.stack lastObject] setObject:FLMutableCopyWithAutorelease(string) forKey:@"value"];
        }
    }
}

- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName {
    
    NSMutableDictionary* lastElement = FLRetainWithAutorelease([self.stack lastObject]);
    FLAssertObjectsAreEqual_(elementName, [lastElement objectForKey:@"elementName"]);
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

- (FLResult) parseData:(NSData*) data {

    self.stack = [NSMutableArray array];
    [self.stack addObject:[NSMutableDictionary dictionary]];

    
    @try {
        FLAutoreleasePool(
            _parser = [[NSXMLParser alloc] initWithData:data]; 
            [_parser setDelegate:self];
            
            [self willParseXMLData:data withXMLParser:_parser];
            [_parser parse];
        ) 

        return self.error ? self.error : [self.stack firstObject];
    }
    @catch(NSException* ex) {
        return ex.error;
    }
    @finally {
		_parser.delegate = nil;
        self.parser = nil;
        self.stack = nil;
        self.error = nil;
    }
}

//- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
//	forProperty:(FLPropertyDescription*) propertyDescription
//                              withDecoder:(id<FLDataDecoding>) decoder
//{
//	NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:[fromArray count]];
//	
//	FLPropertyDescription* arrayItemDesc = [[propertyDescription arrayTypes] objectAtIndex:0];
//		
//	for(id arrayItem in fromArray)
//	{			
//		if([arrayItem isKindOfClass:[NSDictionary class]])
//		{
//			id newObject = FLAutorelease([[arrayItemDesc.propertyType.typeClass alloc] init]);
//			[newArray addObject:newObject];
//			[self buildObject:newObject fromDictionary:arrayItem withObjectDescriber:[[newObject class] sharedObjectDescriber] withDecoder:decoder];
//		}
//		else if([arrayItem isKindOfClass:[NSArray class]]) {
//			[newArray addObject:[self addObjectsToArray:arrayItem forProperty:arrayItemDesc withDecoder:decoder]];
//		}
//		else
//		{
//            if(decoder) {
//                [newArray addObject:[arrayItemDesc.propertyType decodeStringToObject:arrayItem withDecoder:decoder]];
//            }
//            else {
//                [newArray addObject:arrayItem];
//            }
//
//
////			switch(arrayItemDesc.propertyType.specificType)
////			{
////				case FLSpecificTypeDate:
////					[newArray addObject: [[FLDateMgr instance] ISO8601StringToDate:arrayItem]];
////				break;
////				
////				default:
////                    [newArray addObject:arrayItem];
////				break;
////			}
//
//            
//
//
//		}
//	}
//	
//	return newArray;
//}
//
//- (void) buildObject:(id) object 
//      fromDictionary:(NSDictionary*) dictionary 
// withObjectDescriber:(FLObjectDescriber*) describer
//         withDecoder:(id<FLDataDecoding>) decoder {
//
//    for(NSString* key in dictionary) {
//
//		id value = [dictionary objectForKey:key];
//		if(value)
//		{
//			FLPropertyDescription* property = [describer.propertyDescribers objectForKey:key];
//			if(property)
//			{
//				if([value isKindOfClass:[NSDictionary class]])
//				{
////					FLAssert_v(property.propertyType.generalType == FLGeneralTypeObject, @"not an object?");
//				
//					id newObject = FLAutorelease([[property.propertyType.typeClass alloc] init]);
//					[object setValue:newObject forKey:key];
//					[self buildObject:newObject fromDictionary:value withObjectDescriber:[[newObject class] sharedObjectDescriber] withDecoder:decoder];
//				}
//				else if([value isKindOfClass:[NSArray class]]) {
//					[object setValue:[self addObjectsToArray:value forProperty:property withDecoder:decoder] forKey:key];
//				}
//				else {
//
//                    if(decoder) {
//                        value = [property.propertyType decodeStringToObject:value withDecoder:decoder];
//                    }
//                
////					switch(property.propertyType.specificType)
////					{
////						case FLSpecificTypeDate:
////							value = [[FLDateMgr instance] ISO8601StringToDate:value];
////						break;
////						
////						default:
////						break;
////					}
//					
//					[object setValue:value forKey:key];
//				}
//			}
//			else
//			{
//				FLDebugLog(@"Warning: unknown property for key: %@, value: %@", key, [value description]);
//			}
//		}
//	}
//}
//
//- (id) buildObjectWithDictionary:(NSDictionary*) dictionary
//                        forClass:(Class) aClass 
//                     withDecoder:(id<FLDataDecoding>) decoder {
//    id rootObject = FLAutorelease([[aClass alloc] init]);
//                     
//	[self buildObject:rootObject fromDictionary:dictionary withObjectDescriber:[aClass sharedObjectDescriber] withDecoder:decoder];
//}



@end

@implementation NSDictionary (FLXmlParsing)
- (id) objectAtPath:(NSString*) path {
    id obj = self;
    NSArray* pathComponents = [path pathComponents];
    for(NSString* component in pathComponents) {
        obj = [obj objectForKey:component];
    }
    return obj;
}
@end
