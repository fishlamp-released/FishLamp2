//
//  FLStringBuilder.h
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLWhitespace.h"

@interface FLStringBuilder : NSObject {
@private
    NSMutableString* _string;
    FLWhitespace* _whitespace;
    NSInteger _indentDepth;
    BOOL _needsTabs;
}

@property (readwrite, assign, nonatomic) NSInteger indentDepth;
- (void) indent;
- (void) undent;

- (id) init;
- (id) initWithCapacity:(NSUInteger) capacity;

+ (FLStringBuilder*) stringBuilder;
+ (FLStringBuilder*) stringBuilderWithCapacity:(NSUInteger) capacity;

@property (readonly, assign, nonatomic) NSUInteger length;

/// Get/Set the whitespace, the default is the tabbedWhitespace (see FLWhitespace.h)
@property (readwrite, strong, nonatomic) FLWhitespace* whitespace; 

/// append string with no LF.

/// @param string The string to append.
- (void) appendString:(NSString*) string;

/// Append format string with variable length list with no LF.

/// @param format The string to append.
- (void) appendFormat:(NSString*) format, ...;

/// Append blank line.

- (void) appendLine;

- (NSString*) eol;

- (NSString*) tab; 

- (NSString*) tabsForIndentDepth;

/// Append a new line with a string.

- (void) appendLine:(NSString*) line;
//
///// Append a new line with a formatted string.
//
- (void) appendLineWithFormat:(NSString*) format, ...;
//
///// Only append a new line if the string is not empty.
//
- (BOOL) appendLineIfNotEmpty:(NSString*) line;

/// Only append a string if the string is not empty (e.g. no line feed).

- (BOOL) appendStringIfNotEmpty:(NSString*) string;

/// Append array of strings.

/// @param lines the array of strings
/// @param trimWhitespace trim the whitespace of beginning and end of each line as it's added 
- (void) appendLines:(NSString*) lines 
      trimWhitespace:(BOOL) trimWhitespace;

/// Append lines from another builder.

/// This preserves scope of incoming builder (e.g. nests into THIS builder's scope)
/// @param builder The builder containing the lines you want to append to this builder.
- (void) appendBuilder:(FLStringBuilder*) builder;

- (NSString*) buildString;

/// should be appended in <tabs><string><eol>. Tabs or str might be an empty string (but never nil)
///     [destString appendFormat:@"%@%@%@", appendMeFirst, appendMeSecond, appendMeThird];

- (void) willAppendToString:(NSMutableString*) destString 
                       tabs:(NSString*) appendMeFirst 
                     string:(NSString*) appendMeSecond  
                        eol:(NSString*) appendMeThird;

@end
