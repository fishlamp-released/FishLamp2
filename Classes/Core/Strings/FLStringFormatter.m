//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStringFormatter.h"
#import "NSArray+FLExtras.h"

/*
/// concrete base class.
*/


@implementation FLStringFormatter

@synthesize stringFormatterOutput = _output;

- (void) appendString:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    if(!_editingLine) {
        _editingLine = YES;
        [_output stringFormatterOpenLine:self];
    }
    [_output stringFormatter:self appendString:string];
    
}


- (void) appendAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    if(!_editingLine) {
        _editingLine = YES;
        [_output stringFormatterOpenLine:self];
    }
    
    [_output stringFormatter:self appendAttributedString:string];
}


- (void) closeLine {

    FLAssertNotNil(_output);

    if(_editingLine) {
        [_output stringFormatterCloseLine:self];
    }
    _editingLine = NO;
}

- (void) closeLineWithString:(NSString*) string {
    FLAssertNotNil(_output);

    if(_editingLine) {
    
        if(string) {
            [_output stringFormatter:self appendString:string];
        }

        if(_editingLine) {
            [_output stringFormatterCloseLine:self];
        }
    }
    _editingLine = NO;
}

- (void) closeLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(_output);

    if(_editingLine) {

        if(string) {
            [_output stringFormatter:self appendAttributedString:string];
        }

        if(_editingLine) {
            [_output  stringFormatterCloseLine:self];
        }
    }
    _editingLine = NO;
}

#define openLineInfo() MakeInfo(_editingLine, NO, YES, NO)

- (void) openLineWithString:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    if(_editingLine) {
        [_output  stringFormatterCloseLine:self];
    }
    
    _editingLine = YES;
    [_output stringFormatterOpenLine:self];
    [_output stringFormatter:self appendString:string];
}


- (void) openLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    if(_editingLine) {
        [_output  stringFormatterCloseLine:self];
    }
    
    _editingLine = YES;
    [_output stringFormatterOpenLine:self];
    [_output stringFormatter:self appendAttributedString:string];
}

#define appendLineInfo() MakeInfo(NO, NO, !_editingLine, YES)

- (void) appendLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    if(!_editingLine) {
        _editingLine = YES;
        [_output stringFormatterOpenLine:self];
    }
    [_output stringFormatter:self appendAttributedString:FLRetainWithAutorelease(string)];
    [_output  stringFormatterCloseLine:self];
    _editingLine = NO;
}


- (void) appendLine:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    if(!_editingLine) {
        _editingLine = YES;
        [_output stringFormatterOpenLine:self];
    }
    [_output stringFormatter:self appendString:string];
    [_output  stringFormatterCloseLine:self];
    _editingLine = NO;
}

- (void) appendBlankLine {
    FLAssertNotNil(_output);
                        
    if(_editingLine) {
        [_output  stringFormatterCloseLine:self];
        _editingLine = NO;
    }
    
    [_output stringFormatterAppendBlankLine:self];
                        
}

- (void) appendLines:(NSString**) lines count:(NSInteger) count{
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

- (void) appendFormat:(NSString*) format arguments:(va_list)argList {
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

- (void) appendStringContainingMultipleLines:(NSString*) inLines trimWhitespace:(BOOL) trimWhitespace {
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

- (void) indent:(void (^)()) block {
    if(_editingLine) {
        [_output  stringFormatterCloseLine:self];
    }
    [_output stringFormatterIndent:self];
    block();
    if(_editingLine) {
        [_output  stringFormatterCloseLine:self];
    }
    [_output stringFormatterOutdent:self];
}
@end
