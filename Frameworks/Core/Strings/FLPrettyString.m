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
@property (readwrite, strong, nonatomic) NSString* eolString;
@end

@implementation FLPrettyString

@synthesize string = _string;
@synthesize whitespace = _whitespace;
@synthesize tabIndent = _tabIndent;
@synthesize eolString = _eolString;

+ (FLWhitespace*) defaultWhitespace {
    return [FLWhitespace tabbedWithSpacesWhitespace];
}

- (id) initWithWhitespace:(FLWhitespace*) whitespace {
    self = [super init];
    if(self) {
        self.delegate = self;
    
        _string = [[NSMutableString alloc] init];
        _whitespace = FLRetain(whitespace);
        _needsTabInset = YES;
        
        self.eolString = _whitespace ? _whitespace.eolString : @"";
    }
    return self;
}

- (id) init {
    return [self initWithWhitespace:[FLPrettyString defaultWhitespace]];
}

+ (id) prettyString:(FLWhitespace*) whitespace {
    return FLAutorelease([[[self class] alloc] initWithWhitespace:whitespace]);
}

+ (id) prettyString {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) prettyStringWithString:(NSString*) string {
    FLPrettyString* prettyString = FLAutorelease([[[self class] alloc] init]);
    [prettyString appendString:string];
    return prettyString;
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

- (void) stringFormatterAppendEOL:(FLStringFormatter*) stringFormatter {
    if(_eolString) { 
        [_string appendString:_eolString]; 
    } 
    _needsTabInset = YES;
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string {
    FLAssertNotNil_(_string);
//    FLAssertNotNil_(_whitespace);
    
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

- (NSString*) stringFormatterGetString:(FLStringFormatter*) stringFormatter {
    FLAssertNotNil_(_string);
    return _string;
}

- (id) copyWithZone:(NSZone*) zone {
    FLPrettyString* str = [[FLPrettyString alloc] initWithWhitespace:self.whitespace];
    str.string = FLAutorelease([_string mutableCopy]);
    str.tabIndent = self.tabIndent;
    return str;
}

- (void) appendPrettyString:(FLPrettyString*) string {
    [self appendStringContainingMultipleLines:self.string];
}

- (void) deleteAllCharacters {
    [_string deleteCharactersInRange:NSMakeRange(0, _string.length)];
}

- (void) appendBuildableString:(id<FLBuildableString>) buildableString {
    [buildableString appendLinesToPrettyString:self];
}

- (void) stringFormatterDeleteAllCharacters:(FLStringFormatter*) stringFormatter {
    [self deleteAllCharacters];
}

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
    ++_tabIndent;
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
    --_tabIndent;
}



@end

@implementation NSObject (FLPrettyString)

- (void) describe:(FLPrettyString*) formatter {
    [formatter appendLine:[self description]];
}

- (NSString*) prettyDescription {
    FLPrettyString* str = [FLPrettyString prettyString];
    [self describe:str];
    return [str string];
}

@end


