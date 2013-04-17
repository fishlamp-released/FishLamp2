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
#import "FLTypeDesc.h"
#import "FLObjectDescriber.h"

@interface FLXmlObjectBuilder ()
- (id) inflateObjectWithPropertyDescription:(FLTypeDesc*) propertyType withElement:(FLParsedItem*) element;
- (void) addPropertiesToObject:(id) object withElement:(FLParsedItem*) element  typeDesc:(FLTypeDesc*) typeDesc;
@end

@implementation NSArray (FLXmlObjectBuilder)

//+ (id) createObjectWithDescription:(FLTypeDesc*) description {
//    NSMutableArray* array = [NSMutableArray array];
//
//}

@end

@interface NSObject (FLXmlObjectBuilder)
//+ (id) objectFromParsedItem:(FLParsedItem*) item  withObjectDescriber:(FLTypeDesc*) typeDesc withDecoder:(id<FLDataDecoding>) decoder;
//- (void) addPropertiesWithElement:(FLParsedItem*) element typeDesc:(FLTypeDesc*) typeDesc;
@end

@implementation FLParsedItem (FLXmlObjectBuilder) 

//- (NSArray*) inflateSelfIntoArrayWithObjectDescriber:(FLTypeDesc*) propertyType withDecoder:(id<FLDataDecoding>) decoder {
//    NSMutableArray* newArray = [NSMutableArray array];
//
//    FLAssertNotNil(newArray);
//    FLAssertNotNil(propertyType);
//    FLConfirmNotNilWithComment(propertyType.subtypes, @"expecting an array propertyType");
//
//    for(id elementName in self.elements) {
//        id elementOrArray = [self.elements objectForKey:elementName];
//
//        FLTypeDesc* arrayType = [propertyType subTypeForIdentifier:elementName]
//        
//        FLConfirmNotNilWithComment(arrayType, @"arrayType for element \"%@\" not found", elementName);
//
//        [newArray addObject:[arrayType.objectType objectFromParsedItem:]]
//        
//        if([elementOrArray isKindOfClass:[NSArray class]]) {
//            for(FLParsedItem* child in elementOrArray) {			
//                [newArray addObject:[self inflateObjectWithPropertyDescription:arrayType withElement:child]];
//            }
//        }
//        else {
//            FLAssert([elementOrArray isKindOfClass:[FLParsedItem class]]);
//            
//            id value = [self inflateObjectWithPropertyDescription:arrayType withElement:elementOrArray];
//            if(value) {
//                [newArray addObject:value];
//            }
//            else {
//                FLLog(@"Unable to inflate xml element %@:%@", elementName, [elementOrArray description]);
//            }
//        }
//    }
//}

@end

@implementation NSMutableArray (FLXmlObjectBuilder) 

//- (void) inflateElement:(FLParsedItem*) item intoArray

//+ (id) objectFromParsedItem:(FLParsedItem*) item  withObjectDescriber:(FLTypeDesc*) typeDesc withDecoder:(id<FLDataDecoding>) decoder {
//    
//    NSMutableArray* array = [NSMutableArray array];
//    for(id elementName in self.elements) {
//
//        FLTypeDesc* arrayType = [propertyType subTypeForIdentifier:elementName]
//
//        id object = [self.elements objectForKey:elementName];
//
//        [array addObject:[object objectFromParsedItem:s]
//
//
//            if([elementOrArray isKindOfClass:[FLParsedItem class]]) {
//                [self inflateElement:elementOrArray
//                           intoArray:propertyValue 
//             propertyType:propertyType];
//            }
//            else {
//            
//                FLAssert([elementOrArray isKindOfClass:[NSArray class]]);
//                for(FLParsedItem* child in elementOrArray) {
//                    [self inflateElement:child
//                               intoArray:propertyValue 
//                              propertyType:propertyType];
//                                
//                }
//
//            }
//        }
//        else {
//            FLAssert([elementOrArray isKindOfClass:[FLParsedItem class]]);
//            propertyValue = [self inflateObjectWithPropertyDescription:propertyType 
//                                                                     withElement:elementOrArray];
//        }
//        
//        if(propertyValue) {
//            [object setValue:propertyValue forKey:propertyType.identifier];
//        }
//
//}

@end

@implementation NSObject (FLXmlObjectBuilder)

