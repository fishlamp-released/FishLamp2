//
//  FLObjectBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"


@interface FLObjectBuilder : NSObject {
@private
}

- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary withRootObject:(id) rootObject;

@end
