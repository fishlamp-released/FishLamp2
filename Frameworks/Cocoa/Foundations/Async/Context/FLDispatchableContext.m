//
//  FLDispatchableContext.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDispatchableContext.h"

@implementation FLDispatchableContext

- (id) init {
    self = [super init];
    if(self) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_objects release];
    [super dealloc];
}
#endif

+ (id) dispatchableContext {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLCompletionBlock) completion {

    visitor = FLCopyWithAutorelease(visitor);

    return [self dispatchBlock:^{
        
        BOOL stop = NO;
        for(id object in _objects) {
            visitor(object, &stop);
            
            if(stop) {
                break;
            }
        }
        
    } 
    completion:completion];
}

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor {
    return [self visitObjects:visitor completion:nil];
}

- (void) requestCancel {
    [self visitObjects:^(id object, BOOL* stop) {
        FLPerformSelector(object, @selector(requestCancel));
    }];
}

- (void) willDispatchObject:(id) object{
    FLPerformSelector1(object, @selector(didMoveToContext:), self);
    [_objects addObject:object];
}

- (void) didDispatchObject:(id) object {
  
    FLPerformSelector1(object, @selector(didMoveToContext:), nil);
    [self dispatchBlock:^{
            // queue up our remove.
            [_objects removeObject:object];
        }];
}

- (FLFinisher*) dispatchObject:(id) object 
                    completion:(FLCompletionBlock) completion {

    FLAssertNotNil_(object);

    FLFinisher* finisher = [FLScheduledFinisher finisher:completion];

    return [self dispatchBlock: ^{
        
        [self willDispatchObject:object];
        
        FLFinisher* objectFinisher = [FLFinisher finisher:^(FLResult result) {
            [finisher setFinishedWithResult:result];
            [self didDispatchObject:object];
        }];
        
        @try {
            [object startWorking:objectFinisher];
        }
        @catch(NSException* ex) {
            [objectFinisher setFinishedWithResult:ex.error];
        }
    }];
    
    return finisher;
}
         

@end


//- (void) willStartRequest:(FLHttpRequest*) request  {
//                
//}
//
//- (void) sendRequest:(FLHttpRequest*) request
//            finisher:(FLFinisher*) finisher  {
//    
//    [_dispatcher dispatchBlock: ^{
//        [_objects addObject:request];
//        [self willStartRequest:request];
//        [ ((id)request) startWorking:finisher];
//    }
//    completion:^(FLResult result) {
//        
//        // this is the completion for the finisher created by dispatchFinishableBlock
//        // we needed to intercept this to remove request from our queue.
//        
//        [_dispatcher dispatchBlock:^{
//            // queue up our remove.
//            [_objects removeObject:request];
//        }];
//        
//    }];
//}
//
//- (FLFinisher*) sendRequest:(FLHttpRequest*) request {
//    FLFinisher* finisher = [FLFinisher finisher];
//    [self sendRequest:request finisher:finisher];
//    return finisher;
//}
//
//- (FLFinisher*) sendRequest:(FLHttpRequest*) request 
//                 completion:(FLCompletionBlock) completion {
//
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//    [self sendRequest:request finisher:finisher];
//    return finisher;
//}   