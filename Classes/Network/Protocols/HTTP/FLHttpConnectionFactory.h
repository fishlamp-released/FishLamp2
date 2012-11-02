//
//  FLHttpNetworkRequestFactory.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/20/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLHttpOperation.h"

@interface FLHttpConnectionFactory : NSObject<FLHttpOperationDelegate> {
}
FLSingletonProperty(FLHttpConnectionFactory);
@end
