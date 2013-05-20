//
//	GtDownloadHttpImageNetworkOperationBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 11/13/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtHttpOperation.h"

@interface GtHttpImageDownloadNetworkResponseHandler : NSObject<GtHttpOperationResponseHandler> {
}
GtSingletonProperty(GtHttpImageDownloadNetworkResponseHandler);
@end
