//
//	FLRetainedObject.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLObjectContainer.h"

@interface FLRetainedObject : NSObject<FLObjectContainer> {
@private 
	id _object;
}

- (id) initWithObject:(id) object;

+ (FLRetainedObject*) retainedObject:(id) object;

@property (readwrite, strong, nonatomic) id object;

@end
