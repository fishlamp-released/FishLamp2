//
//  FLAbstractStringBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
- (void) appendFormat:(NSString*) format arguments:(va_list)argList;

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
- (void) appendLineWithFormat:(NSString*) format arguments:(va_list)argList;

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

@protocol FLStringFormatterOutput;

@interface FLStringFormatter : NSObject<FLStringFormatter> {
@private
    BOOL _editingLine;
    __unsafe_unretained id<FLStringFormatterOutput> _output;
}
@property (readwrite, nonatomic, assign) __unsafe_unretained id<FLStringFormatterOutput> stringFormatterOutput;
@end

@protocol FLStringFormatterOutput <NSObject>
- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter;
- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter;
- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter;
- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string;
- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString;
- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter;
- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter;
@end

@protocol FLBuildableString <NSObject>
- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter;
@end




