//
//  FLException_Inlines.h
//  FLCocoa
//
//  Created by Mike Fullerton on 12/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

FL_SHIP_ONLY_INLINE
id FLThrowError(id object) {
    NSError* error = [object error];
    if(error) { 
        @throw [NSException exceptionWithError:[FLMutableError mutableErrorWithError:error stackTrace:FLCreateStackTrace(__INCLUDE_STACK_TRACE__)]];
    }
    return object;
}