//
//  FLErrors.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLStackTrace.h"

#import "NSError+FLExtras.h"
#import "FLMutableError.h"
#import "FLErrorDomainInfo.h"

#import "FLCancelError.h"

#import "FLExceptions.h"
#import "FLErrorException.h"

#import "FLAssertions.h"
/*
// sdk files with error codes:
https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorObjectsDomains/ErrorObjectsDomains.html

errno.h
MacErrors.h
CFNetworkErrors.h
NSErrors.h
FoundationErrors.h
SecureTransport.h
kern_return.h
*/