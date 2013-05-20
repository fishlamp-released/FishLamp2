//
//	GtSoapNetworkRequestBehavior.h
//	FishLampCoreLib
//
//	Created by Mike Fullerton on 11/7/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"

@interface GtSoapNetworkOperationResponseHandler : NSObject<GtHttpOperationResponseHandler> {
}

GtSingletonProperty(GtSoapNetworkOperationResponseHandler);

@end


@interface GtSoapNetworkRequestFactory : NSObject<GtHttpConnectionFactory>
GtSingletonProperty(GtSoapNetworkRequestFactory);
@end