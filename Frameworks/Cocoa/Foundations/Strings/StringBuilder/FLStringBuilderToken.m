//
//  FLStringBuilderToken.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringBuilderToken.h"
#import "FLStringBuilder.h"

@implementation NSString (FLStringBuilder)

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
    
    if(self.length) {
        [string appendString:self];
    }
}

@end

@implementation FLTokenPlaceholder

@synthesize token = _token;

+ (FLTokenPlaceholder*) tokenPlaceholder {
    return FLAutorelease([[FLTokenPlaceholder alloc] init]);
}

+ (FLTokenPlaceholder*) tokenPlaceholder:(id) tokenOrNil {
    return FLAutorelease([[FLTokenPlaceholder alloc] initWithToken:tokenOrNil]);
}

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
    
    if(_token) {
        [_token appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return [[FLTokenPlaceholder alloc] initWithToken:FLAutorelease([_token copy])];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_token == nil ? @"" : _token forKey:@"token"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if(self) {
        _token = [aDecoder decodeObjectForKey:@"token"];
    }
    return self;
}

- (id) initWithToken:(id) token {
    self = [self init];
    if(self) {
        self.token = token;
    }
    
    return self;
}

- (id) init {
    self = [super init];
    if(self) {
    
    }
    return self;
}

- (NSString*) description {
    return _token ? [_token description] : [super description];
}


@end

@implementation FLEolToken

+ (id) eolToken {
    return FLAutorelease([[FLEolToken alloc] init]);
}

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
    
    [super appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
    
    if(whitespace) {
        [whitespace appendEolAndTabs:*tabIndent toString:string];
    }
}


@end

@implementation FLIndentToken

+ (FLIndentToken*) indentToken {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
    (*tabIndent)++;
    [super appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
}



@end

@implementation FLOutdentToken

+ (FLOutdentToken*) outdentToken {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
    (*tabIndent)--;
    [super appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
}


@end

@implementation FLSingleLineToken

@synthesize line = _line;

+ (FLSingleLineToken*) singleLineToken:(NSString*) line {
    FLSingleLineToken* token = FLAutorelease([[[self class] alloc] init]);
    token.line = line;
    return token;
}

- (void) appendSelfToString:(NSMutableString*) string
                 whitespace:(FLWhitespace*) whitespace
                  tabIndent:(NSInteger*) tabIndent {
    [_line appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
    [super appendSelfToString:string whitespace:whitespace tabIndent:tabIndent];
}

@end
