//
//  FLResult.m
//  FLCore
//
//  Created by Mike Fullerton on 11/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResult.h"
#import "FLErrorCodes.h"

@implementation NSObject (FLResultObject)
- (NSError*) error {
    return nil;
}

- (BOOL) isErrorResult {
    return NO;
}

@end

@implementation NSError (FLResultObject)

- (BOOL) isErrorResult {
    return YES;
}

- (NSError*) error {
    return self;
}

@end

@implementation NSError (FLResult)
+ (id) failedResultError {
    return [NSError errorWithDomain:FLErrorDomain
                               code:FLErrorResultFailed
               localizedDescription:NSLocalizedString(@"An operation failed.", nil)
                           userInfo:nil
                            comment:nil];
}
@end

