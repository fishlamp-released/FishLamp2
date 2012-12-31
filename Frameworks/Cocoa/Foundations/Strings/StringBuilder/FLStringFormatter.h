//
//  FLAbstractStringBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@class FLPrettyString;

@protocol FLStringFormatter <NSObject>
- (void) appendLine; // required ovveride
- (void) appendLine:(NSString*) line;  // required ovveride
@end

@interface FLStringFormatter : NSObject {
@private
}

/// @param string The string to append.
- (void) appendString:(NSString*) string;

/// Append format string with variable length list with no LF.

/// @param format The string to append.
- (void) appendFormat:(NSString*) format, ...;

/// Append blank line.
- (void) appendLine; // required ovveride

/// Append a new line with a string.
- (void) appendLine:(NSString*) line;  // required ovveride

/// Append a new line with a formatted string.
- (void) appendLineWithFormat:(NSString*) format, ...;

/// Append array of strings.
/// @param lines the array of strings
/// @param trimWhitespace trim the whitespace of beginning and end of each line as it's added 
- (void) appendLines:(NSString*) lines
      trimWhitespace:(BOOL) trimWhitespace;

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString;

@end


