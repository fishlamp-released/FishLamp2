//
//  NSError+FLResult.m
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSError+FLResult.h"
#import "FLFrameworkErrorDomain.h"

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
