//
//  FLStringBuilderContents.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWhitespace.h"
#import "FLStringBuilderToken.h"

@class FLStringBuilder;

typedef void (^FLAppendStringBuilderBlock)(FLStringBuilder* stringBuilder);

@interface FLStringBuilder : NSObject<NSCopying, NSCoding, FLStringBuilderToken> {
@private
    NSMutableArray* _tokens;
    NSUInteger _cursor;
    id _header;
    id _footer;
}

+ (id) stringBuilder;

@property (readwrite, retain, nonatomic) id header;
@property (readwrite, retain, nonatomic) id footer;

@property (readonly, assign, nonatomic) BOOL isEmpty;

@property (readonly, assign, nonatomic) NSUInteger tokenCount;

@property (readonly, strong, nonatomic) NSArray* tokens;

/// append string with no LF.

/// @param string The string to append.
- (void) appendString:(NSString*) string;

/// Append format string with variable length list with no LF.

/// @param format The string to append.
- (void) appendFormat:(NSString*) format, ...;

/// Append blank line.

- (void) appendLine;

/// Append a new line with a string.

- (void) appendLine:(NSString*) line;

- (void) indent;

- (void) appendIndentedBlock:(void (^)()) indentedBlock;

- (void) outdent;

/// Append a new line with a formatted string.
- (void) appendLineWithFormat:(NSString*) format, ...;

/// Append array of strings.
/// @param lines the array of strings
/// @param trimWhitespace trim the whitespace of beginning and end of each line as it's added 
- (void) appendLines:(NSString*) lines
      trimWhitespace:(BOOL) trimWhitespace;

/// This preserves scope of incoming builder (e.g. nests into THIS builder's scope)
/// @param builder The builder containing the lines you want to append to this builder.
- (void) insertBuilderContents:(FLStringBuilder*) builder;

- (void) pushToken:(id) token;

- (void) addToken:(id) token;

- (void) insertToken:(id) token beforeToken:(id) token;

- (void) insertToken:(id) token atIndex:(NSUInteger) atIndex;

@property (readonly, strong, nonatomic) id lastToken;

- (BOOL) isLastToken:(id) token;

- (void) visitTokens:(void (^)(id token, BOOL* stop)) visitor; // visits in reverse order

- (void) removeToken:(id) token;

- (void) removeAllTokens;

@property (readonly, strong, nonatomic) FLEolToken* lastEolToken;

@property (readwrite, assign, nonatomic) NSUInteger cursor;

- (void) moveCurserToEnd;

- (void) moveCursorToBeginning;

// build the string

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace;

- (NSString*) buildString; // default whitespace

- (NSString*) buildStringWithNoWhitespace;

// override points
- (void) willBuildString;
- (void) didBuildString;
- (BOOL) shouldBuildString; // returns YES is builder is NOT empty. 

@end




