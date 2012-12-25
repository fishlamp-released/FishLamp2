//
//  FLStackTrace_t.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLRequired.h"

#import <execinfo.h>
#import <objc/runtime.h>

typedef struct {
    const char** lines;
    NSUInteger depth;
} FLCallStack;

typedef struct {
    const char* filePath;
    const char* fileName;
    const char* function;
    int lineNumber;
    FLCallStack stack;
} FLStackTrace_t;

extern void FLStackTraceInit(FLStackTrace_t* stackTrace, void* callstack);
extern void FLStackTraceFree(FLStackTrace_t* trace);

extern FLStackTrace_t FLStackTraceMake( const char* filePath, 
                                        const char* function, 
                                        int lineNumber, 
                                        BOOL withCallStack);

NS_INLINE
const char* FLStackEntryAtIndex(FLCallStack stack, NSUInteger index) {
    return (index < stack.depth) ? stack.lines[index] : nil;
}

// OBJECT

@interface FLStackTrace : NSObject {
@private
    FLStackTrace_t _stackTrace;
}

// use FLCreateStackTrace instead of this method
+ (FLStackTrace*) stackTrace:(FLStackTrace_t) willTakeOwnershipOfTrace;

@property (readonly, assign, nonatomic) const char* fileName;
@property (readonly, assign, nonatomic) const char* filePath;
@property (readonly, assign, nonatomic) const char* function;
@property (readonly, assign, nonatomic) int lineNumber;
@property (readonly, assign, nonatomic) FLCallStack callStack;

- (const char*) stackEntryAtIndex:(int) idx;
@end


#define FLStackTraceToHere(__WITH_STACK_TRACE__) \
            FLStackTraceMake(__FILE__, __PRETTY_FUNCTION__, __LINE__, __WITH_STACK_TRACE__)

#define FLCreateStackTrace(__WITH_STACK_TRACE__) \
            [FLStackTrace stackTrace:FLStackTraceToHere(__WITH_STACK_TRACE__)]



