//
//  FLStringBuilderContents.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringBuilder.h"

@implementation FLStringBuilder

@synthesize tokens = _tokens;
@synthesize cursor = _cursor;
@synthesize header = _header;
@synthesize footer = _footer;

- (id) initAsCopy:(FLStringBuilder*) original {
    self = [self init];
    if(self) {
        _tokens = [original.tokens mutableCopy];
        _header = [original.header copy];
        _footer = [original.footer copy];
        _cursor = original.cursor;
    }
    return self;
}

- (id) init {
    self = [super init];
    if(self) {
        _tokens = [NSMutableArray array];
    }
    return self;
}

+ (id) stringBuilder {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_tokens release];
    [_header release];
    [_footer release];
    [super dealloc];
}
#endif

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initAsCopy:self];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if(_header) {
        [aCoder encodeObject:_tokens forKey:@"_header"];
    }
    [aCoder encodeObject:_tokens forKey:@"_tokens"];
    if(_footer) {
        [aCoder encodeObject:_tokens forKey:@"_footer"];
    }
    [aCoder encodeInteger:_cursor forKey:@"_cursor"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        _header = [aDecoder decodeObjectForKey:@"_header"];
        _tokens = [aDecoder decodeObjectForKey:@"_tokens"];
        _footer = [aDecoder decodeObjectForKey:@"_footer"];
        _cursor = [aDecoder decodeIntegerForKey:@"_cursor"];
    }
    return self;
}

- (void) willBuildString {
}

- (void) didBuildString {
}

- (BOOL) shouldBuildString {
    return !self.isEmpty;
}

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
   
    if([self shouldBuildString]) {
        [self willBuildString];
        
        if(_header) {
            [_header appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
        }

        (*tabIndent)++;
        
        for(id object in _tokens) {
            [object appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
        }

        (*tabIndent)--;
        
        if(_footer) {
            [_footer appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
        }
        
        [self didBuildString];
    }
   
}

- (NSString*) _preprocessLines:(NSString*) lines {
	NSString* string = [lines stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return string;
}

- (void) appendLines:(NSString*) inLines trimWhitespace:(BOOL) trimWhitespace {
	NSString* string = trimWhitespace ? [self _preprocessLines:inLines] : inLines;
	if(FLStringIsNotEmpty(string)) {
		NSArray* lines = [string componentsSeparatedByString:@"\n"];
		for(NSString* line in lines) {
			NSString* newline = trimWhitespace ? [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : line;
		
			if(FLStringIsNotEmpty(newline)) {
				[self appendLine:newline];
            }
		}
	}
}

- (BOOL) isEmpty {
    return !_tokens || _tokens.count == 0;
}

- (NSUInteger) tokenCount {
    return _tokens.count;
}

- (id) tokenAtIndex:(NSUInteger) index {
    return [_tokens objectAtIndex:index];
}

- (void) replaceTokenAtIndex:(NSUInteger) index withToken:(id) token {
    [_tokens replaceObjectAtIndex:index withObject:token];
}

- (void) moveCurserToEnd {
    _cursor = _tokens.count;
}

- (void) moveCursorToBeginning {
    _cursor = 0;
}

- (void) appendToken:(id) token {
    [_tokens insertObject:token atIndex:_cursor++];
}

- (void) append:(FLStringBuilder*) builder {
    [self appendToken:builder];
}

- (void) indent {
    [self appendToken:[FLIndentToken indentToken]];
}

- (void) appendIndentedBlock:(void (^)()) indentedBlock {
    [self indent];
    if(indentedBlock) {
        indentedBlock();
    }
    [self outdent];
}

- (void) outdent {
    [self appendToken:[FLOutdentToken outdentToken]];
}

- (void) insertBuilderContents:(FLStringBuilder*) builder {
  	for(id contentItem in builder.tokens) {
        [self appendToken:contentItem];
    }
}

- (void) appendLine {
    [self appendToken:[FLEolToken eolToken]];
}

- (void) appendString:(NSString*) string {
    [self appendToken:string];
}

- (void) appendLine:(NSString*) line {
    [self appendString:line];
    [self appendLine];
}

- (void) appendFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = FLReturnAutoreleased([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
    [self appendString:string];
}

- (void) appendLineWithFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = FLReturnAutoreleased([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self appendLine:string];
}

- (BOOL) isLastToken:(id) token {
    return [self.tokens lastObject] == token;
}

- (id) lastToken {
    return [self.tokens lastObject];
}

- (void) insertToken:(id) token beforeToken:(id) beforeToken {

    for(NSInteger i = _tokens.count - 1; i >= 0; i--) {
        if(beforeToken == [_tokens objectAtIndex:i]) {
            [_tokens insertObject:token atIndex: MAX(i - 1, 0)];
            break;
        }
    }
}

- (void) insertToken:(id) token atIndex:(NSUInteger) atIndex {
    [_tokens insertObject:token atIndex:atIndex];
}

- (void) pushToken:(id) token {
    [_tokens insertObject:token atIndex:0];
}

- (void) visitTokens:(void (^)(id token, BOOL* stop)) visitor {
    
    BOOL stop = NO;
    for(id token in _tokens.reverseObjectEnumerator) {
    
        visitor(token, &stop);
        
        if(stop) {
            break;
        }
    }
}

- (FLEolToken*) lastEolToken {
    for(id token in _tokens.reverseObjectEnumerator) {

        if([token isKindOfClass:[FLEolToken class]]) {
            return token;
        }
    }

    return nil;
}

- (void) removeToken:(id) token {
    [_tokens removeObject:token];
}

- (void) removeAllTokens {
    [_tokens removeAllObjects];
}

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace {
    
    NSMutableString* string = [NSMutableString string];
    NSInteger tabIndent = -1;
    [self appendSelfToString:string whitespace:whitespace tabIndent:&tabIndent];
    
    return string;
}

- (NSString*) buildString {
    return [self buildStringWithWhitespace:[FLWhitespace tabbedFormat]];
}

- (NSString*) buildStringWithNoWhitespace {
    return [self buildStringWithWhitespace:nil];
}

- (NSString*) description {
    return [self buildString];
}

@end


