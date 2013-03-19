//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"
#import "NSArray+FLExtras.h"

NS_INLINE
FLStringFormatterLineUpdate MakeInfo(BOOL closePreviousLine, 
                                   BOOL prependBlankLine, 
                                   BOOL openLine, 
                                   BOOL closeLine) {
                                   
    FLStringFormatterLineUpdate info = { 
        closePreviousLine, 
        prependBlankLine, 
        openLine, 
        closeLine }; 

    return info; 
}

#define str_or_nil(str) (str == nil || str.length == 0) ? nil : str
#define closeLineInfo() MakeInfo(_editingLine, NO, NO, NO)
#define openLineInfo() MakeInfo(_editingLine, NO, YES, NO)
#define appendLineInfo() MakeInfo(NO, NO, !_editingLine, YES)
#define appendStringInfo() MakeInfo(NO, NO, !_editingLine, NO)

@implementation FLStringFormatter

- (void) appendString:(NSString*) string {
    FLAssertNotNil_(string);
    
    [self stringFormatter:self 
                      appendString:string
            appendAttributedString:nil
                        lineUpdate:appendStringInfo()];
        
    _editingLine = YES;
}


- (void) appendAttributedString:(NSAttributedString*) string {
    FLAssertNotNil_(string);
    
    [self stringFormatter:self 
                      appendString:nil
            appendAttributedString:str_or_nil(string)
                        lineUpdate:appendStringInfo()];
        
    _editingLine = YES;
}


- (void) closeLine {
    if(_editingLine) {
        [self stringFormatter:self 
                          appendString:nil
                appendAttributedString:nil
                            lineUpdate:closeLineInfo()];
    }
    _editingLine = NO;
}

- (void) closeLineWithString:(NSString*) string {
    if(_editingLine) {
        [self stringFormatter:self 
                          appendString:str_or_nil(string)
                appendAttributedString:nil
                            lineUpdate:closeLineInfo()];
    }
    _editingLine = NO;
}

- (void) closeLineWithAttributedString:(NSAttributedString*) string {
    if(_editingLine) {
        [self stringFormatter:self 
                          appendString:nil
                appendAttributedString:str_or_nil(string)
                            lineUpdate:closeLineInfo()];
    }
    _editingLine = NO;
}

- (void) openLineWithString:(NSString*) string {
    FLAssertNotNil_(string);
    [self stringFormatter:self 
                      appendString:str_or_nil(string)
            appendAttributedString:nil
                        lineUpdate:openLineInfo()];
                      

    _editingLine = YES;
}


- (void) openLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil_(string);
    [self stringFormatter:self 
                      appendString:nil
            appendAttributedString:str_or_nil(string)
                        lineUpdate:openLineInfo()];
                      

    _editingLine = YES;
}


- (void) appendLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil_(string);
    [self stringFormatter:self 
                      appendString:nil
            appendAttributedString:str_or_nil(string)
                        lineUpdate:appendLineInfo()];
                      

    _editingLine = NO;
}


- (void) appendLine:(NSString*) string {
    FLAssertNotNil_(string);
    
    [self stringFormatter:self 
                      appendString:str_or_nil(string)
            appendAttributedString:nil
                        lineUpdate:appendLineInfo()];

    _editingLine = NO;
}

- (void) appendBlankLine {
    [self stringFormatter:self 
                      appendString:nil
            appendAttributedString:nil
                        lineUpdate:MakeInfo(_editingLine, YES, NO, NO)];
    _editingLine = NO;
}

- (void) appendLines:(NSString**) lines count:(NSInteger) count{
    FLAssertNotNil_(lines);
        if(lines) {for(int i = 0; i < count; i++) {
            [self appendLine:lines[i]];
        }
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

- (void) openLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil_(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self openLineWithString:string];
}

- (void) closeLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil_(format);
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

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string
  appendAttributedString:(NSAttributedString*) attributedString
              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {
              
}              

- (void) indent {
}

- (void) outdent {
}

- (void) indent:(void (^)()) block {
    if(_editingLine) {
        [self closeLine];
    }
    [self indent];
    block();
    if(_editingLine) {
        [self closeLine];
    }
    [self outdent];
}
@end
