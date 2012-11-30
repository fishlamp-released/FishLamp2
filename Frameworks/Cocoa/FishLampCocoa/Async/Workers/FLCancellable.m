//
//  FLCancellable.m
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCancellable.h"
#import "FLFinisher.h"

@interface FLCancellable ()
@property (readwrite, strong) NSMutableArray* cancelled;
@property (readwrite, assign) BOOL wasCancelled;
@end

@implementation FLCancellable 

@synthesize cancelled = _cancelled;
@synthesize wasCancelled = _wasCancelled;

- (id) init {
    self = [super init];
    if(self) {
        _cancelled = [[NSMutableArray alloc] init];
        _dependents= [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id) cancelHandler {
    return autorelease_([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_dependents release];
    [_cancelled release];
    [super dealloc];
}
#endif


- (void) reset {
    self.wasCancelled = NO;
    [_cancelled removeAllObjects];
}

- (FLFinisher*) requestCancel:(FLResultBlock) completion {
    @synchronized(self) {
        self.wasCancelled = YES;
    
        FLFinisher* finisher = [FLFinisher finisherWithResultBlock:completion];
        [self.cancelled addObject:finisher];
        
        for(id<FLCancellable> obj in _dependents) {
            [obj requestCancel:nil];
        }
        
        return finisher;
    }
}

- (FLResult) setFinished:(FLResult) result {

    if(_cancelled.count) {
        result = [NSError cancelError];
        
        for(FLFinisher* finisher in _cancelled) {
            [finisher setFinishedWithResult:result];
        }
        
        [_cancelled removeAllObjects];
    }
    
    return result;
}

- (void) addDependent:(id<FLCancellable>) dependent {
    @synchronized(self) {
        [_dependents addObject:dependent];
    }
}

- (void) removeDependent:(id<FLCancellable>) dependent {
    @synchronized(self) {
        [_dependents removeObject:dependent]    ;
    }
}

- (FLResult) runBlock:(FLResult (^)()) block forDependent:(id<FLCancellable>) dependent {

    @try {
        [self addDependent:dependent];
        if(self.wasCancelled) {
            return [NSError cancelError];
        }
        
        if(block) {
            return block();
        }
    }
    @catch(NSException* ex) {
        return ex.error;
    }
    @finally {
        [self removeDependent:dependent];
    }
    
    return nil;
}


@end