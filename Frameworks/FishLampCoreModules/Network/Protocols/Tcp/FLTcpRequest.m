//
//  FLTcpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpRequest.h"

@implementation FLTcpRequest

@synthesize wantsWrite = _wantsWrite;
@synthesize wantsRead = _wantsRead;

- (id) init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

- (BOOL) readData:(FLTcpConnectionReader*) reader {
    return NO;
}

- (BOOL) writeData:(FLTcpConnectionWriter*) writer {
    return NO;
}

+ (FLTcpRequest*) tcpNetworkRequest {
    return autorelease_([[[self class] alloc] init]);
}


@end