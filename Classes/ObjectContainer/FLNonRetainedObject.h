//
//  FLNonRetainedObject.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLObjectContainer.h"

@interface FLNonRetainedObject : NSObject<FLObjectContainer> {
@private
	__unsafe_unretained id _object;
}

- (id) initWithObject:(id) object;

+ (FLNonRetainedObject*) nonRetainedObject:(id) object;

@property (readwrite, assign, nonatomic) id object; // not retained.

@end
