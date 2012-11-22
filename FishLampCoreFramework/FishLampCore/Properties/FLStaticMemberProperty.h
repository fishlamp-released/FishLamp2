//
//  FLStaticMemberProperties.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

typedef id (^FLStaticCreateObjectBlock)();

NS_INLINE
id _run_block_to_create_object(FLStaticCreateObjectBlock block) {
    return block();
}

/**
    For example: FLReturnStaticObjectFromBlock((^{ return @"foo"; })); 
    
    Important Note: this won't work if you use a variable length method of any kind in the block. 
    Enclosing block in params is recommended. I've spent a fair amount of time trying to work around this issue 
    with the preprocessor. If You have a solution please let me know.
    
    + (id) foo {
        FLReturnStaticObjectFromBlock((^{ 
           return [NSString stringWithFormat:@"%@ %@", @"hello", @"world"]; 
        }));
    }
 */
#define FLReturnStaticObjectFromBlock(__BLOCK__) \
        static dispatch_once_t pred = 0;; \
        static id s_static_object = nil; \
        dispatch_once(&pred, ^{ \
            s_static_object = retain_(_run_block_to_create_object((FLStaticCreateObjectBlock) __BLOCK__)); \
        }); \
        return s_static_object

/// return a object from a selector called only once.
#define FLReturnStaticObjectFromSelector(TARGET, ACTION) \
        static dispatch_once_t pred = 0; \
        static id s_static_object = nil; \
        dispatch_once(&pred, ^{ s_static_object = retain_([TARGET performSelector:ACTION]); }); \
        return s_static_object
        
#define FLReturnStaticObject(...) \
        static dispatch_once_t pred = 0; \
        static id s_static_object = nil; \
        dispatch_once(&pred, ^{ s_static_object = __VA_ARGS__; }); \
        return s_static_object        