//
//	FLRetainedObject.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCore.h"
#import "FLObjectContainer.h"

@interface FLRetainedObject : NSObject<FLObjectContainer> {
@private 
	id _object;
}

- (id) initWithObject:(id) object;

+ (FLRetainedObject*) retainedObject:(id) object;

@property (readwrite, retain, nonatomic) id object;

@end