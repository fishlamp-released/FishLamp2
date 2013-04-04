//
//  FLScopeStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
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

- (FLDocumentSection*) openedSection {
    return [_document openedStringBuilder];
}

- (void) appendLinesToStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [_document.rootStringBuilder appendLinesToStringFormatter:stringFormatter];
}

- (void) openSection:(FLDocumentSection*) element {
    [self.document openStringBuilder:element];
}

- (void) addSection:(FLDocumentSection*) element {
    [self.document addStringBuilder:element];
}

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
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
}

- (NSString*) description {
    FLPrettyString* string = [FLPrettyString prettyString];
    [self appendLinesToStringFormatter:string];
    return string.string;
}


@end