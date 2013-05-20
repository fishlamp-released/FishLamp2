//
//  GtObjectBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@interface GtObjectBuilder : NSObject {
@private
}

- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary withRootObject:(id) rootObject;

@end
