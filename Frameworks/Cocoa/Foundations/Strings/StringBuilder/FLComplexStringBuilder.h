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

@interface FLComplexStringBuilder : NSObject {
@private
    NSMutableArray* _stack;
    NSMutableArray* _stringBuilders;
}

@property (readonly, assign, nonatomic) BOOL isEmpty;
- (id) init;
+ (id) complexStringBuilder;

@property (readonly, strong, nonatomic) FLStringBuilder* stringBuilder;
- (void) openScope:(FLStringBuilder*) scope;
- (void) closeScope;

- (void) addStringBuilder:(FLStringBuilder*) stringBuilder;

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