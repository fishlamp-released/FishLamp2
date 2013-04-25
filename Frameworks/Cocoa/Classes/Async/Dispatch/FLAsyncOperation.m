//
//  FLAsyncOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

@interface FLAsyncOperation ()
@property (readwrite, strong) id threadID;
@end

@implementation FLAsyncOperation
@synthesize finisher = _finisher;
@synthesize threadID = _threadID;

#if FL_MRC
- (void) dealloc {
	[_finisher release];
	[super dealloc];
}
#endif

- (void) setFinishedWithResult:(id) result {
    [self operationDidFinishWithResult:result];
}

- (void) operationDidFinishWithResult:(id<FLAsyncResult>) result {
    [super operationDidFinishWithResult:result];
    FLAssertNotNil(self.finisher);
    [self.finisher setFinishedWithResult:result];
}

- (void) setFinishedWithCancel {
    [self setFinishedWithResult:[[NSError cancelError] asAsyncResult]];
}

- (void) setFinishedWithReturnedObject:(id) returnedObject {
    [self setFinishedWithResult:[returnedObject asAsyncResult]];
}

- (void) setFinishedWithReturnedObject:(id) returnedObject hint:(NSInteger) hint {
    [self setFinishedWithResult:[returnedObject asAsyncResultWithHint:hint]];
}
 
- (void) setFinishedWithError:(NSError*) error {
    [self setFinishedWithReturnedObject:[error asAsyncResult]];
}                           

- (void) setFinished {
    [self setFinishedWithResult:FLSuccessfullResult];
}


- (void) performUntilFinished:(FLFinisher*) finisher {
    FLAssertNotNil(finisher);

    if(self.finisher) {
        FLConfirmWithComment(self.finisher.isFinished, @"restarting an async operation that is not finished");
        self.finisher = nil;
    }

    self.finisher = finisher;
    
    id initialData = [self startAsyncOperation];
    [self sendStartMessagesWithInitialData:initialData];

}

- (id) startAsyncOperation {
    return nil;
}

@end
