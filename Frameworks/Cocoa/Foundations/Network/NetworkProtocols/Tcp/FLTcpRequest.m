//
//  FLTcpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpRequest.h"

@implementation FLTcpRequest

- (BOOL) readData:(id<FLReadStream>) reader {
    return NO;
}

- (BOOL) writeData:(id<FLReadStream>) writer {
    return NO;
}

+ (FLTcpRequest*) tcpNetworkRequest {
    return FLAutorelease([[[self class] alloc] init]);
}


@end