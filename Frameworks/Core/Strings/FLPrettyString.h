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

@interface FLPrettyString : FLStringFormatter<FLStringFormatterDelegate> {
@private
    id _storage;
    id _eolString;
    FLWhitespace* _whitespace;
    NSInteger _indentLevel;
}

@property (readonly, assign, nonatomic) NSInteger indentLevel;
@property (readonly, assign, nonatomic) NSUInteger length;
@property (readonly, strong, nonatomic) FLWhitespace* whitespace;
@property (readonly, strong, nonatomic) NSString* string;

- (id) initWithWhitespace:(FLWhitespace*) whitespace;
+ (id) prettyString:(FLWhitespace*) whiteSpace;

+ (id) prettyString; // uses default whitespace

+ (id) prettyStringWithString:(NSString*) string;

- (void) appendPrettyString:(FLPrettyString*) string;

- (void) appendBuildableString:(id<FLBuildableString>) buildableString;

- (void) deleteAllCharacters;

@end

@interface FLPrettyString (Whitespace)
+ (FLWhitespace*) defaultWhitespace;
@end

@interface NSObject (FLStringFormatter)
- (void) describe:(FLPrettyString*) formatter;
- (NSString*) prettyDescription;
@end


@interface FLPrettyAttributedString : FLPrettyString {
@private
}

@property (readonly, strong, nonatomic) NSAttributedString* attributedString;

@end


