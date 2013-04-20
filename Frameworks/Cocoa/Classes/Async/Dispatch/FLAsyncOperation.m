//
//  FLAsyncOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

@interface FLAsyncOperation ()
@property (readwrite, strong) FLFinisher* finisher; 
@end

@implementation FLAsyncOperation
@synthesize finisher = _finisher;

- (void) performUntilFinished:(FLFinisher*) finisher {
    self.finisher = finisher;
}

#if FL_MRC
- (void) dealloc {
	[_finisher release];
	[super dealloc];
}
#endif
//
//- (void) operationDidFinishWithResult:(id) result {
//    [super operationDidFinishWithResult:result];
//}

- (void) setFinishedWithResult:(id) result {
    [self.finisher setFinishedWithResult:result];
}

- (void) setFinished {
    [self.finisher setFinished];
}


@end
