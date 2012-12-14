//
//  NSError+FLNetworkStream.h
//  FLCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (FLStreamController)
+ (NSError*) errorFromStreamError:(CFStreamError) streamError;
@end

NS_INLINE
NSError* FLCreateErrorFromStreamError(const CFStreamError* streamError) {
    if(streamError && streamError->domain != 0 && streamError->error != 0) {
        return [NSError errorFromStreamError:*streamError];
    }
    
    return nil;
}
