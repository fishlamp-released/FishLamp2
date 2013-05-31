//
//  FLPrettyString.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FLRequired.h"

#import "FLStringFormatter.h"
#import "FLWhitespace.h"

@protocol FLPrettyStringDelegate;

@interface FLPrettyString : FLStringFormatter<FLStringFormatterOutput> {
@private
    id _storage;
    id _eolString;
    FLWhitespace* _whitespace;
    NSInteger _indentLevel;
    __unsafe_unretained id<FLPrettyStringDelegate> _delegate;
}
@property (readwrite, assign, nonatomic) id<FLPrettyStringDelegate> delegate;

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

// for subclasses
- (void) appendStringToStorage:(NSString*) string;
- (void) appendAttributedStringToStorage:(NSAttributedString*) string;
- (void) appendEOL;

@end

@protocol FLPrettyStringDelegate <NSObject>
@optional
- (void) prettyString:(FLPrettyString*) prettyString didAppendString:(NSString*) string;
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

@protocol FLPrettyAttributedStringDelegate <NSObject>
@optional
- (NSAttributedString*) prettyString:(FLPrettyString*) prettyString willAppendAttributedString:(NSAttributedString*) string;
- (void) prettyString:(FLPrettyString*) prettyString didAppendAttributedString:(NSAttributedString*) string;
@end
