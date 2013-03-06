//
//  FLPrettyString.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPrettyString.h"
#import "NSObject+FLSelectorPerforming.h"

@interface FLPrettyString ()
@property (readwrite, strong, nonatomic) id storage;
@property (readwrite, strong, nonatomic) id eolString;
@property (readwrite, strong, nonatomic) FLWhitespace* whitespace;
@end

@implementation FLPrettyString

@synthesize storage = _storage;
@synthesize whitespace = _whitespace;
@synthesize eolString = _eolString;
@synthesize indentLevel = _indentLevel;
@synthesize delegate = _delegate;

+ (FLWhitespace*) defaultWhitespace {
    return [FLWhitespace tabbedWithSpacesWhitespace];
}

- (NSString*) string {
    return _storage;
}

- (id) initWithWhitespace:(FLWhitespace*) whitespace withStorage:(id) storage {
    self = [super init];
    if(self) {
        self.whitespace = whitespace;
        self.eolString = _whitespace ? _whitespace.eolString : @"";
        self.storage = storage;
    }
    return self;
}

- (id) initWithWhitespace:(FLWhitespace*) whitespace {
    return [self initWithWhitespace:whitespace withStorage:[NSMutableString string]];
}

- (id) init {
    return [self initWithWhitespace:[FLPrettyString defaultWhitespace]];
}

+ (id) prettyString:(FLWhitespace*) whitespace {
    return FLAutorelease([[[self class] alloc] initWithWhitespace:whitespace]);
}

+ (id) prettyString {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) prettyStringWithString:(NSString*) string {
    FLPrettyString* prettyString = FLAutorelease([[[self class] alloc] init]);
    [prettyString appendString:string];
    return prettyString;
}

- (NSUInteger) length {
    return [_storage length];
}

#if FL_DEALLOC
- (void) dealloc {
    [_eolString release];
    [_whitespace release];
    [_storage release];
    [super dealloc];
}
#endif

- (void) appendStringToStorage:(NSString*) string {
    [_storage appendString:string];
    FLPerformSelector2(self, @selector(prettyString:didAppendString:), self, string); 
}

- (void) appendAttributedStringToStorage:(NSAttributedString*) string {
    [self appendStringToStorage:[string string]];
}

- (void) appendEOL {
    if(_eolString) { 
        [self appendStringToStorage:_eolString];
    } 
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string
  appendAttributedString:(NSAttributedString*) attributedString
              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {


    if(lineUpdate.closePreviousLine) {
        [self appendEOL];
    }

    if(lineUpdate.prependBlankLine) {
        [self appendEOL];
    }

    if(lineUpdate.openLine) {
        if(_whitespace) { 
            [self appendStringToStorage:[_whitespace tabStringForScope:self.indentLevel]];
        } 
    }
    
    if(string) {
        [self appendStringToStorage:string];
    }
    
    if(attributedString) {
        [self appendAttributedStringToStorage:attributedString];
    }
    
    if(lineUpdate.closeLine) {
        [self appendEOL];
    }
}            

- (void) appendPrettyString:(FLPrettyString*) string {
    [self appendStringContainingMultipleLines:string.string];
}

- (void) deleteAllCharacters {
    [_storage deleteCharactersInRange:NSMakeRange(0, [_storage length])];
}

- (void) appendBuildableString:(id<FLBuildableString>) buildableString {
    [buildableString appendLinesToStringFormatter:self];
}

- (NSString*) description {
    return [self string];
}

- (void) indent {
    ++_indentLevel;
}

- (void) outdent {
    --_indentLevel;
}



@end

@implementation NSObject (FLPrettyString)

- (void) describe:(FLPrettyString*) formatter {
    [formatter appendLine:[self description]];
}

- (NSString*) prettyDescription {
    FLPrettyString* str = [FLPrettyString prettyString];
    [self describe:str];
    return [str string];
}

@end


@interface FLPrettyAttributedString ()
@end

@implementation FLPrettyAttributedString

- (id) initWithWhitespace:(FLWhitespace*) whitespace withStorage:(id) storage {
    self = [super initWithWhitespace:whitespace withStorage:storage];
    if(self) {
        if(self.eolString) {
            self.eolString = FLAutorelease([[NSAttributedString alloc] initWithString:self.eolString]);
        }
    }
    return self;
}

- (id) initWithWhitespace:(FLWhitespace*) whitespace {
    return [self initWithWhitespace:whitespace withStorage:FLAutorelease([[NSMutableAttributedString alloc] init])];
}

- (NSString*) string {
    return [[self storage] string];
}

- (NSAttributedString*) attributedString {
    return [self storage];
}

- (void) appendEOL {
    if(self.eolString) { 
        [self appendAttributedStringToStorage:self.eolString];
    } 
}

- (void) appendStringToStorage:(NSString*) string {
    [self appendAttributedStringToStorage:FLAutorelease([[NSAttributedString alloc] initWithString:string])];
}

- (void) appendAttributedStringToStorage:(NSAttributedString*) string {
    [[self storage] appendAttributedString:string];
    FLPerformSelector2(self.delegate, @selector(prettyString:didAppendAttributedString:), self, string); 
}
           
- (void) appendPrettyString:(FLPrettyString*) string {
    [self appendStringContainingMultipleLines:string.string];
}

@end
