//
//  FLJsonBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLStringBuilder.h"
#import "FLDataEncoder.h"

@interface FLJsonBuilder : FLStringBuilder {
@private
	id<FLDataEncoder> _dataEncoder;
}

@property (readwrite, retain, nonatomic) id<FLDataEncoder> dataEncoder;

- (void) streamObject:(id) object;

//- (void) addObjectAsFunction:(NSString*) functionName object:(id) object;

@end
