//
//  FLPrettyString.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPrettyString.h"
#import "FLAssertions.h"
#import "FLWhitespace.h"
#import "FLSelectorPerforming.h"

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
        self.stringFormatterOutput = self;
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

#if FL_MRC
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

- (void) appendPrettyString:(FLPrettyString*) string {
    [self appendStringContainingMultipleLines:string.string];
}

- (void) deleteAllCharacters {
    [_storage deleteCharactersInRange:NSMakeRange(0, [_storage length])];
}

- (void) appendEOL {
    if(_eolString) { 
        [self appendStringToStorage:_eolString];
    } 
}

- (NSString*) description {
    return [self string];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter
appendSelfToStringFormatter:(id<FLStringFormatter>) anotherStringFormatter {
    [anotherStringFormatter appendString:self.string];
}

- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter {
    if(_whitespace) { 
        [self appendStringToStorage:[_whitespace tabStringForScope:self.indentLevel]];
    } 
}
- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter {
    [self appendEOL];
}

- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter {
    [self appendEOL];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string {
    [self appendStringToStorage:string];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString {
    [self appendAttributedStringToStorage:attributedString];
}

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
    ++_indentLevel;
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
    --_indentLevel;
}

- (NSUInteger) stringFormatterGetLength:(FLStringFormatter*) stringFormatter {
    return [_storage length];
}




@end

@implementation NSObject (FLPrettyString)

- (void) describeToString:(FLPrettyString*) string {
    [string appendInScope:[NSString stringWithFormat:@"%@ {", NSStringFromClass([self class])] 
               closeScope:@"}"
                withBlock:^{
                    [self describeSelf:string];
                }]; 
}

- (NSString*) prettyDescription {
    FLPrettyString* str = [FLPrettyString prettyString];
    [self describeToString:str];
    return [str string];
}

- (void) prettyDescription:(FLPrettyString*) string {
    [string indent: ^{
        [self describeSelf:string];
    }];
}

- (void) describeSelf:(FLPrettyString*) string {
    [string appendLine:[self description]];
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

    NSAttributedString* stringToAppend = FLRetainWithAutorelease(string);

    if([self.delegate respondsToSelector:@selector(prettyString:willAppendAttributedString:)]) {
        stringToAppend = [((id)self.delegate) prettyString:self willAppendAttributedString:string];
    }

    [[self storage] appendAttributedString:stringToAppend];
    
    FLPerformSelector2(self.delegate, @selector(prettyString:didAppendAttributedString:), self, stringToAppend); 
}
           
//- (void) appendPrettyString:(FLPrettyString*) string {
//    [self appendStringContainingMultipleLines:string.string];
//}

@end

