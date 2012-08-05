//
//  FLExceptions.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLExceptions.h"

static FLExceptionHook s_exceptionHook = nil;

void FLSetExceptionHook(FLExceptionHook hook) {
    s_exceptionHook = hook;
}

FLExceptionHook FLGetExceptionHook() {
    return s_exceptionHook;
}

