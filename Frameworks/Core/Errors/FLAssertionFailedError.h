//
//  FLAssertionFailedError.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLErrorException.h"

#import "FLAssertionFailureErrorDomain.h"

@interface FLAssertionFailedError : NSError
+ (id) assertionFailedError:(NSInteger) code 
                     reason:(NSString*) reason 
                    comment:(NSString*) comment ;
@end

extern NSString* const FLAssertionFailedExceptionName;

@interface FLAssertionFailedException : FLErrorException
@end
