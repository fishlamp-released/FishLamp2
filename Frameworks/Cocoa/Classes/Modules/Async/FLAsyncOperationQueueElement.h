//
//  FLAsyncOperationQueueElement.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPromisedResult.h"

@class FLAsyncOperationQueue;

@interface FLAsyncOperationQueueElement : NSObject {
@private
    id _input;
    id _operation;
    FLPromisedResult* _result;
}
@property (readonly, strong, nonatomic) FLPromisedResult* result;
@property (readonly, strong, nonatomic) id input;
@property (readonly, strong, nonatomic) id operation;

+ (id) asyncOperationQueueElement:(id) input operation:(id) operation;

- (void) beginOperationInQueue:(FLAsyncOperationQueue*) queue
                    completion:(dispatch_block_t) completion;


@end
