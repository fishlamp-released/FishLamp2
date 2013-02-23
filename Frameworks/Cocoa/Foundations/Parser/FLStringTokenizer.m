//
//  FLParseableInput.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStringTokenizer.h"

@interface FLStringTokenizerState ()
@property (readwrite, strong, nonatomic) NSString* string;
@end

@implementation FLStringTokenizerState

@synthesize location = _location;
@synthesize length = _length;
@synthesize string = _string;

- (id) initWithString:(NSString*) string {
    self = [super init];
    if(self) {
        self.string = string;
        _location = 0;
        _length = string.length;
    }
    
    return self;
}

+ (id) stringTokenizerState:(NSString*) string {
    return FLAutorelease([[[self class] alloc] initWithString:string]);
}

#if FL_MRC
- (void) dealloc {
    [_string release];
    [super dealloc];
}
#endif

- (BOOL) hasMore {
    return _location < _length;
}

- (unichar) currentChar {
    return [_string characterAtIndex:_location];
}

- (BOOL) advanceToNextChar {
    return ++_location < _length;
}

- (NSString*) stringForRange:(NSRange) range {
    return [_string substringWithRange:range];
}

- (BOOL) substringWithRange:(NSRange) range equalsString:(NSString*) string {
    return [_string compare:string options:NSLiteralSearch range:range] == NSOrderedSame;
}

@end

@implementation FLStringTokenizer

+ (id) stringTokenizer {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [super dealloc];
}
#endif

- (BOOL) isWhitespace:(unichar) aChar {
    return [[NSCharacterSet whitespaceCharacterSet] characterIsMember:aChar];
}

- (BOOL) continueParsingToken:(NSRange) tokenRange withState:(FLStringTokenizerState*) state {
    return ![self isWhitespace:state.currentChar];
}

- (BOOL) eatWhitespace:(FLStringTokenizerState*) state {
    while([self isWhitespace:state.currentChar] && [state advanceToNextChar]) {
    }
    
    return state.hasMore;
}

- (void) parseStringInState:(FLStringTokenizerState*) state intoTokenArray:(NSMutableArray*) tokens {
    while(state.hasMore) {
        NSRange range = [self parseToken:state];
        if(range.length > 0) {
            [tokens addObject:[state stringForRange:range]];
        }
    }
}

- (NSArray*) parseString:(NSString*) string {
    NSMutableArray* tokens = [NSMutableArray array];
    FLStringTokenizerState* state = [FLStringTokenizerState stringTokenizerState:string];
    [self parseStringInState:state intoTokenArray:tokens];
    return tokens;
}

- (NSRange) parseToken:(FLStringTokenizerState*) state {

    NSRange range = { 0, 0 };
    
    if([self eatWhitespace:state]) {
        range.location = state.location;
        range.length = 1;
        while(  [state advanceToNextChar] && 
                [self continueParsingToken:range withState:state]) {
            range.length++;
        }
    }

    return range;
}



@end