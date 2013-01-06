//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLStream.h"

#define FLNetworkStreamDefaultTimeout 120.0f

@interface FLNetworkStream : FLStream {
}

- (void) failIfUnreachable;
- (BOOL) checkReachability;

@end