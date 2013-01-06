//
//  NSURLResponse+(Extras).h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"


@interface NSHTTPURLResponse (Extras)
- (NSError*) simpleHttpResponseErrorCheck;
@end
