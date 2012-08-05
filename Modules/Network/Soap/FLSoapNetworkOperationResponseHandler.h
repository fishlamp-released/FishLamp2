//
//	FLSoapNetworkRequestBehavior.h
//	FishLampCoreLib
//
//	Created by Mike Fullerton on 11/7/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"

@interface FLSoapNetworkOperationResponseHandler : NSObject<FLHttpOperationResponseHandler> {
}

FLSingletonProperty(FLSoapNetworkOperationResponseHandler);

@end


@interface FLSoapNetworkRequestFactory : NSObject<FLHttpConnectionFactory>
FLSingletonProperty(FLSoapNetworkRequestFactory);
@end