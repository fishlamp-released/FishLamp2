//
//  FLAbstractDispatcher.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncQueue.h"
#import "FLFinisher.h"
#import "FLSelectorPerforming.h"

FLFinisher* FLDispatchSelectorAsync0(id<FLAsyncQueue> queue, 
                                    id target, 
                                    SEL selector, 
                                    fl_completion_block_t completion) {

    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector:selector]; 
        } completion:completion];
    }
    
    return nil;
}

FLFinisher* FLDispatchSelectorAsync1(id<FLAsyncQueue> queue, 
                                              id target, 
                                              SEL selector, 
                                              id object, 
                                              fl_completion_block_t completion) {
    
    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector:selector withObject:object]; 
        } completion:completion];
    }
    
    return nil;
}

FLFinisher* FLDispatchSelectorAsync2(id<FLAsyncQueue> queue, 
                                                  id target, 
                                                  SEL selector, 
                                                  id object1, 
                                                  id object2,
                                                  fl_completion_block_t completion) {
    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector:selector withObject:object1 withObject:object2]; 
        } completion:completion];
    }
    
    return nil;
}


FLFinisher* FLDispatchSelectorAsync3(id<FLAsyncQueue> queue, 
                                                id target, 
                                                SEL selector, 
                                                id object1, 
                                                id object2, 
                                                id object3, 
                                                fl_completion_block_t completion) {
    
    if([target respondsToSelector:selector]) {
        return [queue queueBlock:^{ 
            [target performSelector:selector withObject:object1 withObject:object2 withObject:object3]; 
        } completion:completion];
    }
    
    return nil;

}

BOOL FLDispatchSelectorSync0(id<FLAsyncQueue> queue, 
                                    id target, 
                                    SEL selector) {

    if([target respondsToSelector:selector]) {
        [queue dispatchSync:^{ 
            [target performSelector:selector]; 
        }];

        return YES;
    }
    
    return NO;
}

BOOL FLDispatchSelectorSync1(id<FLAsyncQueue> queue, 
                                      id target, 
                                      SEL selector, 
                                      id object) {
                                      
    if([target respondsToSelector:selector]) {
        [queue dispatchSync:^{ 
            [target performSelector:selector withObject:object]; } 
        ];
    }
    
    return NO;
}

BOOL FLDispatchSelectorSync2(id<FLAsyncQueue> queue, 
                                          id target, 
                                          SEL selector, 
                                          id object1, 
                                          id object2) {
                                          
    if([target respondsToSelector:selector]) {
        [queue dispatchSync:^{ 
            [target performSelector:selector withObject:object1 withObject:object2]; } 
        ];
        
        return YES;
    }
    
    return NO;
}


BOOL FLDispatchSelectorSync3(id<FLAsyncQueue> queue, 
                                        id target, 
                                        SEL selector, 
                                        id object1, 
                                        id object2, 
                                        id object3) {
                                        
    if([target respondsToSelector:selector]) {
        [queue dispatchSync:^{ 
            [target performSelector:selector withObject:object1 withObject:object2 withObject:object3]; } 
        ];

        return YES;
    }
    
    return NO;
}
