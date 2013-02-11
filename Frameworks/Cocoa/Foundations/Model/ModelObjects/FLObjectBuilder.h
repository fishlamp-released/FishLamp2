//
//  FLObjectBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLDataDecoding.h"

@interface FLObjectBuilder : NSObject {
@private
}

+ (id) objectBuilder;

// dictionary should only have arrays, dictionaries, and strings in it.

- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary 
                     withRootObject:(id) rootObject
                        withDecoder:(id<FLDataDecoding>) decoder;

@end
