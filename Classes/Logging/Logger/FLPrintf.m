//
//  FLPrintf.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPrintf.h"

void FLPrintf(NSString* format, ...) {

    if(FLStringIsEmpty(format)) {
        return;
    }
     
    va_list va;
    va_start(va, format);
    NSString* string = [[NSMutableString alloc] initWithFormat:format arguments:va];
    va_end(va);
    
    const char* c_str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    if(c_str) {
        printf("%s", c_str);
    }
    
    mrc_release_(string);
    
}