//- (void) addPropertiesWithElement:(FLParsedItem*) element typeDesc:(FLTypeDesc*) typeDesc {
//    
//    FLAssertNotNil(object);
//
//    for(id elementName in element.elements) {
//
//        FLTypeDesc* propertyType = [typeDesc.subtypes objectForKey:elementName];
//        if(!propertyType) {
//            FLLog(@"object builder skipped missing propertyType named: %@", elementName);
//            continue;
//        }
//                
//        id objectInElement = [element.elements objectForKey:elementName];
//        
//        id propertyValue = [propertyType.objectClass objectFromParsedItem:element withObjectDescriber:propertyType];
//        if(propertyValue) {
//            [object setValue:propertyValue forKey:propertyType.identifier];
//        }
//    }
//}
//
//+ (id) objectFromParsedItem:(FLParsedItem*) item  withObjectDescriber:(FLTypeDesc*) typeDesc withDecoder:(id<FLDataDecoding>) decoder{
//
//    if(typeDesc) {
//        FLAssert([typeDesc.objectClass isKindOfClass:[self class]]);
//        
//        id object = FLAutorelease([[typeDesc.objectClass alloc] init]);
//        FLAssertNotNilWithComment(object, @"unabled to create object of type: %@", NSStringFromClass(typeDesc.objectClass));
//        
//        [object addPropertiesWithElement:item] 
//        return object;
//    }
//    
//    FLObjectEncoder* encoder = propertyType.objectEncoder;
//    if(!encoder) {
//        return nil;
//    }
//    
//    id object = [self.decoder decodeDataFromString:[element value] forType:encoder];
//    FLAssertNotNil(object);
//
//
//}

@end

@implementation NSObject (FLXmlBuilder)
+ (BOOL) isArray {
    return NO;
}
- (BOOL) isArray {
    return NO;
}
@end

@implementation NSArray (FLXmlBuilder)
+ (BOOL) isArray {
    return YES;
}
- (BOOL) isArray {
    return YES;
}
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

//- (FLTypeDesc*) arrayTypeForName:(NSString*) name
//                    propertyType:(FLTypeDesc*) typeDesc {
//
//    for(FLTypeDesc* desc in typeDesc.arrayTypes) {
//        if(FLStringsAreEqual(name, desc.identifier)) {
//            return desc;
//        }
//    }
//
//    return nil;
//} 

- (void) inflateElement:(FLParsedItem*) element 
              intoArray:(NSMutableArray*) newArray
           propertyType:(FLTypeDesc*) propertyType {

    FLAssertNotNil(newArray);
    FLAssertNotNil(propertyType);
    FLConfirmNotNilWithComment(propertyType.subtypes, @"expecting an array propertyType");

    for(id elementName in element.elements) {
        id elementOrArray = [element.elements objectForKey:elementName];

        FLTypeDesc* arrayType = [propertyType subTypeForIdentifier:elementName];
        
        FLConfirmNotNilWithComment(arrayType, @"arrayType for element \"%@\" not found", elementName);
        
        if([elementOrArray isArray]) {
            for(FLParsedItem* child in elementOrArray) {			
                [newArray addObject:[self inflateObjectWithPropertyDescription:arrayType withElement:child]];
            }
        }
        else {
            FLAssert([elementOrArray isKindOfClass:[FLParsedItem class]]);
            id value = [self inflateObjectWithPropertyDescription:arrayType withElement:elementOrArray];
            if(value) {
                [newArray addObject:value];
            }
            else {
                FLLog(@"Unable to inflate xml element %@:%@", elementName, [elementOrArray description]);
            }
        }
    }
}


- (id) inflateObjectWithPropertyDescription:(FLTypeDesc*) propertyType withElement:(FLParsedItem*) element  {
    FLAssertNotNil(propertyType);
    
    id object = nil;
    Class objectClass = propertyType.objectClass;
    if(!objectClass) {
        return nil;
    }
    
    FLTypeDesc* typeDesc = [objectClass objectDescriber];
    if(typeDesc) {
        object = FLAutorelease([[objectClass alloc] init]);
        [self addPropertiesToObject:object withElement:element typeDesc:typeDesc];
        
        // NOTE: what if there is a value?? 
        
    }
    else if([element value]) {
        FLObjectEncoder* encoder = propertyType.objectEncoder;
        if(encoder) {
            object = [self.decoder decodeDataFromString:[element value] forType:encoder];
            
            if(!object) {
                FLLog(@"object not expanded for %@:%@", [element elementName], [element value]);
            }
        }
    }
    
    return object;
}


