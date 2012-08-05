//
//  FLJsonDataEncoder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLDataEncoder.h"

@interface FLJsonDataEncoder : NSObject<FLDataEncoder> {
@private
	NSNumberFormatter* _numberFormatter;
}

FLSingletonProperty(FLJsonDataEncoder);

@end

@interface NSString (FLJsonDataEncoder)
- (NSString*) jsonEncode;
@end