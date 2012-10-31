//
//  FLStaticMemberProperties.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

/// this won't work if you use a variable length method of any kind in the block. Enclosing block in params is recommended. 

/// For example: FLReturnStaticObjectFromBlock((^{ return @"foo"; })); 
/// Note: I've spent a fair amount of time trying to work around this issue with the preprocessor. If You have a solution please let me know.
#define FLReturnStaticObjectFromBlock(__CREATE_BLOCK) \
        static dispatch_once_t pred; \
        static id s_static_object = nil; \
        dispatch_once(&pred, ^{ s_static_object = retain_(__CREATE_BLOCK()); }); \
        return s_static_object

/// return a object from a selector called only once.
#define FLReturnStaticObjectFromSelector(TARGET, ACTION) \
        static dispatch_once_t pred; \
        static id s_static_object = nil; \
        dispatch_once(&pred, ^{ s_static_object = retain_([TARGET performSelector:ACTION]); }); \
        return s_static_object