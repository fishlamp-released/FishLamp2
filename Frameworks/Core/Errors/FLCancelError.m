//
//  FLCancelError.m
//  FishLampCore
//
//  Created by Mike Fullerton on 3/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCancelError.h"

NSString* const FLCancelExceptionName = @"com.fishlamp.exception.cancel";

@implementation FLCancelError
- (BOOL) isCancelError {
    return YES;
}

- (NSException*) createException:(NSDictionary *)userInfo {
    return [FLCancelException exceptionWithName:FLCancelExceptionName reason:self.localizedDescription userInfo:userInfo];
}

@end

@implementation NSError (FLCancelling)

+ (NSError*) cancelError {
    return [FLCancelError errorWithDomain:FLFrameworkErrorDomain
                               code:FLCancelErrorCode
               localizedDescription:NSLocalizedString(@"Cancelled", @"used in cancel error localized description")];

}

- (BOOL) isCancelError {
	return	FLStringsAreEqual(FLFrameworkErrorDomain, self.domain) && self.code == FLCancelErrorCode; 
}

@end

@implementation FLCancelException
@end