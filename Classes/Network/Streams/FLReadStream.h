//
//  FLReadStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

@interface FLReadStream : FLNetworkStream<FLReadStream>  {
@private
    CFReadStreamRef _streamRef;
    BOOL _reading;
}
@property (readonly, assign, nonatomic) CFReadStreamRef streamRef;

- (id) initWithReadStream:(CFReadStreamRef) writeStream;

+ (id) readStream:(CFReadStreamRef) writeStream;

@end

