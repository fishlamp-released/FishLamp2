//
//  FLStackTrace_t.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStackTrace.h"

const FLStackTrace_t FLStaceTraceEmpty = { 0, 0, 0, 0, {0, 0}};

void FLStackTraceFree(FLStackTrace_t* trace) {
    if(trace) {
        if(trace->stack.lines) free((void*)trace->stack.lines);
        if(trace->filePath) free((void*)trace->filePath);
        if(trace->function) free((void*)trace->function);
        
        trace->filePath = nil;
        trace->function = nil;
        trace->fileName = nil;
        trace->stack.lines = nil;
        trace->stack.depth = 0;
    }
}


NS_INLINE
const char* __copy_str(const char* str, int* len) {
    if(str != nil) {
        *len = strlen(str);
        char* outStr = malloc(*len + 1);
        strcpy(outStr, str);
        return outStr;
    }
    
    return nil;
}

// [NSThread callStackSymbols]

FLStackTrace_t _FLStackTraceMake(const char* filePath, const char* function, int lineNumber, BOOL withCallStack) {
    void* callstack[128];
    
    FLStackTrace_t trace;
    int len = 0;
    trace.function = __copy_str(function, &len);

    trace.filePath = __copy_str(filePath, &len);
    
    trace.fileName = trace.filePath;
    if(trace.fileName) {
        trace.fileName += len;
        
        while(trace.fileName > trace.filePath) {
            if(*(trace.fileName-1) == '/') {
                break;
            } 
            --trace.fileName;
        }
    }
    
    if(withCallStack) {
        trace.stack.depth = backtrace(callstack, 128) - 1; // minus 1 because we don't want _FLStackTraceMake on the stack.
        trace.stack.lines = (const char**) backtrace_symbols(callstack, trace.stack.depth);
    }
    else {
        trace.stack.depth = 0;
        trace.stack.lines = nil;
    }

    return trace;
}

@implementation FLStackTrace

- (const char*) fileName {
    return _stackTrace.fileName;
}

- (const char*) filePath {
    return _stackTrace.fileName;
}

- (const char*) function {
    return _stackTrace.function;
}

- (int) lineNumber {
    return _stackTrace.lineNumber;
}

- (id) initWithStackTrace:(FLStackTrace_t) stackTrace {
    self = [super init];
    if(self) {
        _stackTrace = stackTrace;
    }
    return self;
}

+ (FLStackTrace*) stackTrace:(FLStackTrace_t) stackTrace {
    return autorelease_([[FLStackTrace alloc] initWithStackTrace:stackTrace]);
}

- (void) dealloc {
    FLStackTraceFree(&_stackTrace);
    mrc_super_dealloc_();
}

- (const char*) stackEntryAtIndex:(int) idx {
    return FLStackEntryAtIndex(_stackTrace.stack, idx);
}

- (FLCallStack) callStack {
    return _stackTrace.stack;
}

@end
