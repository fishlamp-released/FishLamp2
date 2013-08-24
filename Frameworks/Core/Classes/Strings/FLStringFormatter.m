//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStringFormatter.h"
#import "FLAssertions.h"
#import "NSArray+FLExtras.h"

/*
/// concrete base class.
*/
@interface FLStringFormatter ()
- (void) openLine;
@end


@implementation FLStringFormatter

@synthesize stringFormatterOutput = _output;
@synthesize parent = _parent;
@synthesize lineIsOpen = _editingLine;

- (void) processAndAppendAttributedString:(NSAttributedString*) string {

    // TODO

    [_output stringFormatter:self appendAttributedString:string];

}

- (void) processAndAppendString:(NSString*) string {

    NSRange range = { 0, 0 };
    
    for(NSUInteger i = 0; i < string.length; i++) {
        unichar c = [string characterAtIndex:i];
        
        if(c == '\n') {
            if(range.length > 0) {
                [self openLine];
                [_output stringFormatter:self appendString:[string substringWithRange:range]];
                [self closeLine];
            }
            
            range.location = i+1;
            range.length = 0;
            
            continue;
        }

        ++range.length;
    }
    
    if(range.length) {
        [self openLine];
            
        if(range.location > 0) {
            [_output stringFormatter:self appendString:[string substringWithRange:range]];
        }
        else {
            [_output stringFormatter:self appendString:string];
        }
    }
}

- (void) appendString:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    [self openLine];
    [self processAndAppendString:string];
}


- (void) appendAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    [self openLine];
    [self processAndAppendAttributedString:string];
}


- (void) openLine {
    FLAssertNotNil(_output);

    if(!_editingLine) {
        _editingLine = YES;
        [_output stringFormatterOpenLine:self];
    }
}

- (void) closeLine {

    FLAssertNotNil(_output);

    if(_editingLine) {
        [_output stringFormatterCloseLine:self];
        _editingLine = NO;
    }
}

- (void) closeLineWithString:(NSString*) string {
    FLAssertNotNil(_output);

    if(string) {
        [self openLine];
        [self processAndAppendString:string];
    }

    [self closeLine];
}

- (void) closeLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(_output);

    if(string) {
        [self openLine];
        [self processAndAppendAttributedString:string];
    }

    [self closeLine];
}

#define openLineInfo() MakeInfo(_editingLine, NO, YES, NO)

- (void) openLineWithString:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    [self closeLine];
    [self openLine];
    [self processAndAppendString:string];
}


- (void) openLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    [self closeLine];
    [self openLine];
    [self processAndAppendAttributedString:string];
}

#define appendLineInfo() MakeInfo(NO, NO, !_editingLine, YES)

- (void) appendLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    [self openLine];
    [self processAndAppendAttributedString:string];
    [self closeLine];
}


- (void) appendLine:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    [self openLine];
    [self processAndAppendString:string];
    [self closeLine];
    
}

- (void) appendBlankLine {
    FLAssertNotNil(_output);
     
    [self closeLine];                                       
    // intentionally not opening line
    [_output stringFormatterAppendBlankLine:self];
}

- (void) appendLines:(NSString**) lines 
               count:(NSInteger) count{
    FLAssertNotNil(lines);
        if(lines) {for(int i = 0; i < count; i++) {
            [self appendLine:lines[i]];
        }
    }
}

- (void) appendLines:(NSString**) lines {
    FLAssertNotNil(lines);
    [self appendLines:lines count:FLArrayLength(lines, NSString*)];
}

- (void) appendLinesWithArray:(NSArray*) lines {
    FLAssertNotNil(lines);
    for(NSString* line in lines) {
        [self appendLine:line];
    }
}

- (void) appendFormat:(NSString*) format, ... {
    FLAssertNotNil(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
    [self appendString:string];
}

- (void) appendFormat:(NSString*) format 
            arguments:(va_list)argList {
	[self appendString:FLAutorelease([[NSString alloc] initWithFormat:format arguments:argList])];
}


- (void) appendLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self appendLine:string];
}

- (void) appendLineWithFormat:(NSString*) format arguments:(va_list)argList {
	[self appendLine:FLAutorelease([[NSString alloc] initWithFormat:format arguments:argList])];
}

- (void) openLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self openLineWithString:string];
}

- (void) closeLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self closeLineWithString:string];
}

- (NSString*) _preprocessLines:(NSString*) lines {
	NSString* string = [lines stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return string;
}

- (void) appendStringContainingMultipleLines:(NSString*) inLines 
                              trimWhitespace:(BOOL) trimWhitespace {
    FLAssertNotNil(inLines);

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
    [self appendStringContainingMultipleLines:inLines trimWhitespace:YES];
}

- (void) indent {
    [_output stringFormatterIndent:self];
}

- (void) outdent {
    [_output stringFormatterOutdent:self];
}

- (void) indent:(FLStringFormatterBlock) block {
    [self closeLine];
    [_output stringFormatterIndent:self];
    // subsequent calls to us will open a line, etc..
    block();
    [self closeLine]; // just in case.
    [_output stringFormatterOutdent:self];
}

- (void) appendInScope:(NSString*) openScope closeScope:(NSString*) closeScope withBlock:(FLStringFormatterBlock) block {
    [self appendLine:openScope];
    [self indent:block];
    [self appendLine:closeScope];
}

- (void) setParent:(id) parent {
    _parent = parent;
    [self didMoveToParent:_parent];
}

- (void) didMoveToParent:(id) parent {
}

- (void) appendSelfToStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [_output stringFormatter:self appendSelfToStringFormatter:stringFormatter];
}

- (void) appendStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [stringFormatter appendSelfToStringFormatter:self];
}

- (NSUInteger) length {
    return [_output stringFormatterGetLength:self];
}

- (BOOL) isEmpty {
    return self.length == 0;
}

@end
