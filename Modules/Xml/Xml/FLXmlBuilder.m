//
//	FLXmlBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLXmlBuilder.h"
#import "FLStringUtilities.h"
#import "FLDataEncoder.h"

#define EOL @"\r\n"

@implementation FLXmlBuilder

@synthesize dataEncoder = _dataEncoder;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

+ (FLXmlBuilder*) xmlBuilder {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

#if FL_DEALLOC 
- (void) dealloc {
    [_attributeName release];
    [_attributeValue release];
    [_attributes release];
    [_comments release];
    [super dealloc];
}
#endif

-(void) appendXmlVersionDeclaration:(NSString*) version 
               andEncodingHeader:(NSString*) encoding
               standalone:(BOOL) standalone {
    
    FLAssert(self.length == 0, @"expecting zero length builder when append version header");

	[self appendFormat:@"<?xml version=\"%@\" encoding=\"%@\" standalone=\"%@\"?>", version, encoding, standalone ? @"yes" : @"no"];
}

- (void) appendDefaultXmlDeclaration {
    [self appendXmlVersionDeclaration:FLXmlVersion1_0 andEncodingHeader:FLXmlEncodingUtf8 standalone:YES];
}

-(void) openElementWithAttributes:(NSString*) elementName {
    NSString* openTag = elementName;
	if(_attributes && [_attributes count] > 0) {
		NSMutableString* bigTag = [NSMutableString stringWithString:elementName];
        for(NSString* attr in _attributes) {
            [bigTag appendString:attr];
		}
        openTag = bigTag;
		[_attributes removeAllObjects];
	}

	[self openScope:FLXmlElementScope openTag:openTag closeTag:elementName];
}	

- (void) openAttribute:(NSString*) attrName {
    
    FLAssertIsNil(_attributeValue);
    FLAssertIsNil(_attributeName);
    FLAssignObject(_attributeName, attrName);
	_attributeValue = [[NSMutableString alloc] init];
}

- (void) appendAttributeWithString:(NSString*) string {
	[_attributeValue appendString:string];
}

- (void) appendAttributeWithFormat:(NSString*) data, ... {
	va_list va;
	va_start(va, data);
	NSString *string = [[NSString alloc] initWithFormat:data arguments:va];
	va_end(va);
	[_attributeValue appendString:string];
	FLReleaseWithNil(string);
}

- (void) closeAttribute {
	[self pushAttribute:_attributeName value:_attributeValue];
	FLReleaseWithNil(_attributeValue);
	FLReleaseWithNil(_attributeName);
}

- (void) appendComments {
	for(NSString* comment in _comments) {
		[self appendComment:comment];
	}
	
	[_comments removeAllObjects];
}

-(void)openElement:(NSString*) elementName {
	[self openElementWithAttributes:elementName];
	[self appendComments];
}

- (void) appendElementWithString:(NSString*) string {
	if(string) {
		[self appendLine:string];
	}
}

- (void) appendComment:(NSString*) comment {
	if(FLStringIsNotEmpty(comment)) {
		[self appendLineWithFormat:@"<!-- %@ -->", comment];
	}
}

- (void)closeElement {
	[self closeScope];
}

- (void) skipElement {
    [self skipScope];
}

- (void) pushComment:(NSString*) comment {
	if(!_comments) {
		_comments = [[NSMutableArray alloc] init];
	}

	[_comments addObject:comment];
}

- (void) pushAttribute:(NSString*) name value:(NSString*) value {

	if(!_attributes) {
		_attributes = [[NSMutableArray alloc] init];
	}

	NSString* attr = [[NSString alloc] initWithFormat:@"%@=\"%@\"", name, value];
	[_attributes addObject:attr];
	FLRelease(attr);
}

- (void) appendClosedElement:(NSString*) element  {
    
}

- (void) appendElement:(NSString*) elementName value:(NSString*) value {
    [self openElement:elementName];
    [self appendElementWithString:value];
    [self closeElement];
//
//return;
//
//// THIS is a pretty print output optimization
//
////	if(_comments.count) {
////		[self openElement:elementName];
////		[self appendElementValueWithString:string];
////		[self closeElement];
////	}
////	else {
////		[self openElementWithAttributes:elementName];
////		[self appendFormat:@"%@</%@>", string ? string : @"", elementName];
////		[self appendLine];
////		[self undent];
////	}
}


+ (NSDictionary*) defaultScopeFormatters {

    FLReturnStaticObjectFromBlock((^{
        NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
        [dictionary addCodeScopeFormatter:[FLXmlCodeScopeFormatter instance]];
        [dictionary addCodeScopeFormatter:[FLXmlCommentCodeScopeFormatter instance]];
        return dictionary;
    }));
}


@end

@implementation FLXmlCodeScopeFormatter

- (FLCodeScopeId) scopeId {
    return FLXmlElementScope;
}

FLSynthesizeSingleton(FLXmlCodeScopeFormatter);

- (void) openScope:(FLCodeBuilder*) codeBuilder
             scope:(FLCodeScope*) scope {
 
    [codeBuilder appendLineWithFormat:@"<%@>", scope.openTag];
}


- (void) closeScope:(FLCodeBuilder*) codeBuilder
              scope:(FLCodeScope*) scope {
    [codeBuilder appendLineWithFormat:@"</%@>", scope.closeTag];
}

@end


@implementation FLXmlCommentCodeScopeFormatter

- (FLCodeScopeId) scopeId {
    return FLXmlCommentScope;
}

FLSynthesizeSingleton(FLXmlCommentCodeScopeFormatter);

- (void) openScope:(FLCodeBuilder*) codeBuilder
             scope:(FLCodeScope*) scope {
 
    [codeBuilder appendLineWithFormat:@"<!--"];
}


- (void) closeScope:(FLCodeBuilder*) codeBuilder
              scope:(FLCodeScope*) scope {
    [codeBuilder appendLineWithFormat:@"-->"];
}
@end


