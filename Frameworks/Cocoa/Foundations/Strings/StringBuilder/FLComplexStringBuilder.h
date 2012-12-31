//
//  FLStringBuilderContents.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLWhitespace.h"
#import "FLStringFormatter.h"
#import "FLStringBuilder.h"
#import "FLPrettyString.h"

@interface FLComplexStringBuilder : NSObject {
@private
    NSMutableArray* _stack;
}

- (id) init;
+ (id) complexStringBuilder;


@property (readonly, strong, nonatomic) FLStringBuilder* formatter;
- (void) openFormatter:(FLStringBuilder*) scope;
- (void) closeFormatter;

- (void) addLineWithObject:(id /*FLBuildableString*/) object;

/// This preserves scope of incoming builder (e.g. nests into THIS builder's scope)
/// @param builder The builder containing the lines you want to append to this builder.
//- (void) addStringBuilder:(FLStringBuilder*) builder;

// build the string

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace;

- (NSString*) buildStringWithNoWhitespace;
- (NSString*) buildStringWithWhitespace; // default whitespace

@end

@interface FLStringBuilder (FLComplexStringBuilder)
- (id) document;
@end