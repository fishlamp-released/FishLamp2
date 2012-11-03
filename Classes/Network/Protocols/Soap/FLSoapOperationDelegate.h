//
//	FLSoapNetworkRequestBehavior.h
//	FishLampCoreLib
//
//	Created by Mike Fullerton on 11/7/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLSoapFault11.h"
#import "FLSoapError.h"
#import "FLHttpOperationAuthenticator.h"

@protocol FLSoapServerInfo <NSObject>
- (NSString*) soapNamespace;
- (NSURL*) serverURL;
- (NSString*) soapActionHeaderForOperationName:(NSString*) operationName;
@end

@interface FLSoapServerInfo : NSObject<FLSoapServerInfo> {
@private
    NSDictionary* _soapServerInfo;
}
+ (FLSoapServerInfo*) soapServerInfo:(NSDictionary*) dictionary;
@end

@interface FLSoapOperationDelegate : NSObject<FLHttpOperationDelegate> {
@private
    id<FLHttpOperationAuthenticator> _authenticator;
    id<FLSoapServerInfo> _soapServerInfo;
}
@property (readwrite, strong) id<FLSoapServerInfo> soapServerInfo;
@property (readwrite, strong) id<FLHttpOperationAuthenticator> authenticator;
- (void) handleSoapFault:(FLSoapFault11*) fault;

@end

