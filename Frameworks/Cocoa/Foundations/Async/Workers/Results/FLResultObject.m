//
//  FLResult.m
//  FLCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResultObject.h"

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

@implementation NSObject (FLResulting)
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

@implementation NSError (FLResulting)

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
