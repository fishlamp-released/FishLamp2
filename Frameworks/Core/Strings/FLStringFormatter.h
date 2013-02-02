//
//  FLAbstractStringBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

@protocol FLStringFormatterDelegate;

@interface FLStringFormatter : NSObject {
@private
    BOOL _editingLine;
    __unsafe_unretained id<FLStringFormatterDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLStringFormatterDelegate> delegate;


- (void) startLine; 
- (void) startLine:(NSString*) string;
- (void) startLineWithFormat:(NSString*) format, ...;

- (void) appendString:(NSString*) string; 
- (void) appendFormat:(NSString*) format, ...;

// end current line with EOF (only if it hasn't already been ended)
- (void) endLine; 
- (void) endLine:(NSString*) string;
- (void) endLineWithFormat:(NSString*) format, ...;

/// endLine, Append a string, then a EOL
- (void) appendBlankLine;
- (void) appendLine:(NSString*) line;  
- (void) appendLineWithFormat:(NSString*) format, ...;

- (void) appendLines:(NSString**) lines;
- (void) appendLinesWithArray:(NSArray*) lines;

/// Append array of strings.
/// @param lines the array of strings
/// @param trimWhitespace trim the whitespace of beginning and end of each line as it's added 
- (void) appendLines:(NSString*) linesToParse
      trimWhitespace:(BOOL) trimWhitespace;

- (NSString*) string;

- (void) deleteAllCharacters;

- (void) indent;
- (void) outdent;
- (void) indent:(void (^)()) block;

@end


@protocol FLStringFormatterDelegate <NSObject>

- (void) stringFormatterAppendEOL:(FLStringFormatter*) stringFormatter; 

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string;

- (NSString*) stringFormatterGetString:(FLStringFormatter*) stringFormatter;

- (void) stringFormatterDeleteAllCharacters:(FLStringFormatter*) stringFormatter;

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter;
- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter;
@end




