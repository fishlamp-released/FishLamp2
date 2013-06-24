//
//  FLAsyncOperationQueueElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperationQueueElement.h"
#import "FLAsyncOperationQueue.h"

@interface FLAsyncOperationQueueElement ()
@property (readwrite, strong, nonatomic) id input;
@property (readwrite, strong, nonatomic) id operation;
@property (readwrite, strong, nonatomic) FLPromisedResult* result;
@end

@implementation FLAsyncOperationQueueElement

@synthesize input =_input;
@synthesize operation = _operation;
@synthesize result =_result;

#if FL_MRC
- (void)dealloc {
	[_input release];
    [_operation release];
    [_result release];
    [super dealloc];
}
#endif

- (id) initWithInput:(id) input
           operation:(id) operation {

	self = [super init];
	if(self) {
        self.input = input;
        self.operation = operation;
	}
	return self;
}

+ (id) asyncOperationQueueElement:(id) input operation:(id) operation {
    return FLAutorelease([[[self class] alloc] initWithInput:input operation:operation]);
}

- (void) beginOperationInQueue:(FLAsyncOperationQueue*) queue
                    completion:(dispatch_block_t) completion {

    completion = FLCopyWithAutorelease(completion);

    [queue runChildAsynchronously:self.operation completion:^(id result, NSError* error) {
        self.result = [FLPromisedResult promisedResult:result error:error];
        completion();
    }];
}

@end
