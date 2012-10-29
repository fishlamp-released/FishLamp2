//
//  FLWorker.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorker.h"

@interface FLWorker ()
@property (readwrite, copy) FLWorkerBlock asyncWorkerBlock;
@end

@implementation FLWorker

@synthesize asyncWorkerBlock = _asyncWorkerBlock;

- (id) initWithAsyncWorkerBlock:(FLWorkerBlock) block {
    self = [super init];
    if(self) {
        self.asyncWorkerBlock = block;
    }
    return self;
}
+ (id) asyncWorker:(FLWorkerBlock) block {
    return FLReturnAutoreleased([[[self class] alloc] initWithAsyncWorkerBlock:block]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_asyncWorkerBlock release];
    [super dealloc];
}
#endif

- (void) startWorking:(id<FLFinisher>) finisher {
    if(_asyncWorkerBlock) {
        _asyncWorkerBlock(finisher);
    }
    else {
        [finisher setFinished];
    }
}

@end

@interface FLResult ()
@property (readwrite, strong, nonatomic) NSError* error;
@property (readwrite, strong, nonatomic) id output;
@end

@implementation FLResult 
@synthesize error = _error;
@synthesize output = _returnedObject;

- (BOOL) didSucceed {
    return _error == nil;
}

- (id) initWithOutput:(id) object {
    self = [super init];
    if(self) {
        self.output = object;
    }
    return self;
}

- (id) initWithError:(NSError*) error {
    self = [super init];
    if(self) {
        
        self.error = error;
    }
    return self;
}

- (BOOL) finishedSynchronously {
    return YES;
}

+ (id) result:(id) output {
    return FLReturnAutoreleased([[[self class] alloc] initWithObject:output]);
}

+ (id) resultWithError:(NSError*) error  {
    return FLReturnAutoreleased([[[self class] alloc] initWithError:error]);
}

#if FL_NO_ARC
- (void) dealloc {
    [_error release];
    [_returnedObject release];
    [super dealloc];
}
#endif

@end

@implementation FLAsyncResult 
- (BOOL) finishedSynchronously {
    return YES;
}
@end

