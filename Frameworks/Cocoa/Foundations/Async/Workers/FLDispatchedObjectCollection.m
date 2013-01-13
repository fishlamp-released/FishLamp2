//
//  FLDispatchedObjectCollection.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDispatchedObjectCollection.h"
#import "FLDispatchQueue.h"

@implementation FLDispatchedObjectCollection

@synthesize dispatcher = _dispatcher;

- (id) init {
    self = [super init];
    if(self) {
        _objects = [[NSCountedSet alloc] init];
        self.dispatcher = FLFifoQueue;
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_objects release];
    [_dispatcher release];
    [super dealloc];
}
#endif

+ (id) dispatcherContext {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLCompletionBlock) completion {

    visitor = FLCopyWithAutorelease(visitor);

    return [self.dispatcher dispatchBlock:^{
        
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

//- (void) willDispatchObject:(id) object {
//    FLPerformSelector1(object, @selector(didMoveToContext:), self);
//    [self addObject:object];
//}
//
//- (void) didDispatchObject:(id) object {
//  
//    FLPerformSelector1(object, @selector(didMoveToContext:), nil);
//    [self removeObject:object];
//}

- (void) addObject:(id) object {
    [self.dispatcher dispatchBlock:^{
        [_objects addObject:object];
    }];
}

- (void) removeObject:(id) object {
    [self.dispatcher dispatchBlock:^{
        [_objects removeObject:object];
    }];
}


   
   
@end
