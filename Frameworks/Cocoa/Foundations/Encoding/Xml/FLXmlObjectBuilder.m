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

@synthesize saveParsePositions = _saveParsePositions;
@synthesize fileName = _fileName;
@synthesize parser = _parser;
@synthesize objectBuilder = _objectBuilder;

+ (id) xmlObjectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
	_parser.delegate = nil;

#if FL_MRC
    FLRelease(_fileName);
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
    self.objectBuilder.delegate = self;
    [self.objectBuilder openWithRootObjectClass:aClass withDataDecoder:decoder];

    @try {
        FLAutoreleasePool(
            _parser = [[NSXMLParser alloc] initWithData:data]; 
            [_parser setDelegate:self];
            
            [self willParseXMLData:data withXMLParser:_parser];
            [_parser parse];
        ) 

        if(self.objectBuilder.error) {
            FLThrowError(FLAutorelease(FLRetain(self.objectBuilder.error)));
        }
        
        return [self.objectBuilder finishBuilding];
    }
    @finally {
		_parser.delegate = nil;
        self.parser = nil;
        self.objectBuilder = nil;
    }
}

- (void) objectBuilder:(FLObjectBuilder*) objectBuilder willOpenObject:(FLObjectInflatorState*)object {
    if(_saveParsePositions) {
        object.parseInfo = [FLParseInfo parseInfo:object.key file:_fileName line:self.parser.lineNumber column:self.parser.columnNumber];
    }
}

//- (FLObjectInflatorState*) openXMLElement:(NSString*) elementName isAttribute:(BOOL) isAttribute {
//    
//    
//    FLObjectInflatorState* newState = [[FLObjectInflatorState alloc] initWithObject:[_parseStack.lastObject object] key:elementName];
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

//- (void) closeXMLElement:(FLObjectInflatorState*) element {
//    
//    FLAssertIsNotNil_(lastState.object);
//	
//    NSString* unparsedData = element.data; 
//	
//    if(unparsedData	 && unparsedData.length > 0) {
//		unparsedData = [unparsedData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//	
//		if(unparsedData.length > 0) {
//			if(lastState.parsedDataType) {
//
//                FLAssertIsNotNil_(self.dataDecoder);
//                
//				id inflatedObject = [self.dataDecoder decodeDataFromString:unparsedData forType:lastState.parsedDataType]; 
//
//				if(inflatedObject) {
//					lastState.data = inflatedObject;
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

    if(error && !self.objectBuilder.error) {

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
        [self.objectBuilder openObject:elementName];
    }
    
    if(attributes && attributes.count > 0) {
        for(NSString* key in attributes) {
            [self.objectBuilder addAttribute:key data:[attributes valueForKey:key]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.objectBuilder appendString:string];
}

- (void)parser:(NSXMLParser *)parser 
	didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
	qualifiedName:(NSString *)qName {
    
    [self.objectBuilder closeObject:[self.objectBuilder lastObject]];
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
        FLThrowError(FLAutorelease(error));
    }

    FLXmlObjectBuilder* parser = [FLXmlObjectBuilder xmlObjectBuilder];
    parser.fileName = path;
    parser.saveParsePositions = YES;
    
    return [parser buildObjectWithClass:[self class] withData:data withDataDecoder:decoder];
}

@end


