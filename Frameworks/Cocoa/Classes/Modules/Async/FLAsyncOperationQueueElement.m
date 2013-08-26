//
//  FLAsyncOperationQueueElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperationQueueElement.h"
#import "FLOperationQueue.h"

@interface FLAsyncOperationQueueElement ()
@property (readwrite, strong, nonatomic) id input;
@property (readwrite, strong) id operation;
@property (readwrite, strong, nonatomic) id operationResult;
@end

@implementation FLAsyncOperationQueueElement

@synthesize input =_input;
@synthesize operation = _operation;
@synthesize operationResult =_operationResult;

#if FL_MRC
- (void)dealloc {
	[_input release];
    [_operation release];
    [_operationResult release];
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

- (void) beginOperationInQueue:(FLOperationQueue*) queue
                    completion:(dispatch_block_t) completion {

    completion = FLCopyWithAutorelease(completion);

    [queue queueObject:self.operation completion:^(FLPromisedResult result) {
        self.operationResult = result;
        completion();
    }];
}

- (void) requestCancel {
    [self.operation requestCancel];
}

@end
