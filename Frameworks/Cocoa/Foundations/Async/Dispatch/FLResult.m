//
//  FLResult.m
//  FLCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResult.h"
#import "FLFrameworkErrorDomain.h"

@implementation FLResultObject 

- (NSError*) error {
    return nil;
}

- (BOOL) failed {
    return NO;
}

- (BOOL) succeeded {
    return YES;
}

- (id) result {
    return self;
}

@end

@implementation NSObject (FLResultObject)
- (NSError*) error {
    return nil;
}

- (BOOL) failed {
    return NO;
}

- (BOOL) succeeded {
    return YES;
}

- (id) result {
    return self;
}

@end

@implementation NSError (FLResultObject)

- (BOOL) failed {
    return YES;
}

- (BOOL) succeeded {
    return NO;
}

- (NSError*) error {
    return self;
}

- (id) result {
    return nil;
}


@end

@implementation FLSuccessfulResult

+ (id) successfullResult {
    FLReturnStaticObject([[[self class] alloc] init]);
}

@end


@implementation FLMutableResult

@synthesize result = _result;

- (id) init {
    self = [super init];
    if(self) {
        self.result = FLSuccessfullResult;
    }
    return self;
}

- (id) initWithResult:(id) result {
    self = [super init];
    if(self) {
        self.result = result;
    }
    return self;
}

- (NSError*) error {
    return [self.result error];
}

+ (id) mutableResult {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) mutableResultWithResult:(id) result {
    return FLAutorelease([[[self class] alloc] initWithResult:result]);
}

- (BOOL) succeeded {
    return [self.result succeeded];
}

- (BOOL) failed {
    return [self.result failed];
}

@end

@implementation NSError (FLResult)
+ (id) failedResultError {
    return [NSError errorWithDomain:[FLFrameworkErrorDomain instance]
                               code:FLErrorResultFailed
                               userInfo:nil
                               reason:@"Result failed"
                               comment:@"derp"
                               stackTrace:nil];
}
@end


//id FLMakeResult(id result) {
//    if(!result) {
//        return [FLSuccessfulResult successfullResult];
//    }
//    
//    if([result error]) {
//        return result;
//    }
//    
//    return result;
//}
//
//
