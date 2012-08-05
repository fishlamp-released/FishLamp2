//
//  FLTcpConnector.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTcpConnector.h"
#import "_FLNetworkConnection.h"

@implementation FLTcpConnector 

- (id) initWithHost:(NSString*) host port:(int32_t) port {
    self = [super init];
    if(self) {
        self.remoteHostAddress = host;
        self.remotePort = port;
        self.localPort = port;
    }
    return self;
}

- (void) openNetworkStreams {
    [super openNetworkStreams];

    FLAssertIsNil(self.readStream);
    FLAssertIsNil(self.writeStream);

    CFReadStreamRef readStream = nil;
    CFWriteStreamRef writeStream = nil;
   
    FLAssert(self.remotePort != 0, @"remote port can't be zero");
    FLAssertStringIsNotEmpty(self.remoteHostAddress);
   
    CFHostRef host = CFHostCreateWithName(NULL, (CFStringRef) self.remoteHostAddress);
    if (host != NULL)  {
        CFStreamCreatePairWithSocketToCFHost(NULL, host, self.remotePort, &readStream, &writeStream);
        CFRelease(host);
    }
    
//    if(readStream) {
//        BOOL setReadSecurity = CFReadStreamSetProperty(readStream, kCFStreamPropertySocketSecurityLevel, kCFStreamSocketSecurityLevelNone);
//        
//        FLDebugLog(@"set read security: %d", setReadSecurity);
//    }
//    
//    if(writeStream) {
//        
//        BOOL writeSecurity =  CFWriteStreamSetProperty(writeStream, kCFStreamPropertySocketSecurityLevel, kCFStreamSocketSecurityLevelNone);
//    
//        FLDebugLog(@"set read security: %d", writeSecurity);
//
//    }

//
//CF_EXPORT
//CFStreamStatus CFReadStreamGetStatus(CFReadStreamRef stream);
//CF_EXPORT
//CFStreamStatus CFWriteStreamGetStatus(CFWriteStreamRef stream);


//
//    NSDictionary* networkSettings = (NSDictionary*) CFNetworkCopySystemProxySettings();
//    
//    
//    FLLog([networkSettings description]);
//    
//    FLRelease(networkSettings);
//

    [self setOpenedStreams:writeStream readStream:readStream];
}

+ (id) tcpConnectorWithHost:(NSString*) host port:(int32_t) port {
    return FLReturnAutoreleased([[[self class] alloc] initWithHost:host port:port]);
}

+ (id) tcpConnector {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

@end
