//
//  FLParseable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLParseableInput.h"

@protocol FLParseable <NSObject>
- (void) handleInput:(FLParseableInput*) input;
@end
