//
//  FLDataDecoding.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

@protocol FLDataDecoding <NSObject>

- (id) objectFromString:(NSString*) string
            encodingKey:(NSString*) encodingKey;

@end


