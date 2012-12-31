//
//  FLPrettyString.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"
#import "FLWhitespace.h"

@interface FLPrettyString : FLStringFormatter<NSCopying> {
@private
    NSMutableString* _string;
    FLWhitespace* _whitespace;
    BOOL _needsTabInset;
}

@property (readonly, strong, nonatomic) NSString* string;
@property (readonly, strong, nonatomic) FLWhitespace* whitespace;

- (id) initWithWhitespace:(FLWhitespace*) whitespace;
+ (id) prettyString:(FLWhitespace*) whiteSpace;
+ (id) prettyString;


@end
