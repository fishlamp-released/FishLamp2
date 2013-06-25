//
//  FLRetainedRef.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLRetainedRef.h"

@interface FLRetainedRef ()
@property (readwrite, strong, nonatomic) id object;
@end

@implementation FLRetainedRef

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

+ (id) retained:(id) object {
    return FLAutorelease([[[self class] alloc] initWithObject:object]);
}

@end
