//
//  FLParseableInput.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStringFormatter.h"


@interface FLStringTokenizerState : NSObject {
@private
    NSString* _string;
    unsigned long _length;
    unsigned long _location;
}
@property (readonly, strong, nonatomic) NSString* string;

- (id) initWithString:(NSString*) string;
+ (id) stringTokenizerState:(NSString*) string;

@property (readonly, assign, nonatomic) unsigned long location;
@property (readonly, assign, nonatomic) unsigned long length;
@property (readonly, assign, nonatomic) BOOL hasMore;
@property (readonly, assign, nonatomic) unichar currentChar;
- (BOOL) substringWithRange:(NSRange) range equalsString:(NSString*) string;

- (BOOL) advanceToNextChar;

@end    

@interface FLStringTokenizer : NSObject {
}

+ (id) stringTokenizer;

- (NSArray*) parseString:(NSString*) string;

// this is the main thing to override
- (BOOL) continueParsingToken:(NSRange) tokenRange 
                    withState:(FLStringTokenizerState*) state;

// optional overrides
- (BOOL) isWhitespace:(unichar) aChar;

- (BOOL) eatWhitespace:(FLStringTokenizerState*) state;

- (NSRange) parseToken:(FLStringTokenizerState*) state;

- (void) parseStringInState:(FLStringTokenizerState*) state 
             intoTokenArray:(NSMutableArray*) tokens;

@end