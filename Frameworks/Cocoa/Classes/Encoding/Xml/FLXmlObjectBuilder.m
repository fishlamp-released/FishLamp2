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
#import "FLObjectDescriber.h"
#import "FLObjectDescriber.h"

@interface FLXmlObjectBuilder ()
- (id) inflateObjectWithPropertyDescription:(FLObjectDescriber*) objectDescription withElement:(FLParsedItem*) element;
- (void) addPropertiesToObject:(id) object withElement:(FLParsedItem*) element  objectDescriber:(FLObjectDescriber*) describer;
@end

@implementation FLXmlObjectBuilder
@synthesize decoder = _decoder;

- (id) init {
    return [self initWithDataDecoder:[FLDataEncoder dataEncoder]];
}

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder {
    self = [super init];
    if(self) {
        _decoder = FLRetain(decoder);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_decoder release];
    [super dealloc];
}
#endif

+ (id) xmlObjectBuilder:(id<FLDataDecoding>) decoder {
    return FLAutorelease([[[self class] alloc] initWithDataDecoder:decoder]);
}

+ (id) xmlObjectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLObjectDescriber*) arrayTypeForName:(NSString*) name
                    withPropertyDescription:(FLObjectDescriber*) objectDescription {

    return [objectDescription propertyForName:name];

//   for(FLObjectDescriber* arrayType in [objectDescription.properties) {
//        if(FLStringsAreEqual(name, arrayType.objectName)) {
//            return arrayType;
//        }
//    }
//
//    return nil;
} 

- (void) inflateElement:(FLParsedItem*) element 
              intoArray:(NSMutableArray*) newArray
withPropertyDescription:(FLObjectDescriber*) objectDescription {

    FLAssertNotNil(newArray);
    FLAssertNotNil(objectDescription);
    FLConfirmNotNilWithComment(objectDescription.properties, @"expecting an array objectDescription");

    for(id elementName in element.elements) {
        id elementOrArray = [element.elements objectForKey:elementName];

        FLObjectDescriber* arrayType = [self arrayTypeForName:elementName withPropertyDescription:objectDescription];
        FLConfirmNotNilWithComment(arrayType, @"arrayType for element \"%@\" not found", elementName);
        
        if([elementOrArray isKindOfClass:[NSArray class]]) {
            for(FLParsedItem* child in elementOrArray) {			
                [newArray addObject:[self inflateObjectWithPropertyDescription:arrayType withElement:child]];
            }
        }
        else {
            FLAssert([elementOrArray isKindOfClass:[FLParsedItem class]]);
            [newArray addObject:[self inflateObjectWithPropertyDescription:arrayType withElement:elementOrArray]];
        }
    }
}


- (id) inflateObjectWithPropertyDescription:(FLObjectDescriber*) objectDescription withElement:(FLParsedItem*) element  {
    FLAssertNotNil(objectDescription);
    
    id object = nil;
    Class objectClass = objectDescription.objectClass;
    if(!objectClass) {
        return nil;
    }
    
    FLObjectDescriber* describer = [objectClass objectDescriber];
    if(describer) {
        object = FLAutorelease([[objectClass alloc] init]);
        [self addPropertiesToObject:object withElement:element objectDescriber:describer];
        
        // NOTE: what if there is a value?? 
        
    }
    else if([element value]) {
        FLObjectEncoder* encoder = objectDescription.objectEncoder;
        if(encoder) {
            object = [self.decoder decodeDataFromString:[element value] forType:encoder];
        }
    }
    
    return object;
}


- (void) addPropertiesToObject:(id) object 
                   withElement:(FLParsedItem*) element  
               objectDescriber:(FLObjectDescriber*) describer {
    
    FLAssertNotNil(object);

    for(id elementName in element.elements) {
        id elementOrArray = [element.elements objectForKey:elementName];

        FLObjectDescriber* objectDescription = [describer.properties objectForKey:elementName];
        if(!objectDescription) {
            FLLog(@"object builder skipped missing objectDescription named: %@", elementName);
            continue;
        }
        
        id propertyValue = nil;
        
        if(objectDescription.hasProperties) {
            propertyValue = [NSMutableArray array];

            if([elementOrArray isKindOfClass:[FLParsedItem class]]) {
                [self inflateElement:elementOrArray
                           intoArray:propertyValue 
             withPropertyDescription:objectDescription];
            }
            else {
            
                FLAssert([elementOrArray isKindOfClass:[NSArray class]]);
                for(FLParsedItem* child in elementOrArray) {
                    [self inflateElement:child
                               intoArray:propertyValue 
                              withPropertyDescription:objectDescription];
                                
                }

            }
        }
        else {
            FLAssert([elementOrArray isKindOfClass:[FLParsedItem class]]);
            propertyValue = [self inflateObjectWithPropertyDescription:objectDescription 
                                                                     withElement:elementOrArray];
        }
        
        if(propertyValue) {
            [object setValue:propertyValue forKey:objectDescription.objectName];
        }
    }
}

