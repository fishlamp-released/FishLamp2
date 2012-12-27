//
//  FLObjectPool.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObjectPool.h"
#import "FLDispatchQueue.h"

@implementation NSObject (FLObjectPool)
FLSynthesizeAssociatedProperty(retain_nonatomic, objectPool, setObjectPool, FLObjectPool*);
@end

@implementation FLObjectPool

+ (id) objectPool {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) objectPoolWithFactory:(FLObjectPoolFactory) factory {
    return FLAutorelease([[[self class] alloc] initWithObjectFactory:factory]);
}

- (id) initWithObjectFactory:(FLObjectPoolFactory) factory {

    self = [super init];
    if(self) {
        _factory = [factory copy];
        _objects = [[NSMutableArray alloc] init];
        _requests = [[NSMutableArray alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_factory release];
    [_objects release];
    [_requests release];
    [super dealloc];
}
#endif

- (id) popOneFromPool {
    id object = [_objects popFirstObject];
    if(!object && _factory) {
        object = _factory();
    }
    if(object) {
        [object setObjectPool:self];
    }
    return object;
}


- (void) fufillRequests {
    while(_requests.count) {
        BOOL done = YES;
        id object = [self popOneFromPool];
        if(object) {
            FLObjectPoolBlock block = [_requests popFirstObject];
            if(block) {
                block(object);
                
                done = NO;
            }
        }

        if(done) {
            break;
        }
    }
}

- (void) requestPooledObject:(FLObjectPoolBlock) block {
    block = FLAutoreleasedCopy(block);
    
    [FLFifoQueue dispatchBlock:^{
        [_requests addObject:block];
        [self fufillRequests];

    }];
}

- (void) releasePooledObject:(id) objectForPool {
    [FLFifoQueue dispatchBlock:^{
        [_objects addObject:objectForPool];
        [objectForPool setObjectPool:nil];
        [self fufillRequests];
    }];
}

- (void) stockPool:(NSArray*) withObjects {
    [FLFifoQueue dispatchBlock:^{
        [_objects addObjectsFromArray:withObjects];
    }];
}

@end

void FLReleasePooledObject( id __strong * object) {
    if(object && *object) {
        [[*object objectPool] releasePooledObject:*object];
        *object = nil;
    }
}
