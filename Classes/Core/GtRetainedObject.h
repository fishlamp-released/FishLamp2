//
//	GtRetainedObject.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"
#import "GtObjectContainer.h"

@interface GtRetainedObject : NSObject<GtObjectContainer> {
@private 
	id _object;
}

- (id) initWithObject:(id) object;

+ (GtRetainedObject*) retainedObject:(id) object;

@property (readwrite, retain, nonatomic) id object;

@end
