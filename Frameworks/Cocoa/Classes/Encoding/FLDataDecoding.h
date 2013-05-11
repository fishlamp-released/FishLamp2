//
//  FLDataDecoding.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@protocol FLDataDecoding <NSObject>

- (id) objectFromString:(NSString*) string
            encodingKey:(NSString*) encodingKey;

@end