- (void) addPropertiesToObject:(id) object 
                   withElement:(FLParsedItem*) element  
                      typeDesc:(FLTypeDesc*) typeDesc {
    
    FLAssertNotNil(object);

    for(id elementName in element.elements) {
        
        FLTypeDesc* propertyType = [typeDesc.subtypes objectForKey:elementName];
        if(!propertyType) {
            FLLog(@"object builder skipped missing propertyType named: %@", elementName);
            continue;
        }
        
        // decide if the property we're inflating is an object or an array
        
        if([propertyType.objectClass isArray]) {
            // we need to inflate an array
            // we need to build the array either from a parsedXML element, or an array of parsedXML elements.
            
            id elementOrArray = [element.elements objectForKey:elementName];

            NSMutableArray* array = [NSMutableArray array];

            if([elementOrArray isArray]) {
            
            // we're building array from array of xmlElements
            
                for(FLParsedItem* child in elementOrArray) {
                    [self inflateElement:child
                               intoArray:array 
                              propertyType:propertyType];
                                
                }
            }
            else {
            
            // we're building the array from an xmlElement
            
                id xmlElement = [element.elements objectForKey:elementName];
                FLAssert([xmlElement isKindOfClass:[FLParsedItem class]]);
                
                [self inflateElement:xmlElement
                           intoArray:array 
             propertyType:propertyType];
            
            }
        
            if(array.count) {
                [object setValue:array forKey:propertyType.identifier];
            }
        }
        else {
        
        // we're inflating a single object
        
            id xmlElement = [element.elements objectForKey:elementName];
            FLAssert([xmlElement isKindOfClass:[FLParsedItem class]]);
            
            id newObject = [self inflateObjectWithPropertyDescription:propertyType 
                                                                     withElement:xmlElement];
        
            if(newObject) {
                [object setValue:newObject forKey:propertyType.identifier];
            }
        }
        
        
    }
}

- (FLParsedItem*) willBuildObjectsWithXML:(FLParsedItem*) element {
    return element;
}

- (id) buildObjectFromXML:(FLParsedItem*) element withTypeDesc:(FLTypeDesc*) propertyType {
    FLAssertNotNil(self.decoder);
    FLAssertNotNil(element);
    FLAssertNotNil(propertyType);

    if(!FLStringsAreEqual(element.elementName, propertyType.identifier)) {
        FLParsedItem* subElement = [element elementForElementName:propertyType.identifier];

        if(!subElement) {
            FLThrowErrorCodeWithComment(NSCocoaErrorDomain, NSFileNoSuchFileError, @"XmlObjectBuilder: \"%@\" not found in \"%@\"", propertyType.identifier, element.elementName);
        }
        
        element = subElement;
    }

////    FLAssertWithComment(FLStringsAreEqual(element.elementName, propertyType.identifier), @"trying to build wrong object element name: \"%@\", object typeDesc name: \"%@\"", element.elementName, propertyType.identifier);
//    return [propertyType.objectClass objectFromParsedItem:element withObjectDescriber:propertyType];

    Class objectClass = propertyType.objectClass;
    if(!objectClass) {
        return nil;
    }

    FLTypeDesc* typeDesc = [objectClass objectDescriber];
    if(typeDesc) {
        id rootObject = FLAutorelease([[objectClass alloc] init]);
        FLAssertNotNilWithComment(rootObject, @"unabled to create object of type: %@", NSStringFromClass(objectClass));
        
        [self addPropertiesToObject:rootObject withElement:element typeDesc:typeDesc];
        return rootObject;
    }
    
    FLObjectEncoder* encoder = propertyType.objectEncoder;
    if(!encoder) {
        return nil;
    }
    
    id object = [self.decoder decodeDataFromString:[element value] forType:encoder];
    FLAssertNotNil(object);

    return object;
}

- (id) objectFromXML:(FLParsedItem*) element withTypeDesc:(FLTypeDesc*) propertyType {

    element = [self willBuildObjectsWithXML:element];
    
    return [self buildObjectFromXML:element withTypeDesc:propertyType];
}

- (NSArray*) objectsFromXML:(FLParsedItem*) xmlElement withTypeDescs:(NSArray*) properties {

    xmlElement = [self willBuildObjectsWithXML:xmlElement];
    
    NSMutableArray* array = [NSMutableArray array];
    
    for(id elementName in xmlElement.elements) {
        
        for(FLTypeDesc* propertyType in properties) {

            if(FLStringsAreEqual(propertyType.identifier, elementName)) {
            
                id objectXML = [xmlElement.elements objectForKey:elementName];
            
                id object = [self objectFromXML:objectXML withTypeDesc:propertyType];
                
                if(object) {
                    [array addObject:object];
                }
            }
        }
    }
    
    return array;
}

- (NSArray*) objectsFromXML:(FLParsedItem*) xmlElement withTypeDesc:(FLTypeDesc*) type {
    return [self objectsFromXML:xmlElement withTypeDescs:[NSArray arrayWithObject:type]];
}

//- (id) objectFromXML:(FLParsedItem*) objectXML withTypeDesc:(FLTypeDesc*) type {
//    
//    return [self buildObjectFromXML:objectXML withPropertyDescriber:type];
//                
//                
//    
//    NSArray* objects = [self objectsFromXML:element withTypeDesc:type];
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
////	newState.typeDesc = [[newState.object class] typeDesc];
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
////        if([error isErrorDomain:NSXMLParserErrorDomain]) {
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
//            [self.objectBuilder setChildForIdentifier:key withEncodedString:[attributes valueForKey:key] withState:FLXmlPropertyInflationIsAttribute];
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




