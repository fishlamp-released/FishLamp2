//
//  FLRetainedObject.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLRetainedObject.h"

@interface FLRetainedObject ()
@property (readwrite, strong, nonatomic) id object;
@end

@implementation FLRetainedObject

@synthesize object = _retainedObject;

- (id) initWithObject:(id) object {
	self = [super initWithObject:object];
	if(self) {
		self.object = object;
	}
	return self;
}

#if FL_MRC
- (void)dealloc {
	[_retainedObject release];
	[super dealloc];
}
#endif

+ (id) retainedObject:(id) object {
    return FLAutorelease([[[self class] alloc] initWithObject:object]);
}

@end
