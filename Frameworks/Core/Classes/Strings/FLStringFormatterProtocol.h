//
//  FLStringFormatterProtocol.h
//  FishLampCore
//
//  Created by Mike Fullerton on 8/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCoreRequired.h"

typedef void (^FLStringFormatterBlock)();

@protocol FLStringFormatter;

@protocol FLAppendableString <NSObject>
- (void) appendSelfToStringFormatter:(id<FLStringFormatter>) stringFormatter;
@end

@protocol FLStringFormatter <FLAppendableString>

@property (readonly, assign, nonatomic) BOOL lineIsOpen;
@property (readonly, assign, nonatomic) NSUInteger length;
@property (readonly, assign, nonatomic) BOOL isEmpty;

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
- (void) indent:(FLStringFormatterBlock) block;

- (void) appendInScope:(NSString*) openScope 
            closeScope:(NSString*) closeScope 
             withBlock:(FLStringFormatterBlock) block;

- (void) appendStringFormatter:(id<FLStringFormatter>) stringBuilder;

@property (readwrite, assign, nonatomic) id parent;
@end