- (FLParsedItem*) willBuildObjectsWithXML:(FLParsedItem*) element {
    return element;
}

- (id) buildObjectFromXML:(FLParsedItem*) element withObjectType:(FLObjectDescriber*) objectDescription {
    FLAssertNotNil(self.decoder);
    FLAssertNotNil(element);
    FLAssertNotNil(objectDescription);

    if(!FLStringsAreEqual(element.elementName, objectDescription.objectName)) {
        FLParsedItem* subElement = [element elementForElementName:objectDescription.objectName];

        if(!subElement) {
            FLThrowErrorCodeWithComment(NSCocoaErrorDomain, NSFileNoSuchFileError, @"XmlObjectBuilder: \"%@\" not found in \"%@\"", objectDescription.objectName, element.elementName);
        }
        
        element = subElement;
    }

//    FLAssertWithComment(FLStringsAreEqual(element.elementName, objectDescription.objectName), @"trying to build wrong object element name: \"%@\", object describer name: \"%@\"", element.elementName, objectDescription.objectName);

    Class objectClass = objectDescription.objectClass;
    if(!objectClass) {
        return nil;
    }

    FLObjectDescriber* describer = [objectClass objectDescriber];
    if(describer) {
        id rootObject = FLAutorelease([[objectClass alloc] init]);
        FLAssertNotNilWithComment(rootObject, @"unabled to create object of type: %@", NSStringFromClass(objectClass));
        
        [self addPropertiesToObject:rootObject withElement:element objectDescriber:describer];
        return rootObject;
    }
    
    FLObjectEncoder* encoder = objectDescription.objectEncoder;
    if(!encoder) {
        return nil;
    }
    
    id object = [self.decoder decodeDataFromString:[element value] forType:encoder];
    FLAssertNotNil(object);
    
    return object;
}

- (id) objectFromXML:(FLParsedItem*) element withObjectType:(FLObjectDescriber*) objectDescription {

    element = [self willBuildObjectsWithXML:element];
    
    return [self buildObjectFromXML:element withObjectType:objectDescription];
}

- (NSArray*) objectsFromXML:(FLParsedItem*) xmlElement withObjectTypes:(NSArray*) properties {

    xmlElement = [self willBuildObjectsWithXML:xmlElement];
    
    NSMutableArray* array = [NSMutableArray array];
    
    for(id elementName in xmlElement.elements) {
        
        for(FLObjectDescriber* objectDescription in properties) {

            if(FLStringsAreEqual(objectDescription.objectName, elementName)) {
            
                id objectXML = [xmlElement.elements objectForKey:elementName];
            
                id object = [self objectFromXML:objectXML withObjectType:objectDescription];
                
                if(object) {
                    [array addObject:object];
                }
            }
        }
    }
    
    return array;
}

- (NSArray*) objectsFromXML:(FLParsedItem*) xmlElement withObjectType:(FLObjectDescriber*) type {
    return [self objectsFromXML:xmlElement withObjectTypes:[NSArray arrayWithObject:type]];
}

//- (id) objectFromXML:(FLParsedItem*) objectXML withObjectType:(FLObjectDescriber*) type {
//    
//    return [self buildObjectFromXML:objectXML withPropertyDescriber:type];
//                
//                
//    
//    NSArray* objects = [self objectsFromXML:element withObjectType:type];
//
//    FLConfirmWithComment(objects.count == 1, @"expecting 1 object, got %d", objects.count);
//    
//    return [objects count] > 0 ? [objects objectAtIndex:0] : nil;
//}


@end


// TODO: seperate XML encoder?
//#import "FLSoapDataEncoder.h"

