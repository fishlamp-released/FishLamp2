//
//  FLExceptions.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLExceptions.h"

id FLThrowErrorIfNeeded(id object) {
    if(!object) {
        return nil;
    }
    NSError* error = [object error];
    if(!error) { 
        return error;
    }

    @throw [NSException exceptionWithError:[FLMutableError mutableErrorWithError:error stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]];
}

#if DEBUG
#define __INLINES__ 
#include "FLExceptions_Inlines.h"
#undef __INLINES__
#endif
