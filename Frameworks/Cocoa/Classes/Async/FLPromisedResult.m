//
//  FLPromisedResult.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPromisedResult.h"

@interface FLPromisedResult ()
@property (readwrite, strong, nonatomic) NSError* error;
@property (readwrite, strong, nonatomic) id value;
@end

@implementation FLPromisedResult

@synthesize value =_value;
@synthesize error =_error;

- (id) initWithValue:(id) value error:(NSError*) error {
	self = [super init];
	if(self) {
		self.value = value;
        self.error = error;
	}
	return self;
}

+ (id) promisedResult:(id) value error:(NSError*) error {
    return FLAutorelease([[[self class] alloc] initWithValue:value error:error]);
}

#if FL_MRC
- (void)dealloc {
	[_value release];
    [_error release];

	[super dealloc];
}
#endif


@end
