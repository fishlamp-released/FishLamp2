//
//  FLPrintf.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPrintf.h"
#import "FLWhitespace.h"
#import "FishLampCore.h"

static NSUInteger s_indent = 0;

void FLPrintStringWithIndent(NSUInteger indent, NSString* string) {
    if(indent) {
        FLPrintString([NSString stringWithFormat:@"%@%@", [[FLWhitespace tabbedWithSpacesWhitespace] tabStringForScope:indent], string]);
    }
    else {
        FLPrintString(string);
    }
}

void FLPrintString(NSString* string) {
    const char* c_str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    if(c_str) {
        printf("%s", c_str);
    }
}

void FLPrintFormat(NSString* format, ...) {

    if(FLStringIsEmpty(format)) {
        return;
    }
     
    va_list va;
    va_start(va, format);
    NSString* string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
    va_end(va);
    
    FLPrintStringWithIndent(s_indent, string);
}

void FLPrintFormatWithIndent(NSUInteger indent, NSString* format, ...) {

    if(FLStringIsEmpty(format)) {
        return;
    }
     
    va_list va;
    va_start(va, format);
    NSString* string = FLAutorelease([[NSMutableString alloc] initWithFormat:format arguments:va]);
    va_end(va);
    
    FLPrintStringWithIndent(indent, string);
}

extern void FLIndentString(void (^block)()) {
    ++s_indent;
    if(block) block();
    --s_indent;
}