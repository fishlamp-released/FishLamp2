//
//  FLJsonRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLHttpConnection.h"
#import "FLJsonBuilder.h"

@interface FLJsonRequest : FLHttpConnection {
@private
	FLJsonBuilder* _json;
}

@property (readonly, retain, nonatomic) FLJsonBuilder* jsonBuilder;

@end
