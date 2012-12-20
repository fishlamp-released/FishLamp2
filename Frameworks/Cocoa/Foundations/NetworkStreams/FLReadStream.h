//
//  FLReadStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLNetworkStream.h"
#import "FLByteBuffer.h"
#import "FLNetworkStream.h"

@interface FLReadStream : FLNetworkStream<FLReadStream, FLConcreteNetworkStream>  {
@private
    CFReadStreamRef _streamRef;
}
@property (readonly, assign, nonatomic) CFReadStreamRef streamRef;
@property (readonly, strong) NSError* readStreamError;

- (id) initWithReadStream:(CFReadStreamRef) writeStream;

+ (id) readStream:(CFReadStreamRef) writeStream;

@end
