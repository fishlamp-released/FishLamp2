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

- (FLResult) parseData:(NSData*) data {

    self.stack = [NSMutableArray array];
    [self.stack addObject:[FLParsedXmlElement parsedXmlElement]];

    
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
@end

@interface FLParsedXmlElement ()
@property (readwrite, assign, nonatomic) FLParsedXmlElement* parent;
- (id) inflateObjectWithPropertyDescription:(FLPropertyDescription*) property  withDecoder:(id<FLDataDecoding>) decoder ;
- (void) addPropertiesToObject:(id) object withDecoder:(id<FLDataDecoding>) decoder;

@end

@implementation FLParsedXmlElement

@synthesize attributes = _attributes;
@synthesize namespaceURI = _namespace;
@synthesize elementName = _elementName;
@synthesize qualifiedName = _qualifiedName;
@synthesize value = _value;
@synthesize elements = _elements;
@synthesize parent = _parent;

+ (id) parsedXmlElement {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) appendStringToValue:(NSString*) string {
    string = [string trimmedString];
    if(FLStringIsNotEmpty(string)) {
        if(_value) {
            [_value appendString:string];
        }
        else {
            _value = [string mutableCopy];
        }
    }
}

- (void) addElement:(FLParsedXmlElement*) element {
    if(!_elements) {
        _elements = [[NSMutableDictionary alloc] init];
    }
    id existing = [_elements objectForKey:element.elementName];
    if(!existing) {
        [_elements setObject:element forKey:element.elementName];
    }
    else if([existing isKindOfClass:[NSMutableArray class]]) {
        [existing addObject:element];
    }
    else {
        NSMutableArray* array = [NSMutableArray arrayWithObjects:existing, element, nil];
        [_elements setObject:array forKey:element.elementName];
    }
    element.parent = self;
}

- (FLParsedXmlElement*) elementForElementName:(NSString*) name {
    return [_elements objectForKey:name];
}

#if FL_MRC
- (void) dealloc {
    [_attributes release];
    [_namespace release];
    [_elementName release];
    [_qualifiedName release];
    [_value release];
    [_elements release];
    [super dealloc];
}
#endif

- (FLParsedXmlElement*) elementAtPath:(NSString*) path {
    FLParsedXmlElement* obj = self;
    NSArray* pathComponents = [path pathComponents];
    for(NSString* component in pathComponents) {
        obj = [obj elementForElementName:component];
    }
    return obj;
}

- (NSString*) description {

    return [NSString stringWithFormat:@"elementName:%@, namespace:%@, qualifiedName:%@, attributes:%@, value:%@, elements:%@ \n",
        FLEmptyStringOrString(self.elementName),
        FLEmptyStringOrString(self.namespaceURI),
        FLEmptyStringOrString(self.qualifiedName),
        FLEmptyStringOrString([self.attributes description]),
        FLEmptyStringOrString(self.value),
        FLEmptyStringOrString([self.elements description])
    ];
}

- (id) inflateObjectWithType:(FLTypeDesc*) typeToInflate withDecoder:(id<FLDataDecoding>) decoder {

    FLAssertNotNil_(decoder);
    FLAssertNotNil_(typeToInflate);

    FLObjectDescriber* describer = [[typeToInflate.typeClass class] sharedObjectDescriber];
    if(describer) {
        id rootObject = FLAutorelease([[typeToInflate.typeClass alloc] init]);
        FLAssertNotNil_v(rootObject, @"unabled to create object of type: %@", NSStringFromClass(typeToInflate.typeClass));
        
        [self addPropertiesToObject:rootObject withDecoder:decoder];
        return rootObject;
    }
    
    id object = [decoder decodeDataFromString:self.value forType:typeToInflate];
    FLAssertNotNil_(object);
    
    return object;
}

- (FLPropertyDescription*) arrayTypeForName:(NSString*) name
                    withPropertyDescription:(FLPropertyDescription*) propertyDescription {

   for(FLPropertyDescription* arrayType in propertyDescription.arrayTypes) {
        if(FLStringsAreEqual(name, arrayType.propertyName)) {
            return arrayType;
        }
    }

    return nil;
}                            

- (void) inflateElementsIntoArray:(NSMutableArray*) newArray
          withPropertyDescription:(FLPropertyDescription*) propertyDescription
                      withDecoder:(id<FLDataDecoding>) decoder {
    FLAssertNotNil_(newArray);
    FLAssertNotNil_(decoder);
    FLAssertNotNil_(propertyDescription);
    FLConfirm_v(propertyDescription.isArray, @"expecting an array property");

    for(id elementName in self.elements) {
        id elementOrArray = [self.elements objectForKey:elementName];

        FLPropertyDescription* arrayType = [self arrayTypeForName:elementName withPropertyDescription:propertyDescription];
        FLConfirmNotNil_v(arrayType, @"arrayType for element \"%@\" not found", elementName);
        
        if([elementOrArray isKindOfClass:[NSArray class]]) {
            for(FLParsedXmlElement* element in elementOrArray) {			
                [newArray addObject:[element inflateObjectWithPropertyDescription:arrayType withDecoder:decoder]];
            }
        }
        else {
            FLAssert_([elementOrArray isKindOfClass:[FLParsedXmlElement class]]);
            [newArray addObject:[elementOrArray inflateObjectWithPropertyDescription:arrayType withDecoder:decoder]];
        }
    }
}

- (void) addPropertiesToObject:(id) object 
                 withDecoder:(id<FLDataDecoding>) decoder {
    
    FLAssertNotNil_(object);
    FLAssertNotNil_(decoder);

    FLObjectDescriber* describer = [[object class] sharedObjectDescriber];
    FLAssertNotNil_(describer);

    for(id elementName in self.elements) {
        id elementOrArray = [self.elements objectForKey:elementName];

        FLPropertyDescription* propertyDescription = [describer.propertyDescribers objectForKey:elementName];
        FLAssertNotNil_(propertyDescription);

        id propertyValue = nil;
        
        if(propertyDescription.isArray) {
            propertyValue = [NSMutableArray array];

            if([elementOrArray isKindOfClass:[FLParsedXmlElement class]]) {
                [elementOrArray inflateElementsIntoArray:propertyValue 
                                 withPropertyDescription:propertyDescription 
                                             withDecoder:decoder];
            }
            else {
            
                FLAssert_([elementOrArray isKindOfClass:[NSArray class]]);
                for(FLParsedXmlElement* element in elementOrArray) {
                    [element inflateElementsIntoArray:propertyValue 
                              withPropertyDescription:propertyDescription 
                                          withDecoder:decoder];
                }

            }
        }
        else {
            FLAssert_([elementOrArray isKindOfClass:[FLParsedXmlElement class]]);
            propertyValue = [elementOrArray inflateObjectWithPropertyDescription:propertyDescription 
                                                                     withDecoder:decoder];
        }
        
        if(propertyValue) {
            [object setValue:propertyValue forKey:propertyDescription.propertyName];
        }
    }
}


- (id) inflateObjectWithPropertyDescription:(FLPropertyDescription*) property  
                                withDecoder:(id<FLDataDecoding>) decoder {
    FLAssertNotNil_(property);
    FLAssertNotNil_(decoder);
    
    id object = nil;
    if([property.propertyType.typeClass sharedObjectDescriber]) {
        object = FLAutorelease([[property.propertyType.typeClass alloc] init]);
        [self addPropertiesToObject:object withDecoder:decoder];
        
        // NOTE: what if there is a value?? 
        
    }
    else if(self.value) {
        object = [decoder decodeDataFromString:self.value forType:property.propertyType];
    }
    
    return object;
}


@end
