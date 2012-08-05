//
//  FLJsonNetworkOperationBehavior.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLHttpOperation.h"

@interface FLJsonNetworkOperationProtocolHandler : NSObject<FLHttpOperationResponseHandler> {

}

FLSingletonProperty(FLJsonNetworkOperationProtocolHandler);

+ (FLJsonNetworkOperationProtocolHandler*) jsonNetworkOperationProtocolHandler;

@end
