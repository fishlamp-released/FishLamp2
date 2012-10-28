//
//  FLJsonRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLHttpConnection.h"
#import "FLJsonStringBuilder.h"

@interface FLJsonRequest : FLHttpConnection {
@private
	FLJsonStringBuilder* _json;
}

@property (readonly, retain, nonatomic) FLJsonStringBuilder* json;

@end
