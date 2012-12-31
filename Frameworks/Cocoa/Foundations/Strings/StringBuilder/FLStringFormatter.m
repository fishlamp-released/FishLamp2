//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"

@implementation FLStringFormatter

@synthesize tabIndent = _tabIndent;

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

- (void) appendLine {
}

- (void) appendString:(NSString*) string {
}

- (void) appendLine:(NSString*) line {
    [self appendString:line];
    [self appendLine];
}

- (void) appendFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
    [self appendString:string];
}

- (void) appendLineWithFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self appendLine:string];
}

- (void) indent {
    ++_tabIndent;
}

- (void) outdent {
    --_tabIndent;
}

- (void) indent:(void (^)()) block {
    [self appendLine];
    [self indent];
    block();
    [self appendLine];
    [self outdent];
}

- (void) appendLine:(NSString*) line 
      withTabIndent:(NSInteger) tabIndent {
    
    self.tabIndent += tabIndent;
    [self appendLine:line];
    self.tabIndent -= tabIndent;
}
      
@end
