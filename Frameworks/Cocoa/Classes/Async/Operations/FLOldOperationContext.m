//
//  FLOperationContext.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "FLOperationContext.h"

@implementation FLOperationContextManager

+ (id) operationContextManager {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
	if((self = [super init])) {
		_contexts = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) dealloc {
//    for(FLOperationContext* context in _contexts) {
//        [context removeObserver:self];
//    }

#if FL_MRC
    [_contexts release];
    [super dealloc];
#endif
}

- (void) activateContext:(FLOperationContext*) context {
    @synchronized(self) {
        if([_contexts indexOfObject:context] == NSNotFound ) {
//            [context addObserver:self];
            [_contexts addObject:context];
        }
    }
}

- (void) deactivateContext:(FLOperationContext*) context {
    @synchronized(self) {
        [context requestCancel];
//        [context removeObserver:self];
        [_contexts removeObject:context];
    }
}

- (void) cancelAllOperations {
    for(FLOperationContext* context in _contexts) {
        [context requestCancel];
    }
}

- (BOOL) isBusy {
    for(FLOperationContext* context in _contexts) {
        if(context.isBusy) {
            return YES;
        }
    }

    return NO;
}

@end

@implementation FLOperationContext

+ (id) operationContext {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) isBusy {
    return self.count > 0;
}

- (void) operationDidFinish:(FLSynchronousOperation*) operation {
    [self removeOperation:operation];
}

@end
#endif