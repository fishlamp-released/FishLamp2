//
//	FLXmlBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLDataEncoder.h"
#import "FLCodeBuilder.h"

// xml
#define FLXmlVersion1_0                         @"1.0"
#define FLXmlEncodingUtf8                       @"utf-8"
#define FMXmlEncodingUtf16                      @"UTF-16"

@interface FLXmlBuilder : FLCodeBuilder {
@private
	NSMutableArray* _attributes;
    NSString* _attributeName;
	NSMutableString* _attributeValue;
	id<FLDataEncoder> _dataEncoder;
	NSMutableArray* _comments;
}

@property (readwrite, retain, nonatomic) id<FLDataEncoder> dataEncoder;

+ (FLXmlBuilder*) xmlBuilder;

- (void) appendXmlVersionDeclaration:(NSString*) version 
                andEncodingHeader:(NSString*) encoding
                       standalone:(BOOL) standalone;

- (void) appendDefaultXmlDeclaration;  
	
        	
- (void) pushAttribute:(NSString*) attributeName value:(NSString*) value;

- (void) openAttribute:(NSString*) attrName;
- (void) appendAttributeWithString:(NSString*) data;
- (void) appendAttributeWithFormat:(NSString*) data, ...;
- (void) closeAttribute; 

- (void) openElement:(NSString*) elementName;
- (void) appendElementWithString:(NSString*) data;
- (void) closeElement;
// pop last scope but don't print close tag.
- (void) skipElement; 

- (void) appendElement:(NSString*) elementName value:(NSString*) value;

/// push attributes on first.
- (void) appendClosedElement:(NSString*) elementName; // e.g <br/> or <foo bar="foobar">

- (void) appendComment:(NSString*) comment;
- (void) pushComment:(NSString*) comment;

@end

#define FLXmlElementScope 'xCod'

@interface FLXmlCodeScopeFormatter : FLCodeScopeFormatter {
}
FLSingletonProperty(FLXmlCodeScopeFormatter);
@end

#define FLXmlCommentScope 'xCom'

@interface FLXmlCommentCodeScopeFormatter : FLCodeScopeFormatter {
}
FLSingletonProperty(FLXmlCommentCodeScopeFormatter);
@end
