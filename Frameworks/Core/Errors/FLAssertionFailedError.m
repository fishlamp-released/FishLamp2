//
//  FLAssertionFailedError.m
//  FishLampCore
//
//  Created by Mike Fullerton on 3/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAssertionFailedError.h"

@implementation FLAssertionFailedError

+ (id) assertionFailedError:(NSInteger) code 
                     reason:(NSString*) reason 
                    comment:(NSString*) comment {
 
    return [self errorWithDomain:FLAssertionFailureErrorDomain code:code localizedDescription:reason userInfo:nil comment:comment];                                                     
}                    

- (NSException*) createException:(NSDictionary *)userInfo {
    return [FLAssertionFailedException exceptionWithName:FLAssertionFailedExceptionName reason:self.localizedDescription userInfo:userInfo];
}

@end

NSString* const FLAssertionFailedExceptionName = @"com.fishlamp.exception.assertion-failed";

@implementation FLAssertionFailedException

@end
