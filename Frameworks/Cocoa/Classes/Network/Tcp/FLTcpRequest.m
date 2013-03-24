//
//  FLTcpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpRequest.h"
#import "FLReadStream.h"
#import "FLWriteStream.h"

@implementation FLTcpRequest

- (BOOL) readData:(FLReadStream*) reader {
    return NO;
}

- (BOOL) writeData:(FLReadStream*) writer {
    return NO;
}

+ (FLTcpRequest*) tcpNetworkRequest {
    return FLAutorelease([[[self class] alloc] init]);
}


@end