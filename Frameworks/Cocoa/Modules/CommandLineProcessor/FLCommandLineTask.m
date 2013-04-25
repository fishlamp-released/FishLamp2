//
//  FLCommandLineTask.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCommandLineTask.h"

@implementation FLCommandLineTask

@synthesize operations = _operations;

- (id) init {	
	self = [super init];
	if(self) {
		_operations = [[NSMutableArray alloc] init];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_operations release];
	[super dealloc];
}
#endif

+ (id) commandLineTask {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) addOperation:(FLOperation*) operation {
    [_operations addObject:operation];
}

- (id) performSynchronously {
    for(FLOperation* operation in _operations) {
        [self runChildSynchronously:operation];
    }
    
    return FLSuccessfullResult;
}


@end
