//
//  FLAbortException.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAbortException.h"
#import "FLFrameworkErrorDomain.h"
#import "NSError+FLExtras.h"
#import "FLErrorDomain.h"
#import "NSException+NSError.h"

@implementation FLAbortException
+ (FLAbortException*) abortException {
    return FLAutorelease([[[self class] alloc] initWithName:@"abort" reason:@"abort" userInfo:nil error:[NSError abortError]]);
}
+ (void) raise {
    @throw [FLAbortException abortException];
}
@end

@implementation NSError (FLAbort)

- (BOOL) isAbortError {
    return [self isErrorCode:FLAbortErrorCode domain:[[FLFrameworkErrorDomain instance] errorDomainString]];
}

+ (id) abortError {
    return [NSError errorWithDomain:[FLFrameworkErrorDomain instance]
                               code:FLAbortErrorCode 
                           userInfo:nil
                             reason:@"aborted"
                            comment:@"throwing abort exception"
                         stackTrace:nil];
}
@end

