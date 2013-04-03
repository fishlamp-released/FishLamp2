//
//  FLHttpStream.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLReadStream.h"
#import "FLHttpMessage.h"
#import "FLHttpRequestHeaders.h"
#import "FLStreamWorker.h"

@interface FLHttpStream : FLReadStream {
@private
    FLHttpMessage* _requestHeaders;
    FLHttpMessage* _responseHeaders;
    NSInputStream* _bodyStream;
}
@property (readonly, strong, nonatomic) FLHttpMessage* responseHeaders;
@property (readonly, assign, nonatomic) unsigned long bytesWritten;
@property (readonly, strong, nonatomic) FLHttpMessage* requestHeaders;

// if bodyStream == nil, it will use bodyData in request.
- (id) initWithHttpMessage:(FLHttpMessage*) request 
            withBodyStream:(NSInputStream*) bodyStream;

+ (id) httpStream:(FLHttpMessage*) request 
            withBodyStream:(NSInputStream*) bodyStream;


@end




