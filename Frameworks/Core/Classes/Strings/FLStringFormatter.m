//
//  FLAbstractStringBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "FLStringFormatter.h"
#import "FLAssertions.h"
#import "NSArray+FLExtras.h"

/*
/// concrete base class.
*/
@interface FLStringFormatter ()
- (void) openLine;
@end

@implementation FLStringFormatter

@synthesize stringFormatterOutput = _output;
@synthesize parent = _parent;
@synthesize lineIsOpen = _editingLine;

- (void) processAndAppendAttributedString:(NSAttributedString*) string {

    // TODO

    [_output stringFormatter:self appendAttributedString:string];

}

- (void) processAndAppendString:(NSString*) string {

    NSRange range = { 0, 0 };
    
    for(NSUInteger i = 0; i < string.length; i++) {
        unichar c = [string characterAtIndex:i];
        
        if(c == '\n') {
            if(range.length > 0) {
                [self openLine];
                [_output stringFormatter:self appendString:[string substringWithRange:range]];
                [self closeLine];
            }
            
            range.location = i+1;
            range.length = 0;
            
            continue;
        }

        ++range.length;
    }
    
    if(range.length) {
        [self openLine];
            
        if(range.location > 0) {
            [_output stringFormatter:self appendString:[string substringWithRange:range]];
        }
        else {
            [_output stringFormatter:self appendString:string];
        }
    }
}

- (void) appendString:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    [self openLine];
    [self processAndAppendString:string];
}


- (void) appendAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    [self openLine];
    [self processAndAppendAttributedString:string];
}


- (void) openLine {
    FLAssertNotNil(_output);

    if(!_editingLine) {
        _editingLine = YES;
        [_output stringFormatterOpenLine:self];
    }
}

- (void) closeLine {

    FLAssertNotNil(_output);

    if(_editingLine) {
        [_output stringFormatterCloseLine:self];
        _editingLine = NO;
    }
}

- (void) closeLineWithString:(NSString*) string {
    FLAssertNotNil(_output);

    if(string) {
        [self openLine];
        [self processAndAppendString:string];
    }

    [self closeLine];
}

- (void) closeLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(_output);

    if(string) {
        [self openLine];
        [self processAndAppendAttributedString:string];
    }

    [self closeLine];
}

- (void) openLineWithString:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    [self closeLine];
    [self openLine];
    [self processAndAppendString:string];
}

- (void) openLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);
    
    [self closeLine];
    [self openLine];
    [self processAndAppendAttributedString:string];
}

- (void) appendLineWithAttributedString:(NSAttributedString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    [self openLine];
    [self processAndAppendAttributedString:string];
    [self closeLine];
}

- (void) appendLine:(NSString*) string {
    FLAssertNotNil(string);
    FLAssertNotNil(_output);

    [self openLine];
    [self processAndAppendString:string];
    [self closeLine];
    
}

- (void) appendBlankLine {
    FLAssertNotNil(_output);
     
    [self closeLine];                                       
    // intentionally not opening line
    [_output stringFormatterAppendBlankLine:self];
}

- (void) indent {
    [_output stringFormatterIndent:self];
}

- (void) outdent {
    [_output stringFormatterOutdent:self];
}

- (void) indent:(FLStringFormatterBlock) block {
    [self closeLine];
    [_output stringFormatterIndent:self];
    // subsequent calls to us will open a line, etc..
    block();
    [self closeLine]; // just in case.
    [_output stringFormatterOutdent:self];
}


- (void) setParent:(id) parent {
    _parent = parent;
    [self didMoveToParent:_parent];
}

- (void) didMoveToParent:(id) parent {
}

- (void) appendSelfToStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [_output stringFormatter:self appendSelfToStringFormatter:stringFormatter];
}

- (void) appendStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [stringFormatter appendSelfToStringFormatter:self];
}

- (NSUInteger) length {
    return [_output stringFormatterGetLength:self];
}

- (BOOL) isEmpty {
    return self.length == 0;
}

- (void) appendInScope:(NSString*) openScope closeScope:(NSString*) closeScope withBlock:(FLStringFormatterBlock) block {
    [self appendLine:openScope];
    [self indent:block];
    [self appendLine:closeScope];
}

@end
