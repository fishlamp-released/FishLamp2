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

@interface FLSoapOperationDelegate : NSObject<FLHttpOperationDelegate> {
@private
    id<FLHttpOperationAuthenticator> _authenticator;
}
@property (readwrite, strong) id<FLHttpOperationAuthenticator> authenticator;

- (void) handleSoapFault:(FLSoapFault11*) fault;
@end

