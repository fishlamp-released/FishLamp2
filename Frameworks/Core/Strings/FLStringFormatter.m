//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"

@implementation FLStringFormatter

@synthesize delegate = _delegate;

- (void) appendString:(NSString*) string {
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
    [self appendString:string];
    [self endLine];
}

- (void) startLine {
    [self endLine];
    _editingLine = YES;
}

- (void) startLine:(NSString*) string {
    [self endLine];
    if(FLStringIsNotEmpty(string)) {
        [self startLine];
        [self appendString:string];
    }
}

- (void) appendLine:(NSString*) line {
    [self endLine];
    [self startLine:line];
    [self endLine];
}

- (void) appendBlankLine {
    [self endLine];
    [self startLine];
    [self endLine];
}

- (void) appendLines:(NSString**) lines {
    if(lines) {
        for(int i = 0; i < (sizeof(lines) / sizeof(NSString*)); i++) {
            [self appendLine:lines[i]];
        }
    }
}

- (void) appendLinesWithArray:(NSArray*) lines {
    for(NSString* line in lines) {
        [self appendLine:line];
    }
}

- (void) appendFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
    _editingLine = YES;
    [self appendString:string];
}

- (void) appendLineWithFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self appendLine:string];
}

- (void) startLineWithFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self startLine:string];
}

- (void) endLineWithFormat:(NSString*) format, ... {
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
  
@end
