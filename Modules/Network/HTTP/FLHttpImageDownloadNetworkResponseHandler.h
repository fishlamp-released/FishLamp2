//
//	FLDownloadHttpImageNetworkOperationBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 11/13/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLHttpOperation.h"

@interface FLHttpImageDownloadNetworkResponseHandler : NSObject<FLHttpOperationResponseHandler> {
}
FLSingletonProperty(FLHttpImageDownloadNetworkResponseHandler);
@end
