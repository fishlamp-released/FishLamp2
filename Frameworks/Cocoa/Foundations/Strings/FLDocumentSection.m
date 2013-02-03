//
//  FLDocumentSection.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDocumentSection.h"
#import "FLWhitespace.h"

@interface FLDocumentSection ()
@property (readwrite, strong, nonatomic) NSMutableString* openLine;
@end

@implementation NSString (FLDocumentSection)
- (void) appendLinesToPrettyString:(FLPrettyString*) prettyString {
    [prettyString appendLine:self];
}
@end

@implementation FLDocumentSection 

@synthesize lines = _lines;
@synthesize parent = _parent;
@synthesize openLine = _openLine;

- (id) init {
    self = [super init];
    if(self) {
        _needsLine = YES;
        _lines = [[NSMutableArray alloc] init];
        self.delegate = self;
    }    
    return self;
}

+ (id) stringBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_openLine release];
    [_lines release];
    [super dealloc];
}
#endif

- (id) lastLine {
    FLAssertNotNil_([_lines lastObject]);
    return [_lines lastObject];
}

- (void) stringFormatterAppendEOL:(FLStringFormatter*) stringFormatter {
    _needsLine = YES;
}

- (void) startNewLine:(id) line {
    NSMutableString* openLine = self.openLine;
    if(openLine) {
        [self willCloseLine:openLine];
        self.openLine = nil;
    }
    [_lines addObject:line];
}

- (void) appendBlankLine {
    [super appendBlankLine];
    _needsLine = YES;
}

- (NSMutableString*) willOpenLine {
    return [NSMutableString string];
}

- (void) willCloseLine:(NSMutableString*) line {

}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string {
    
    if(_needsLine) {
        NSMutableString* newOpenLine = [self willOpenLine];
        [self startNewLine:newOpenLine];
        self.openLine = newOpenLine;
        _needsLine = NO;
    }
    
    FLAssert_([self.lastLine isKindOfClass:[NSMutableString class]]);
    
    [self.lastLine appendString:string];
}            

- (NSString*) stringFormatterGetString:(FLStringFormatter*) stringFormatter {
    FLPrettyString* str = [FLPrettyString prettyString];
    [str appendBuildableString:self];
    return str.string;
}

- (id) copyWithZone:(NSZone*) zone {
    FLAssertFailed_v(@"need to implement this");
    return nil;
}

- (void) willBuildWithPrettyString:(FLPrettyString*) prettyString {
}

- (void) didBuildWithPrettyString:(FLPrettyString*) prettyString {
}

- (void) appendLinesToPrettyString:(FLPrettyString*) prettyString {

    [self willBuildWithPrettyString:prettyString];

    for(id<FLBuildableString> line in _lines) {
        [line appendLinesToPrettyString:prettyString];
    }

    [self didBuildWithPrettyString:prettyString];
}

- (void) addStringBuilder:(FLDocumentSection*) stringBuilder {
    [self startNewLine:stringBuilder];
    [stringBuilder setParent:self];
    _needsLine = YES;
}

- (void) setParent:(id) parent {
    _parent = parent;
    [self didMoveToParent:_parent];
}

- (void) didMoveToParent:(id) parent {
}

- (void) stringFormatterDeleteAllCharacters:(FLStringFormatter*) formatter {
    [_lines removeAllObjects];
}

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
}


@end

/*
@interface FLStringBuilderLine : NSObject<NSCopying> {
@private 
    NSMutableString* _string;
    __unsafe_unretained id _parent;
}

+ (id) stringBuilderLine;

@property (readwrite, strong, nonatomic) NSString* string;
@property (readwrite, assign, nonatomic) id parent;
- (void) didMoveToParent:(id) parent;

- (void) appendString:(NSString*) string;
- (void) appendStringToLine:(NSString*) string;
@end

@implementation FLStringBuilderLine 

@synthesize string = _string;
@synthesize parent = _parent;

+ (id) stringBuilderLine {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_string release];
    [super dealloc];
}
#endif

- (void) setString:(NSString*) string {
    FLReleaseWithNil(_string);
    [self appendString:string];
}

- (void) appendString:(NSString*) string {

    if(string && string.length) {
        if(!_string) {
            _string = [string mutableCopy];
        }
        else {
            [_string appendString:string];
        }
    }
}

- (void) appendStringToLine:(NSString*) string {
    [self appendString:string];
}

- (id) copyWithZone:(NSZone *)zone {
    FLStringBuilderLine* line = [[[self class] alloc] init];
    [line appendString:line.string];
    return line;
}

- (void) appendLinesToPrettyString:(FLPrettyString*) prettyString {
    if(FLStringIsNotEmpty(_string)) {
        [prettyString appendLine:_string];
    }
}

- (void) didMoveToParent:(id) parent {
}

- (void) setParent:(id) parent {
    _parent = parent;
    [self didMoveToParent:_parent];
}

- (NSString*) description {
    return FLStringIsEmpty(_string) ? @"\"\"" : [NSString stringWithFormat:@"\"%@\"", _string]; 
}

@end
*/