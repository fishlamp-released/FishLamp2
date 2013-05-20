//
//  GtNonRetainedObject.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"
#import "GtObjectContainer.h"

@interface GtNonRetainedObject : NSObject<GtObjectContainer> {
@private
	__unsafe_unretained id _object;
}

- (id) initWithObject:(id) object;

+ (GtNonRetainedObject*) nonRetainedObject:(id) object;

@property (readwrite, assign, nonatomic) id object; // not retained.

@end
