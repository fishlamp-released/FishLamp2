//
//  FLStackTrace_t.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStackTrace.h"
#import "FLPrettyString.h"

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

FLStackTrace_t FLStackTraceMake(    const char* filePath, 
                                    const char* function, 
                                    int lineNumber, 
                                    BOOL withCallStack) {
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
    return FLAutorelease([[FLStackTrace alloc] initWithStackTrace:stackTrace]);
}

- (void) dealloc {
    FLStackTraceFree(&_stackTrace);
#if FL_MRC
    [super dealloc];
#endif
}


- (const char*) stackEntryAtIndex:(int) idx {
    return FLStackEntryAtIndex(_stackTrace.stack, idx);
}

- (FLCallStack) callStack {
    return _stackTrace.stack;
}

- (int) stackDepth {
    return _stackTrace.stack.depth;
}

- (void) describe:(FLPrettyString*) string {
    [string appendLine:[NSString stringWithFormat:@"%s:%d, %s", 
                          _stackTrace.fileName, 
                          _stackTrace.lineNumber, 
                          _stackTrace.function]];
    [string indent:^{
        for(int i = 0; i < self.stackDepth; i++) {
            [string appendLine:[NSString stringWithFormat:@"%s", [self stackEntryAtIndex:i]]];
        }
    }];
}

- (NSString*) description {
    FLPrettyString* str = [FLPrettyString prettyString];
    [self describe:str];
    return [str string];
}

//- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state 
//                                  objects:(id __unsafe_unretained [])buffer 
//                                    count:(NSUInteger)len {
//	
//    unsigned long currentIndex = state->state;
//    if(currentIndex >= _stackTrace.depth) {
//		return 0;
//	}
//	
//    state->state = MIN(_stackTrace.depth - 1, currentIndex + len);
//
//    NSUInteger count = state->state - currentIndex;
//
//    int bufferIndex = 0;
//    for(int i = currentIndex; i < count; i++) {
//        buffer[bufferIndex] = FLStackEntryAtIndex(_stackTrace.stack, idx);
//    }
//
//    state->itemsPtr = buffer;
//    
//    // this is an immutable object, so it will never be mutated
//    static unsigned long s_mutations = 0;
//    
//	state->mutationsPtr = &s_mutations;
//	return count;
//}



@end
