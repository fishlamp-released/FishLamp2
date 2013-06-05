//
//  FLAssertionFailedError.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/20/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
