//
//  FLRequestContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDispatchQueue.h"
#import "FLHttpRequest.h"

@interface FLRequestContext : NSObject {
@private
    FLFifoDispatchQueue* _schedulingQueue;
    NSMutableArray* _requests;
}

- (FLFinisher*) sendRequest:(FLHttpRequest*) request;

- (FLFinisher*) sendRequest:(FLHttpRequest*) request 
                 completion:(FLCompletionBlock) completion;

- (FLResult) sendRequestSynchronously:(FLHttpRequest*) request;

- (void) requestCancel;

@end
