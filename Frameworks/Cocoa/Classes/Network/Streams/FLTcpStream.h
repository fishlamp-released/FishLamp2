//
//  FLTcpStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

#import "FLReadStream.h"
#import "FLWriteStream.h"
#import "FLAbstractNetworkStream.h"

@interface FLTcpStream : FLAbstractNetworkStream<FLConcreteNetworkStream> {
@private
    NSString* _remoteHost;
    int32_t _remotePort;
    FLReadStream* _readStream;
	FLWriteStream* _writeStream;
}
@property (readonly, strong) FLReadStream* readStream;
@property (readonly, strong) FLWriteStream* writeStream;

@property (readonly, assign, nonatomic) int32_t remotePort;
@property (readonly, strong) NSString* remoteHost;

- (id) initWithRemoteHost:(NSString*) address remotePort:(int32_t) port;

+ (id) tcpStream:(NSString*) address remotePort:(int32_t) port;

@end

extern NSString* const FLTcpStreamWriteErrorKey;
extern NSString* const FLTcpStreamReadErrorKey;

@interface NSError (FLTcpStream)
@property (readonly, strong, nonatomic) NSError* writeError;
@property (readonly, strong, nonatomic) NSError* readError;
+ (NSError*) tcpStreamError:(NSError*) readError writeError:(NSError*) writeError;
@end

