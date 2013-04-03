//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"
#import "NSArray+FLExtras.h"

/*
/// concrete base class.

/// this describes state of open openLine. Uses one method (stringFormatter:appendString:lineInfo) to allow
/// for optimizations.
typedef struct {
    BOOL closePreviousLine; 
    BOOL prependBlankLine; // closePreviousLine may be YES or NO
    BOOL openLine; // Note: openLine will always have non-empty string if YES.
    BOOL closeLine; // Any of other options may be set
} FLStringFormatterLineUpdate;
// required override
- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string
  appendAttributedString:(NSAttributedString*) string
              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate;
*/

//NS_INLINE
//FLStringFormatterLineUpdate MakeInfo(BOOL closePreviousLine, 
//                                   BOOL prependBlankLine, 
//                                   BOOL openLine, 
//                                   BOOL closeLine) {
//                                   
//    FLStringFormatterLineUpdate info = { 
//        closePreviousLine, 
//        prependBlankLine, 
//        openLine, 
//        closeLine }; 
//
//    return info; 
//}
//
//#define str_or_nil(str) (str == nil || str.length == 0) ? nil : str
//#define closeLineInfo() MakeInfo(_editingLine, NO, NO, NO)
//#define appendStringInfo() MakeInfo(NO, NO, !_editingLine, NO)

@implementation FLStringFormatter

@synthesize stringFormatterOutput = _output;

- (void) appendString:(NSString*) string {
    FLAssertNotNil(string);
    
    if(!_editingLine) {
        [_output stringFormatterOpenLine:self];
    }
    [_output stringFormatter:self appendString:string];
    
//    [self stringFormatter:self 
//                      appendString:string
//            appendAttributedString:nil
//                        lineUpdate:appendStringInfo()];
        
    _editingLine = YES;
}


- (void) appendAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);

    if(!_editingLine) {
        [_output stringFormatterOpenLine:self];
    }
    [_output stringFormatter:self appendAttributedString:string];
    
//    [self stringFormatter:self 
//                      appendString:nil
//            appendAttributedString:str_or_nil(string)
//                        lineUpdate:appendStringInfo()];
        
    _editingLine = YES;
}


- (void) closeLine {
    if(_editingLine) {
        [_output stringFormatterCloseLine:self];
    
//        [self stringFormatter:self 
//                          appendString:nil
//                appendAttributedString:nil
//                            lineUpdate:closeLineInfo()];
    }
    _editingLine = NO;
}

- (void) closeLineWithString:(NSString*) string {
    if(_editingLine) {
    
        if(string) {
            [_output stringFormatter:self appendString:string];
        }

        if(_editingLine) {
            [_output stringFormatterCloseLine:self];
        }
    
//        [self stringFormatter:self 
//                          appendString:str_or_nil(string)
//                appendAttributedString:nil
//                            lineUpdate:closeLineInfo()];
    }
    _editingLine = NO;
}

- (void) closeLineWithAttributedString:(NSAttributedString*) string {
    if(_editingLine) {

        if(string) {
            [_output stringFormatter:self appendAttributedString:string];
        }

        if(_editingLine) {
            [_output  stringFormatterCloseLine:self];
        }
        

//        [self stringFormatter:self 
//                          appendString:nil
//                appendAttributedString:str_or_nil(string)
//                            lineUpdate:closeLineInfo()];
    }
    _editingLine = NO;
}

#define openLineInfo() MakeInfo(_editingLine, NO, YES, NO)

- (void) openLineWithString:(NSString*) string {
    FLAssertNotNil(string);
    
    if(_editingLine) {
        [_output  stringFormatterCloseLine:self];
    }
    
    [_output stringFormatterOpenLine:self];
    [_output stringFormatter:self appendString:string];
    
//    [self stringFormatter:self 
//                      appendString:str_or_nil(string)
//            appendAttributedString:nil
//                        lineUpdate:openLineInfo()];
                      

    _editingLine = YES;
}


- (void) openLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    
    if(_editingLine) {
        [_output  stringFormatterCloseLine:self];
    }
    
    [_output stringFormatterOpenLine:self];
    [_output stringFormatter:self appendAttributedString:string];
    
//    [self stringFormatter:self 
//                      appendString:nil
//            appendAttributedString:str_or_nil(string)
//                        lineUpdate:openLineInfo()];
                      

    _editingLine = YES;
}

#define appendLineInfo() MakeInfo(NO, NO, !_editingLine, YES)

- (void) appendLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    
    if(!_editingLine) {
        [_output stringFormatterOpenLine:self];
    }
    [_output stringFormatter:self appendAttributedString:string];
    [_output  stringFormatterCloseLine:self];
    
//    [self stringFormatter:self 
//                      appendString:nil
//            appendAttributedString:str_or_nil(string)
//                        lineUpdate:appendLineInfo()];
                      

    _editingLine = NO;
}


- (void) appendLine:(NSString*) string {
    FLAssertNotNil(string);

    if(!_editingLine) {
        [_output stringFormatterOpenLine:self];
    }
    [_output stringFormatter:self appendString:string];
    [_output  stringFormatterCloseLine:self];

    
//    [self stringFormatter:self 
//                      appendString:str_or_nil(string)
//            appendAttributedString:nil
//                        lineUpdate:appendLineInfo()];

    _editingLine = NO;
}

- (void) appendBlankLine {
//    [self stringFormatter:self 
//                      appendString:nil
//            appendAttributedString:nil
//                        lineUpdate:MakeInfo(_editingLine, YES, NO, NO)];
                        
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

- (void) appendLineWithFormat:(NSString*) format, ... {
    FLAssertNotNil(format);
	va_list va;
	va_start(va, format);
	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	[self appendLine:string];
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

//- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
//            appendString:(NSString*) string
//  appendAttributedString:(NSAttributedString*) attributedString
//              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {
//              
//}              

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
