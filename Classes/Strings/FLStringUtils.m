//
//  FLStringUtils.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLStringUtils.h"

#if DEBUG
#include "_FLStringUtils.h"
#endif 

NSString* FLStringWithFormatOrNil(NSString* format, ...) {
    if(format) {
        va_list va;
        va_start(va, format);
        NSString* string = FLReturnAutoreleased([[NSMutableString alloc] initWithFormat:format arguments:va]);
        va_end(va);
        return string;
    }
    
    return @"";
}
