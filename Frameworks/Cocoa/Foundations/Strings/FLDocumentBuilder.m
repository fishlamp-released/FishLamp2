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
        self.delegate = self;
        _document = [[FLStringDocument alloc] init];
        _document.rootStringBuilder.parent = self;
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

- (void) stringFormatterAppendEOL:(FLStringFormatter*) stringFormatter {
    [[self openedSection] endLine];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string {
    [[self openedSection] appendString:string];
}            

- (NSString*) stringFormatterGetString:(FLStringFormatter*) stringFormatter {
    return [[self openedSection] string];
}

- (FLDocumentSection*) openedSection {
    return [_document openedStringBuilder];
}

- (void) appendLinesToPrettyString:(FLPrettyString*) prettyString {
    [_document.rootStringBuilder appendLinesToPrettyString:prettyString];
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

- (void) stringFormatterDeleteAllCharacters:(FLStringFormatter*) stringFormatter {
    [self.document deleteAllStringBuilders];
}

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
}


@end