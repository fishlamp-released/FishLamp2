//
//  FLAbstractStringBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

@protocol FLStringFormatter <NSObject>

/// ends currently open line, opens a new one.
- (void) openLineWithString:(NSString*) string;
- (void) openLineWithFormat:(NSString*) format, ...;
- (void) openLineWithAttributedString:(NSAttributedString*) string;

/// append to open line. Opens a news line if no line is open.
- (void) appendString:(NSString*) string; 
- (void) appendFormat:(NSString*) format, ...;
- (void) appendAttributedString:(NSAttributedString*) string; 

// end current line with EOF (only if it hasn't already been ended)
- (void) closeLine; 
- (void) closeLineWithString:(NSString*) string;
- (void) closeLineWithFormat:(NSString*) format, ...;
- (void) closeLineWithAttributedString:(NSAttributedString*) format;

/// Ends currently open line, then adds a blank line. Leaves no open line.
- (void) appendBlankLine;

/// AppendLine: Append a string, then a EOL. Ends currently open line first.
- (void) appendLine:(NSString*) line;  
- (void) appendLineWithFormat:(NSString*) format, ...;
- (void) appendLineWithAttributedString:(NSAttributedString*) line;  

/// AppendLine is called for each line
- (void) appendLines:(NSString**) lines count:(NSInteger) count;
- (void) appendLines:(NSString**) lines;
- (void) appendLinesWithArray:(NSArray*) lines;

/// incoming string is chopped into lines and then fed through appendLines
- (void) appendStringContainingMultipleLines:(NSString*) inLines;
- (void) appendStringContainingMultipleLines:(NSString*) inLines trimWhitespace:(BOOL) trimWhitespace;

/// indent the string (optionally implemented by delegate)
- (void) indent;
- (void) outdent;

// if delegate doesn't implement indentLevel, then the block is executed anyway and resulting
// text will not be indented.
- (void) indent:(void (^)()) block;

@end

/// concrete base class.

/// this describes state of open openLine. Uses one method (stringFormatter:appendString:lineInfo) to allow
/// for optimizations.
typedef struct {
    BOOL closePreviousLine; 
    BOOL prependBlankLine; // closePreviousLine may be YES or NO
    BOOL openLine; // Note: openLine will always have non-empty string if YES.
    BOOL closeLine; // Any of other options may be set
} FLStringFormatterLineUpdate;

@interface FLStringFormatter : NSObject<FLStringFormatter> {
@private
    BOOL _editingLine;
}

// required override
- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string
  appendAttributedString:(NSAttributedString*) string
              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate;

// optional overrides
- (void) indent;
- (void) outdent;


@end

@protocol FLBuildableString <NSObject>
- (void) appendLinesToStringFormatter:(id<FLStringFormatter>) stringFormatter;
@end


