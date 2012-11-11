//
//  NSError+FLNetworkStream.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSError+FLNetworkStream.h"

@implementation NSError (FLNetworkStream)

// TODO: make this better
// I snagged this from some sample apple code..
+ (NSError*) errorFromStreamError:(CFStreamError) streamError {
    // Convert a CFStreamError to a NSError.  This is less than ideal.  I only handle a 
    // limited number of error constant, and I can't use a switch statement because 
    // some of the kCFStreamErrorDomainXxx values are not a constant.  Wouldn't it be 
    // nice if there was a public API to do this mapping <rdar://problem/5845848> 
    // or a CFHost API that used CFError <rdar://problem/6016542>.

    NSString *      domainStr = nil;
    NSDictionary *  userInfo = nil;
    NSInteger       code = streamError.error;
    
    if (streamError.domain == kCFStreamErrorDomainPOSIX) {
        domainStr = NSPOSIXErrorDomain;
    }
    else if (streamError.domain == kCFStreamErrorDomainMacOSStatus) {
        domainStr = NSOSStatusErrorDomain;
    }
    else if (streamError.domain == kCFStreamErrorDomainNetServices) {
        domainStr = bridge_(NSString*, kCFErrorDomainCFNetwork);
    }
    else if (streamError.domain == kCFStreamErrorDomainNetDB) {
        domainStr = bridge_(NSString*, kCFErrorDomainCFNetwork);
        code = kCFHostErrorUnknown;
        userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:streamError.error], kCFGetAddrInfoFailureKey, nil];
    }
    else {
        // If it's something we don't understand, we just assume it comes from 
        // CFNetwork.
        domainStr = bridge_(NSString*, kCFErrorDomainCFNetwork);
    }

    NSError* error = [NSError errorWithDomain:domainStr code:code userInfo:userInfo];
    FLAssertIsNotNil_v(error, nil);

    return error;
}
@end
