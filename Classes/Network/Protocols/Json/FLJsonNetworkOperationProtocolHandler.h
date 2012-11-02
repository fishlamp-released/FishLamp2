//
//  FLJsonNetworkOperationBehavior.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLHttpOperation.h"

@interface FLJsonNetworkOperationProtocolHandler : NSObject<FLHttpOperationDelegate> {

}

FLSingletonProperty(FLJsonNetworkOperationProtocolHandler);

+ (FLJsonNetworkOperationProtocolHandler*) jsonNetworkOperationProtocolHandler;

@end
