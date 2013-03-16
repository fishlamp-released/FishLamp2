//
//  FLJsonNetworkOperationBehavior.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLHttpRequest.h"
#import "FLJsonStringBuilder.h"

@interface FLJsonHttpRequest : FLHttpRequest {
@private
	FLJsonStringBuilder* _json;
    id _outputObject;
}

@property (readwrite, strong) id outputObject;
@property (readwrite, strong) FLJsonStringBuilder* json;

@end
