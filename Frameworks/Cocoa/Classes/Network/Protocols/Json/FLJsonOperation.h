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
#import "FLJsonStringBuilder.h"

@interface FLJsonOperation : FLHttpOperation {
@private
	FLJsonStringBuilder* _json;
    id _outputObject;
}

@property (readwrite, strong) id outputObject;
@property (readwrite, strong) FLJsonStringBuilder* json;

@end
