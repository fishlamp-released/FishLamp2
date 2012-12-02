//
//	FLBaseXmlParser.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/6/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLBaseXmlParser.h"
#import "FLDataEncoder.h"
#import "NSError+FLExtras.h"

@implementation FLBaseXmlParser
@synthesize dataDecoder = _dataDecoder;

@synthesize error = _error;
@synthesize parser = _parser;

- (void) setError:(NSError*) error errorHint:(NSString*) errorHint {
    if(error && !_error) {
        if([error errorDomainEqualsDomain:NSXMLParserErrorDomain]) {
            
            NSString* name = [FLBaseXmlParser errorStringForCode:error.code];
            
            NSString* errorStr = [NSString stringWithFormat:@"%@ (%ld). Line: %ld, Column: %ld, Hint: %@",
                name != nil ? name : @"Unknown",
                (long) error.code,
                (long)_parser.lineNumber,
                (long)_parser.columnNumber,
            errorHint ? errorHint : @""];

            error = [NSError errorWithDomain:NSXMLParserErrorDomain code:error.code localizedDescription:errorStr];
        }
        
        FLRetainObject_(_error, error);
        [_parser abortParsing];
    }
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (void) dealloc
{
	_parser.delegate = nil;
	release_(_parser);
	release_(_error);
	release_(_dataDecoder);
	super_dealloc_();
}

- (id<FLDataDecoder>) onCreateDataDecoder {
    return nil;
}

- (void) parse:(NSData*) data
{
	FLAssertIsNil_(_parser);

    @try {
#if FL_MRC
        FLPerformBlockInAutoreleasePool(^{
#endif        
            if(!self.dataDecoder) {
                self.dataDecoder = [self onCreateDataDecoder];
            }
        
            FLAssertIsNotNil_(self.dataDecoder);
        
            _parser = [[NSXMLParser alloc] initWithData:data]; 
            [_parser setDelegate:self];
            
            [self onConfigureParser:_parser];
            
            [_parser parse];
#if FL_MRC
        });
#endif
    }
    @finally {
		_parser.delegate = nil;
    };
    	
	if(self.error)
	{
		FLThrowError_(autorelease_(retain_(self.error)));
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
	[self setError:parseError errorHint:@"Parse Error."];
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
	[self setError:validationError errorHint:@"Validation failed."];
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
    { NSXMLParserNamespaceDeclarationError, @"NamespaceDeclarationError" },
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
    { NSXMLParserMisplacedXMLDeclarationError, @"MisplacedXMLDeclarationError" },
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
