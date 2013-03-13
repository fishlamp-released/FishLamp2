//
//  FLTcpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"
@class FLReadStream;
@class FLWriteStream;

@interface FLTcpRequest : NSObject {
@private
}

- (BOOL) readData:(FLReadStream*) stream;

- (BOOL) writeData:(FLWriteStream*) stream;

@end

// TODO:
// make subclasses for specific transaction types:
// send bytes expecting bytes (e.g. wantsRead NO && wantsWrite = YES initialially)
// send bytes expecting nothing back
// receive arbritrary bytes
