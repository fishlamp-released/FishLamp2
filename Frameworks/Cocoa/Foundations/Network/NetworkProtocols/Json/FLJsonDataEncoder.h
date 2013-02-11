//
//  FLJsonDataEncoder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLDataEncoder.h"

@interface FLJsonDataEncoder : FLDataEncoder {
@private
}

FLSingletonProperty(FLJsonDataEncoder);

@end

@interface NSString (FLJsonDataEncoder)
- (NSString*) jsonEncode;
@end