//
//  FLAsyncOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

@interface FLAsyncOperation ()
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

- (void) setFinishedWithResult:(id) result {
    FLAssertNotNil(self.finisher);
    
    [self.finisher setFinishedWithResult:result];
    [self operationDidFinishWithResult:result];
}

- (void) setFinished {
    [self setFinishedWithResult:FLSuccessfullResult];
}

- (void) setFinishedWithCancelResult {
    [self setFinishedWithResult:[NSError cancelError]];
}

//- (void) requestCancel {
//    [super requestCancel];
//    [self setFinishedWithCancelResult];
//}

@end
