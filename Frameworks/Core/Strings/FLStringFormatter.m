//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"
#import "NSArray+FLExtras.h"

@implementation FLStringFormatter

@synthesize delegate = _delegate;

- (void) appendString:(NSString*) string {
    FLAssertNotNil_(string);
    
    _editingLine = YES;
    [self.delegate stringFormatter:self appendString:string];
}

- (void) endLine {
    if(_editingLine) {
        [self.delegate stringFormatterAppendEOL:self];
        _editingLine = NO;
    }
}

- (void) endLine:(NSString*) string {
    FLAssertNotNil_(string);

    [self appendString:string];
    [self endLine];
}

- (void) startLine {
    [self endLine];
    _editingLine = YES;
}

- (void) startLine:(NSString*) string {
    FLAssertNotNil_(string);

    [self endLine];
    if(FLStringIsNotEmpty(string)) {
        [self startLine];
        [self appendString:string];
    }
}

- (void) appendLine:(NSString*) line {
    FLAssertNotNil_(line);

    [self endLine];
    [self startLine:line];
    [self endLine];
}

- (void) appendBlankLine {
    [self endLine];
    [self startLine];
    [self endLine];
}

- (void) appendLines:(NSString**) lines count:(NSInteger) count{
    FLAssertNotNil_(lines);
    for(int i = 0; i < count; i++) {
        [self appendLine:lines[i]];
    }
}

- (void) appendLines:(NSString**) lines {
    FLAssertNotNil_(lines);
    [self appendLines:lines count:FLArrayLength(lines, NSString*)];
}

- (void) appendLinesWithArray:(NSArray*) lines {
    FLAssertNotNil_(lines);
    for(NSString* line in lines) {
        [self appendLine:line];
    }
}

- (void) appendFormat:(NSString*) format, ... {
    FLAssertNotNil_(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
    _editingLine = YES;
    [self appendString:string];
}

- (void) appendLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil_(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self appendLine:string];
}

- (void) startLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil_(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self startLine:string];
}

- (void) endLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil_(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self endLine:string];
}

- (NSString*) description {
    return [self string];
}

- (NSString*) string {
    return [self.delegate stringFormatterGetString:self];
}

- (NSString*) _preprocessLines:(NSString*) lines {
	NSString* string = [lines stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return string;
}

- (void) appendStringContainingMultipleLines:(NSString*) inLines trimWhitespace:(BOOL) trimWhitespace {
    FLAssertNotNil_(inLines);

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

- (void) appendStringContainingMultipleLines:(NSString*) inLines {

//    BOOL inLine = NO;
//    NSRange lineRange = { 0, 0 };
//    for(NSUInteger i = 0; i < inLines.count; i++) {
//        unichar c = [inLines characterAtIndex:i];
//        BOOL isWhitespace = [[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:c];
//        
//        if(inLine) {
//            if(isWhiteSpace) {
//                [self appendLine:[inLines substringWithRange:lineRange]];
//                inLine = NO;
//            }
//            else {
//                lineRange.length++;
//            }
//        }
//        else if(!isWhitespace) {
//            lineRange.location = i
//            lineRange.length = 1;
//            inLine = YES;
//        }
//    }

    [self appendStringContainingMultipleLines:inLines trimWhitespace:YES];

}

- (void) deleteAllCharacters {
    [self.delegate stringFormatterDeleteAllCharacters:self];
}  

- (void) indent {
    [self.delegate stringFormatterIndent:self];
}

- (void) outdent {
    [self.delegate stringFormatterOutdent:self];
}

- (void) indent:(void (^)()) block {
    [self endLine];
    [self indent];
    block();
    [self endLine];
    [self outdent];
}
@end
