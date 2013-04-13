//
//  FLConsoleLogSink.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLConsoleLogSink.h"
#import "FLPrintf.h"
#import "FLWhitespace.h"

@implementation FLConsoleLogSink

+ (id) consoleLogSink {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (FLLogSink*) consoleLogSink:(FLLogSinkOutputFlags) outputFlags {
    return FLAutorelease([[[self class] alloc] initWithOutputFlags:outputFlags]);
}

- (void) logEntry:(FLLogEntry*) entry stopPropagating:(BOOL*) stop {

    NSString* logString = nil;
    NSString* whitespace = [[FLWhitespace tabbedWithSpacesWhitespace] tabStringForScope:entry.indentLevel];
    
    if(entry.error) {
        logString = [NSString stringWithFormat:@"%@: %@", entry.error.localizedDescription, entry.error.comment];
    }
    else if(entry.exception) {
        logString = [NSString stringWithFormat:@"%@: %@", 
            entry.exception.name, 
            entry.exception.reason];
    }
    else {
        logString = entry.logString;
    }

    if(FLTestAnyBit(self.outputFlags, FLLogOutputWithLocation | FLLogOutputWithStackTrace)) {
        FLPrintFormat(@"%@[%s:%d] { \n", 
                      whitespace,
                      entry.stackTrace.fileName, 
                      entry.stackTrace.lineNumber
                      );
        whitespace = [[FLWhitespace tabbedWithSpacesWhitespace] tabStringForScope:entry.indentLevel + 1];                      
    }
    
    NSUInteger lastIndex = 0;
    for(NSUInteger i = 0; i < logString.length; i++) {
        
        unichar c = [logString characterAtIndex:i];
        if(c == '\n') {
        
            if(i > lastIndex) {
                NSRange  range = NSMakeRange(lastIndex, i - lastIndex); 
                FLPrintFormat(@"%@%@\n", whitespace, [logString substringWithRange:range]);
            }
            else {
                FLPrintFormat(@"\n");
            }
        
            lastIndex = i + 1;
        }
    }
    
    if(lastIndex < (logString.length - 1)) {
        NSRange  range = NSMakeRange(lastIndex, logString.length - lastIndex); 
        FLPrintFormat(@"%@%@\n", whitespace, [logString substringWithRange:range]);
    }
    
    if(FLTestBits(self.outputFlags, FLLogOutputWithStackTrace)) {
        whitespace = [[FLWhitespace tabbedWithSpacesWhitespace] tabStringForScope:entry.indentLevel + 1];
    
        if(entry.stackTrace.callStack.depth) {
            for(int i = 0; i < entry.stackTrace.callStack.depth; i++) {
                FLPrintFormat(@"%@%s\n", whitespace, [entry.stackTrace stackEntryAtIndex:i]);
            }
        }
    }
    
    if(FLTestAnyBit(self.outputFlags, FLLogOutputWithLocation | FLLogOutputWithStackTrace)) {
        whitespace = [[FLWhitespace tabbedWithSpacesWhitespace] tabStringForScope:entry.indentLevel];                      
        FLPrintFormat(@"%@}\n", whitespace);
    }
}    

@end
