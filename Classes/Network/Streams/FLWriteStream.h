//
//  FLWriteStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

@interface FLWriteStream : FLNetworkStream<FLWriteStream> {
@private
 	CFWriteStreamRef _streamRef;
    BOOL _open;
}
@property (readonly, assign) CFWriteStreamRef streamRef;

- (id) initWithWriteStream:(CFWriteStreamRef) streamRef;
+ (id) writeStream:(CFWriteStreamRef) streamRef;

@end

