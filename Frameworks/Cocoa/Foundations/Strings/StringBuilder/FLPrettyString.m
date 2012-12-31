//
//  FLPrettyString.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPrettyString.h"

@interface FLPrettyString ()
@property (readwrite, strong, nonatomic) NSString* string;
@property (readwrite, strong, nonatomic) FLWhitespace* whitespace;
@end

@implementation FLPrettyString

@synthesize string = _string;
@synthesize whitespace = _whitespace;
@synthesize tabIndent = _tabIndent;

- (id) initWithWhitespace:(FLWhitespace*) whitespace {
    self = [super init];
    if(self) {
        _string = [[NSMutableString alloc] init];
        _whitespace = FLRetain(whitespace);
        _needsTabInset = YES;
        
        NSString* eol = _whitespace.eolString;
        
        if(FLStringIsNotEmpty(eol)) {
            _eolString = FLRetain(eol);
        }
    }
    return self;
}

+ (id) prettyString:(FLWhitespace*) whitespace {
    return FLAutorelease([[[self class] alloc] initWithWhitespace:whitespace]);
}

+ (id) prettyString {
    return FLAutorelease([[[self class] alloc] initWithWhitespace:[FLWhitespace tabbedWithSpacesWhitespace]]);
}

- (NSUInteger) length {
    return _string.length;
}

#if FL_DEALLOC
- (void) dealloc {
    [_eolString release];
    [_whitespace release];
    [_string release];
    [super dealloc];
}
#endif

- (void) appendLine {
    if(_eolString) { 
        [_string appendString:_eolString]; 
    } 
    _needsTabInset = YES;
}
            
- (void) appendString:(NSString*) string {
    if(FLStringIsNotEmpty(string)) {

// only apply inset if the string is not empty
        if(_needsTabInset) {
            if(_whitespace) { 
                [_string appendString:[_whitespace tabStringForScope:self.tabIndent]]; 
            } 
            _needsTabInset = NO;
        }
        [_string appendString:string];
    }
}

- (id) copyWithZone:(NSZone*) zone {
    FLPrettyString* str = [[FLPrettyString alloc] initWithWhitespace:self.whitespace];
    str.string = FLAutorelease([_string mutableCopy]);
    str.tabIndent = self.tabIndent;
    return str;
}

- (void) indent {
    ++_tabIndent;
}

- (void) outdent {
    --_tabIndent;
}

- (void) indent:(void (^)()) block {
    [self appendLine];
    [self indent];
    block();
    [self appendLine];
    [self outdent];
}

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {
    [prettyString appendLine:[self string]];
}

//- (void) appendLine:(NSString*) string 
//      withTabIndent:(NSInteger) tabIndent {
//        
//    if(_whitespace) {
//        [_string appendFormat:@"%@%@%@", [_whitespace tabStringForScope:self.tabIndent + tabIndent], string, _whitespace.eolString];
//    }
//    else {
//        [_string appendString:string];
//    }
//}

@end

@implementation NSString (FLPrettyString)
- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {
    [prettyString appendString:self];
}

@end


