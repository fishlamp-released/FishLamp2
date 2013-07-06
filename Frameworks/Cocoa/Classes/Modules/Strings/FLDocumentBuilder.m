//
//  FLScopeStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/1/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDocumentBuilder.h"

@implementation FLDocumentBuilder 

@synthesize document = _document;

- (id) init {
    self = [super init];
    if(self) {
        _document = [[FLStringDocument alloc] init];
        _document.rootStringBuilder.parent = self;
        self.stringFormatterOutput = self;

    }
    return self;
}

+ (id) documentBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_document release];
    [super dealloc];
}
#endif

//- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
//            appendString:(NSString*) string
//  appendAttributedString:(NSAttributedString*) attributedString
//              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {
//
//    [[self openedSection] stringFormatter:stringFormatter appendString:string appendAttributedString:attributedString lineUpdate:lineUpdate];
//}                                                 

- (id<FLStringFormatter>) openedSection {
    return [_document openedStringBuilder];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter
appendSelfToStringFormatter:(id<FLStringFormatter>) anotherStringFormatter {
    [anotherStringFormatter appendStringFormatter:_document.rootStringBuilder];
}

- (void) appendStringFormatter:(id<FLStringFormatter>) element {
    [self.document appendStringFormatter:element];
}

- (void) openSection:(id<FLStringFormatter>) element {
    [self.document openStringBuilder:element];
}

//- (void) appendStringFormatter:(id<FLStringFormatter>) element {
//    [self.document appendStringFormatter:element];
//}

- (void) closeSection {
    [self.document closeStringBuilder];
}

- (void) closeAllSections {
    [self.document closeAllStringBuilders];
}

- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter {
    [[self openedSection] stringFormatterAppendBlankLine:stringFormatter];
}

- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter {
    [[self openedSection] stringFormatterOpenLine:stringFormatter];
}

- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter {
    [[self openedSection] stringFormatterCloseLine:stringFormatter];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string {
    [[self openedSection] stringFormatter:stringFormatter appendString:string];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString {
    [[self openedSection] stringFormatter:stringFormatter appendAttributedString:attributedString];
}

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
    [[self openedSection] stringFormatterIndent:stringFormatter];
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
    [[self openedSection] stringFormatterOutdent:stringFormatter];
}

- (NSString*) description {
    FLPrettyString* string = [FLPrettyString prettyString];
    [string appendStringFormatter:self];
    return string.string;
}

- (id) parent {
    return nil;
}

//- (void) appendDocument:(FLDocumentBuilder*) document {
//    [self appendStringFormatter:document];
//}

- (NSString*) buildString {
    return [self buildStringWithWhitespace:[FLPrettyString defaultWhitespace]];
}

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace {
    FLPrettyString* prettyString = [FLPrettyString prettyString:whitespace];
    [prettyString appendStringFormatter:self];
    return prettyString.string;
}

- (NSString*) buildStringWithNoWhitespace {
    return [self buildStringWithWhitespace:nil];
}

- (NSUInteger) stringFormatterGetLength:(id<FLStringFormatter>) formatter {
    return [_document length];
}


@end