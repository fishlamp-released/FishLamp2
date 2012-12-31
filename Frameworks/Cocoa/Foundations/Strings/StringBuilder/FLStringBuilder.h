//
//  FLPrettyString.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLWhitespace.h"
#import "FLStringFormatter.h"
#import "FLStringBuilderLine.h"

@class FLStringBuilderLine;

@interface FLStringBuilder : FLStringFormatter<FLStringBuilderLine> {
@private
    NSMutableArray* _lines;
    BOOL _needsLine;
    __unsafe_unretained id _parent;
}
@property (readonly, strong, nonatomic) NSArray* lines;

+ (id) stringBuilder;

- (void) addStringBuilder:(FLStringBuilder*) stringBuilder;
- (void) addStringBuilderLine:(FLStringBuilderLine*) line;

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace;
- (NSString*) buildStringWithNoWhitespace;
- (NSString*) buildString;

@end

