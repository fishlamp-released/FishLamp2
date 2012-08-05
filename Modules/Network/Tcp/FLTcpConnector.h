//
//  FLTcpConnector.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLTcpConnection.h"


@interface FLTcpConnector : FLTcpConnection {
@private
}

- (id) initWithHost:(NSString*) host port:(int32_t) port;

+ (id) tcpConnectorWithHost:(NSString*) host port:(int32_t) port;
+ (id) tcpConnector;

@end