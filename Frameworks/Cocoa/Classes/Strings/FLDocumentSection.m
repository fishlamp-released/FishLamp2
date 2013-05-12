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
//@property (readwrite, strong, nonatomic) NSMutableString* openLine;
@end

@implementation NSString (FLDocumentSection)
- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [stringFormatter appendLine:self];
}
@end

@interface FLDocumentSectionIndent : NSObject<FLBuildableString>
+ (id) documentSectionIndent;
@end

@interface FLDocumentSectionOutdent : NSObject<FLBuildableString>
+ (id) documentSectionOutdent;
@end

@implementation FLDocumentSectionIndent
+ (id) documentSectionIndent {
    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));
}
- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [stringFormatter indent];
}
- (NSString*) description {
    return @"INDENT";
}


@end

@implementation FLDocumentSectionOutdent
+ (id) documentSectionOutdent {
    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));
}
- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [stringFormatter outdent];
}
- (NSString*) description {
    return @"OUTDENT";
}

@end


@implementation FLDocumentSection 

@synthesize lines = _lines;
@synthesize parent = _parent;

- (id) init {
    self = [super init];
    if(self) {
        _lines = [[NSMutableArray alloc] init];
        self.stringFormatterOutput = self;
    }    
    return self;
}

+ (id) stringBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_lines release];
    [super dealloc];
}
#endif

- (id) lastLine {
    FLAssertNotNil([_lines lastObject]);
    return [_lines lastObject];
}

- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter {
    [_lines addObject:@""];
}

- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter {
    _needsLine = YES;    
}

- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter {
    _needsLine = YES;    
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string {
    if(_needsLine) {
        [_lines addObject:FLAutorelease([string mutableCopy])];
        _needsLine = NO;
    }
    else {
        FLAssert([self.lastLine isKindOfClass:[NSMutableString class]]);
        [self.lastLine appendString:string];
    }

}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString {
    [self stringFormatter:stringFormatter appendString:attributedString.string];
}

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
    [_lines addObject:[FLDocumentSectionIndent documentSectionIndent]];
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
    [_lines addObject:[FLDocumentSectionOutdent documentSectionOutdent]];
}


//- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
//            appendString:(NSString*) string
//  appendAttributedString:(NSAttributedString*) attributedString
//              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {
//
//// NOTE: we're ignoring lineUpdate.openLine and closeLine since our lines are
//// in an array. 
//    
//    if(lineUpdate.prependBlankLine) {
//        [_lines addObject:@""];
//    }
//    
//    if(attributedString) {
//        string = attributedString.string;
//    }
//    
//    FLAssertNotNil(string);
//    
//    if(lineUpdate.openLine || _needsLine) {
//        [_lines addObject:FLAutorelease([string mutableCopy])];
//        _needsLine = NO;
//    }
//    else if(string) {
//        FLAssert([self.lastLine isKindOfClass:[NSMutableString class]]);
//        [self.lastLine appendString:string];
//    }
//    
//}            

- (NSString*) description {
    FLPrettyString* str = [FLPrettyString prettyString];
    [str appendBuildableString:self];
    return str.string;
}

- (void) willBuildWithStringFormatter:(id<FLStringFormatter>) stringFormatter {
}

- (void) didBuildWithStringFormatter:(id<FLStringFormatter>) stringFormatter {
}

- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter {

    [self willBuildWithStringFormatter:stringFormatter];

    for(id<FLBuildableString> line in _lines) {
        [line buildStringIntoStringFormatter:stringFormatter];
    }

    [self didBuildWithStringFormatter:stringFormatter];
}

- (void) addStringBuilder:(FLDocumentSection*) stringBuilder {
    [_lines addObject:stringBuilder];
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

- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter {
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