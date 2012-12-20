//
//  FLTcpConnection_Internal.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpConnection.h"

@interface FLTcpConnection ()
+ (FLTcpConnection*) tcpConnection;
@end

@interface FLTcpConnectionWriter ()
- (id) initWithConnection:(FLTcpConnection*) connection;
@end

@interface FLTcpConnectionReader ()
- (id) initWithConnection:(FLTcpConnection*) connection;
@end