//@interface FLXmlObjectBuilder ()
//@property (readwrite, strong, nonatomic) FLObjectBuilder* objectBuilder;
//@property (readwrite, strong, nonatomic) NSXMLParser* parser; // only valid during parse
//+ (NSString*) errorStringForCode:(NSXMLParserError) code;
//@end
//
//@implementation FLXmlObjectBuilder
//
//@synthesize parser = _parser;
//@synthesize objectBuilder = _objectBuilder;
//
//+ (id) xmlObjectBuilder {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//- (void) dealloc {
//	_parser.delegate = nil;
//
//#if FL_MRC
//    FLRelease(_objectBuilder);
//	FLRelease(_parser);
//    [super dealloc];
//#endif
//}
//
////- (void) didParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser withResult:(FLResult) result {
////}
//
//- (void) willParseXMLData:(NSData*) data withXMLParser:(NSXMLParser*) parser {
//	[parser setShouldProcessNamespaces:NO];
//	[parser setShouldReportNamespacePrefixes:NO];
//	[parser setShouldResolveExternalEntities:NO];
//}
//
//- (id) buildObjectWithClass:(Class) aClass 
//                           withData:(NSData*) data 
//                    withDataDecoder:(id<FLDataDecoding>) decoder {
//
//    FLAssertIsNil(_parser);
//    FLAssertIsNil(_objectBuilder);
//        
//    self.objectBuilder = [FLObjectBuilder objectBuilder];
////    self.objectBuilder.delegate = self;
//    [self.objectBuilder openWithRootObjectClass:aClass withDataDecoder:decoder];
//
//    @try {
//        FLAutoreleasePool(
//            _parser = [[NSXMLParser alloc] initWithData:data]; 
//            [_parser setDelegate:self];
//            
//            [self willParseXMLData:data withXMLParser:_parser];
//            [_parser parse];
//        ) 
//
//        return [self.objectBuilder finishBuilding];
//    }
//    @catch(NSException* ex) {
//        return ex.error;
//    }
//    @finally {
//		_parser.delegate = nil;
//        self.parser = nil;
//        self.objectBuilder = nil;
//    }
//}
//
//- (void) objectBuilder:(FLObjectBuilder*) objectBuilder willInflateProperty:(FLPropertyInflator*)object {
////    if(_saveParsePositions) {
////        object.parseInfo = [FLParseInfo parseInfo:object.key file:_fileName line:self.parser.lineNumber column:self.parser.columnNumber];
////    }
//}
//
////- (FLPropertyInflator*) openXMLElement:(NSString*) elementName isAttribute:(BOOL) isAttribute {
////    
////    
////    FLPropertyInflator* newState = [[FLPropertyInflator alloc] initWithObject:[_parseStack.lastObject object] key:elementName];
////    
////    
////	newState.objectDescriber = [[newState.object class] objectDescriber];
////	newState.dataIsAttribute = isAttribute;
////    [_parseStack addObject:newState];
////
////	if(![newState.object beginParsingFrom:self state:newState]) {
////        [self setError:[NSError errorWithDomain:FLXmlParserDomain 
////                                           code:FLXmlParserErrorCodeUnknownElement 
////                           localizedDescription:[NSString stringWithFormat:@"Unknown XML %@: %@", isAttribute ? @"attribute" : @"element", elementName]]
////                                    errorHint:[self  stateString]];
////    }
////	
////#if DEBUG
////    FLAutoreleaseObject(newState);
////	FLAssertIsNotNil(newState.object);
////#else
////	FLRelease(newState);
////#endif    
////}
//
////- (void) closeXMLElement:(FLPropertyInflator*) element {
////    
////    FLAssertIsNotNil(lastState.object);
////	
////    NSString* unparsedData = element.data; 
////	
////    if(unparsedData	 && unparsedData.length > 0) {
////		unparsedData = [unparsedData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
////	
////		if(unparsedData.length > 0) {
////			if(lastState) {
////
////                FLAssertIsNotNil(self.dataDecoder);
////                
////				id inflatedPropertyObject = [self.dataDecoder decodeDataFromString:unparsedData forType:lastState]; 
////
////				if(inflatedPropertyObject) {
////					lastState.data = inflatedPropertyObject;
////				}
////				else {
////					lastState.data = unparsedData; // trimmed.
////				}
////				
////				[lastState.object finishParsingFrom:self state:lastState];
////			}
////#if DEBUG	 
////			else
////			{
////				FLDebugLog(@"Warning: %@ doesn't know about %@: %@: data: %@", NSStringFromClass([lastState.object class]), lastState.dataIsAttribute ? @"attribute" : @"element", elementName, unparsedData); 
////			
////			}
////#endif				  
////		}
////	}
////	
////    [_parseStack removeLastObject];
////}
//
///* delegate callbacks */
//
//- (void) objectBuilder:(FLObjectBuilder*) builder 
//            encounteredError:(NSError*) error 
//                   errorHint:(int) errorHint
//             errorHelp:(FLPrettyString*) errorHelp {
//
//    if(error /*&& !self.objectBuilder.error*/) {
//
////        if([error errorDomainEqualsDomain:NSXMLParserErrorDomain]) {
////            
////            NSString* name = [FLXmlObjectBuilder errorStringForCode:error.code];
////            
////            NSString* errorStr = [NSString stringWithFormat:@"%@ (%ld). Line: %ld, Column: %ld, Hint: %@",
////                name != nil ? name : @"Unknown",
////                (long) error.code,
////                (long)_parser.lineNumber,
////                (long)_parser.columnNumber,
////            errorHint ? errorHint : @""];
////
////            error = [NSError errorWithDomain:NSXMLParserErrorDomain code:error.code localizedDescription:errorStr];
////        }
//
//    }
//
//    [_parser abortParsing];
//            
//}            
//
//- (void)parser:(NSXMLParser *)parser 
//didStartElement:(NSString *)elementName 
//  namespaceURI:(NSString *)namespaceURI 
// qualifiedName:(NSString *)qName 
//    attributes:(NSDictionary *)attributes {
//        
//    if(!_gotFirstElement) {
//        _gotFirstElement = YES;
//    }
//    else {
//        [self.objectBuilder startInflatingPropertyWithName:elementName withState:0];
//    }
//    
//    if(attributes && attributes.count > 0) {
//        for(NSString* key in attributes) {
//            [self.objectBuilder addProperty:key withEncodedString:[attributes valueForKey:key] withState:FLXmlPropertyInflationIsAttribute];
//        }
//    }
//}
//
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    [self.objectBuilder.lastInflator appendEncodedString:string];
//}
//
//- (void)parser:(NSXMLParser *)parser 
//	didEndElement:(NSString *)elementName 
//	namespaceURI:(NSString *)namespaceURI 
//	qualifiedName:(NSString *)qName {
//    
//    [self.objectBuilder finishInflatingProperty];
// }
//
//- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
//	[self.objectBuilder setError:parseError errorHint:FLXmlParserParseErrorHint];
//}
//
//- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
//	[self.objectBuilder setError:validationError errorHint:FLXmlParserValidationErrorHint];
//}
//
//typedef struct {
//    NSXMLParserError code;
//    __unsafe_unretained NSString* errorString;
//} FLErrorLookup;
//
//FLErrorLookup s_lookup[] = {
//    { NSXMLParserInternalError, @"InternalError" },
//    { NSXMLParserOutOfMemoryError, @"OutOfMemoryError" },
//    { NSXMLParserDocumentStartError,@"DocumentStartError" },
//    { NSXMLParserEmptyDocumentError, @"EmptyDocumentError" },
//    { NSXMLParserPrematureDocumentEndError, @"PrematureDocumentEndError" },
//    { NSXMLParserInvalidHexCharacterRefError, @"InvalidHexCharacterRefError" },
//    { NSXMLParserInvalidDecimalCharacterRefError, @"InvalidDecimalCharacterRefError" },
//    { NSXMLParserInvalidCharacterRefError, @"InvalidCharacterRefError" },
//    { NSXMLParserInvalidCharacterError , @"InvalidCharacterError" },
//    { NSXMLParserCharacterRefAtEOFError , @"CharacterRefAtEOFError" },
//    { NSXMLParserCharacterRefInPrologError, @"CharacterRefInPrologError" },
//    { NSXMLParserCharacterRefInEpilogError, @"CharacterRefInEpilogError" },
//    { NSXMLParserCharacterRefInDTDError, @"CharacterRefInDTDError" },
//    { NSXMLParserEntityRefAtEOFError, @"EntityRefAtEOFError" },
//    { NSXMLParserEntityRefInPrologError, @"EntityRefInPrologError" },
//    { NSXMLParserEntityRefInEpilogError, @"EntityRefInEpilogError" },
//    { NSXMLParserEntityRefInDTDError, @"EntityRefInDTDError" },
//    { NSXMLParserParsedEntityRefAtEOFError, @"ParsedEntityRefAtEOFError" },
//    { NSXMLParserParsedEntityRefInPrologError, @"ParsedEntityRefInPrologError" },
//    { NSXMLParserParsedEntityRefInEpilogError, @"ParsedEntityRefInEpilogError" },
//    { NSXMLParserParsedEntityRefInInternalSubsetError, @"ParsedEntityRefInInternalSubsetError" },
//    { NSXMLParserEntityReferenceWithoutNameError, @"EntityReferenceWithoutNameError" },
//    { NSXMLParserEntityReferenceMissingSemiError, @"EntityReferenceMissingSemiError" },
//    { NSXMLParserParsedEntityRefNoNameError, @"ParsedEntityRefNoNameError" },
//    { NSXMLParserParsedEntityRefMissingSemiError, @"ParsedEntityRefMissingSemiError" },
//    { NSXMLParserUndeclaredEntityError, @"UndeclaredEntityError" },
//    { NSXMLParserUnparsedEntityError, @"UnparsedEntityError" },
//    { NSXMLParserEntityIsExternalError, @"EntityIsExternalError" },
//    { NSXMLParserEntityIsParameterError, @"EntityIsParameterError" },
//    { NSXMLParserUnknownEncodingError, @"UnknownEncodingError" },
//    { NSXMLParserEncodingNotSupportedError, @"EncodingNotSupportedError" },
//    { NSXMLParserStringNotStartedError, @"StringNotStartedError" },
//    { NSXMLParserStringNotClosedError, @"StringNotClosedError" },
//#if IOS
////    { NSXMLParserNamespaceHeaderError, @"NamespaceHeaderError" },
//#endif    
//    { NSXMLParserEntityNotStartedError, @"EntityNotStartedError" },
//    { NSXMLParserEntityNotFinishedError, @"EntityNotFinishedError" },
//    { NSXMLParserLessThanSymbolInAttributeError, @"LessThanSymbolInAttributeError" },
//    { NSXMLParserAttributeNotStartedError, @"AttributeNotStartedError" },
//    { NSXMLParserAttributeNotFinishedError, @"AttributeNotFinishedError" },
//    { NSXMLParserAttributeHasNoValueError, @"AttributeHasNoValueError" },
//    { NSXMLParserAttributeRedefinedError, @"AttributeRedefinedError" },
//    { NSXMLParserLiteralNotStartedError, @"LiteralNotStartedError" },
//    { NSXMLParserLiteralNotFinishedError, @"LiteralNotFinishedError" },
//    { NSXMLParserCommentNotFinishedError, @"CommentNotFinishedError" },
//    { NSXMLParserProcessingInstructionNotStartedError, @"ProcessingInstructionNotStartedError" },
//    { NSXMLParserProcessingInstructionNotFinishedError, @"ProcessingInstructionNotFinishedError" },
//    { NSXMLParserNotationNotStartedError, @"NotationNotStartedError" },
//    { NSXMLParserNotationNotFinishedError, @"NotationNotFinishedError" },
//    { NSXMLParserAttributeListNotStartedError, @"AttributeListNotStartedError" },
//    { NSXMLParserAttributeListNotFinishedError, @"AttributeListNotFinishedError" },
//    { NSXMLParserMixedContentDeclNotStartedError, @"MixedContentDeclNotStartedError" },
//    { NSXMLParserMixedContentDeclNotFinishedError, @"MixedContentDeclNotFinishedError" },
//    { NSXMLParserElementContentDeclNotStartedError, @"ElementContentDeclNotStartedError" },
//    { NSXMLParserElementContentDeclNotFinishedError, @"ElementContentDeclNotFinishedError" },
//    { NSXMLParserXMLDeclNotStartedError, @"XMLDeclNotStartedError" },
//    { NSXMLParserXMLDeclNotFinishedError, @"XMLDeclNotFinishedError" },
//    { NSXMLParserConditionalSectionNotStartedError, @"ConditionalSectionNotStartedError" },
//    { NSXMLParserConditionalSectionNotFinishedError, @"ConditionalSectionNotFinishedError" },
//    { NSXMLParserExternalSubsetNotFinishedError, @"ExternalSubsetNotFinishedError" },
//    { NSXMLParserDOCTYPEDeclNotFinishedError, @"DOCTYPEDeclNotFinishedError" },
//    { NSXMLParserMisplacedCDATAEndStringError, @"MisplacedCDATAEndStringError" },
//    { NSXMLParserCDATANotFinishedError, @"CDATANotFinishedError" },
//#if IOS
////    { NSXMLParserMisplacedXMLHeaderError, @"MisplacedXMLHeaderError" },
//#endif
//    { NSXMLParserSpaceRequiredError, @"SpaceRequiredError" },
//    { NSXMLParserSeparatorRequiredError, @"SeparatorRequiredError" },
//    { NSXMLParserNMTOKENRequiredError, @"NMTOKENRequiredError" },
//    { NSXMLParserNAMERequiredError, @"NAMERequiredError" },
//    { NSXMLParserPCDATARequiredError, @"PCDATARequiredError" },
//    { NSXMLParserURIRequiredError, @"URIRequiredError" },
//    { NSXMLParserPublicIdentifierRequiredError, @"PublicIdentifierRequiredError" },
//    { NSXMLParserLTRequiredError, @"LTRequiredError" },
//    { NSXMLParserGTRequiredError, @"GTRequiredError" },
//    { NSXMLParserLTSlashRequiredError, @"LTSlashRequiredError" },
//    { NSXMLParserEqualExpectedError, @"EqualExpectedError" },
//    { NSXMLParserTagNameMismatchError, @"TagNameMismatchError" },
//    { NSXMLParserUnfinishedTagError, @"UnfinishedTagError" },
//    { NSXMLParserStandaloneValueError, @"StandaloneValueError" },
//    { NSXMLParserInvalidEncodingNameError, @"InvalidEncodingNameError" },
//    { NSXMLParserCommentContainsDoubleHyphenError, @"CommentContainsDoubleHyphenError" },
//    { NSXMLParserInvalidEncodingError, @"InvalidEncodingError" },
//    { NSXMLParserExternalStandaloneEntityError, @"ExternalStandaloneEntityError" },
//    { NSXMLParserInvalidConditionalSectionError, @"InvalidConditionalSectionError" },
//    { NSXMLParserEntityValueRequiredError, @"EntityValueRequiredError" },
//    { NSXMLParserNotWellBalancedError, @"NotWellBalancedError" },
//    { NSXMLParserExtraContentError, @"ExtraContentError" },
//    { NSXMLParserInvalidCharacterInEntityError, @"InvalidCharacterInEntityError" },
//    { NSXMLParserParsedEntityRefInInternalError, @"ParsedEntityRefInInternalError" },
//    { NSXMLParserEntityRefLoopError, @"EntityRefLoopError" },
//    { NSXMLParserEntityBoundaryError, @"EntityBoundaryError" },
//    { NSXMLParserInvalidURIError, @"InvalidURIError" },
//    { NSXMLParserURIFragmentError, @"URIFragmentError" },
//    { NSXMLParserNoDTDError, @"NoDTDError" },
//    { NSXMLParserDelegateAbortedParseError, @"DelegateAbortedParseError" } 
//};
//
//+ (NSString*) errorStringForCode:(NSXMLParserError) code {
//
//    NSInteger count = sizeof(s_lookup) / sizeof(FLErrorLookup);
//    
//    for(int i = 0; i < count; i++) {
//        if(s_lookup[i].code == code) {
//            return s_lookup[i].errorString;
//        }
//    }
//    
//    return nil;
//}
//
//
//@end

//@implementation NSObject (FLXmlObjectBuilder)
//
//+ (id) objectWithContentsOfXMLFile:(NSString*) path 
//                   withDataDecoder:(id<FLDataDecoding>) decoder {
//    
//    NSError* error = nil;
//    NSData* data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
//    if(error) {
//        FLThrowIfError(FLAutorelease(error));
//    }
//
//    FLXmlObjectBuilder* parser = [FLXmlObjectBuilder xmlObjectBuilder];
//    
//    return [parser buildObjectWithClass:[self class] withData:data withDataDecoder:decoder];
//}
//
//@end



