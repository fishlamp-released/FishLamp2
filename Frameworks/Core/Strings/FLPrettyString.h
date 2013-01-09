//
//  FLPrettyString.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLRequired.h"

#import "FLStringFormatter.h"
#import "FLWhitespace.h"

@interface FLPrettyString : FLStringFormatter<NSCopying, FLStringFormatterDelegate> {
@private
    NSMutableString* _string;
    FLWhitespace* _whitespace;
    BOOL _needsTabInset;
    NSInteger _tabIndent;
    NSString* _eolString;
}

@property (readonly, assign, nonatomic) NSUInteger length;
@property (readwrite, strong, nonatomic) FLWhitespace* whitespace;
@property (readwrite, assign, nonatomic) NSInteger tabIndent;

@property (readonly, strong, nonatomic) NSString* string;

- (id) initWithWhitespace:(FLWhitespace*) whitespace;
+ (id) prettyString:(FLWhitespace*) whiteSpace;

+ (id) prettyString; // uses default whitespace

+ (id) prettyStringWithString:(NSString*) string;

- (void) indent;
- (void) outdent;

- (void) indent:(void (^)()) block;

+ (FLWhitespace*) defaultWhitespace;

@end

@interface NSObject (FLStringFormatter)
- (void) describe:(FLPrettyString*) formatter;
- (NSString*) prettyDescription;
@end
