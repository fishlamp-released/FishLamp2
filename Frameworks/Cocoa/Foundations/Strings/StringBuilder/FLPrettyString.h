//
//  FLPrettyString.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"
#import "FLWhitespace.h"

@protocol FLBuildableString <NSObject>
- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString;
@end

@interface NSString (FLComplexStringBuilder)
- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString;
@end

@interface FLPrettyString : FLStringFormatter<NSCopying, FLStringFormatter, FLBuildableString> {
@private
    NSMutableString* _string;
    FLWhitespace* _whitespace;
    BOOL _needsTabInset;
    NSInteger _tabIndent;
    NSString* _eolString;
}
@property (readonly, assign, nonatomic) NSUInteger length;

@property (readonly, strong, nonatomic) NSString* string;
@property (readonly, strong, nonatomic) FLWhitespace* whitespace;
@property (readwrite, assign, nonatomic) NSInteger tabIndent;

- (id) initWithWhitespace:(FLWhitespace*) whitespace;
+ (id) prettyString:(FLWhitespace*) whiteSpace;
+ (id) prettyString;

- (void) indent;
- (void) outdent;

- (void) indent:(void (^)()) block;

@end
