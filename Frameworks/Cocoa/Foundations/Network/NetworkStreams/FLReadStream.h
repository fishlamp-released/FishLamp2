//
//  FLReadStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLByteBuffer.h"

@protocol FLReadStreamDelegate;

@interface FLReadStream : FLNetworkStream<FLReadStream>  {
@private
    CFReadStreamRef _streamRef;
    __unsafe_unretained id<FLReadStreamDelegate> _delegate;
    BOOL _isOpen;
}
@property (readwrite, assign) id<FLReadStreamDelegate> delegate;
@property (readonly, assign, nonatomic) CFReadStreamRef streamRef;

- (BOOL) hasBytesAvailable;

- (unsigned long) bytesRead;

- (id) initWithReadStream:(CFReadStreamRef) writeStream;

+ (id) readStream:(CFReadStreamRef) writeStream;

@end

@protocol FLReadStreamDelegate <NSObject>

- (void) readStreamDidOpen:(FLReadStream*) networkStream;

- (void) readStream:(FLReadStream*) networkStream 
    didCloseWithResult:(FLResult) result;

- (void) readStream:(FLReadStream*) readStream
      didEncounterError:(NSError*) error;

- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream;

- (void) readStream:(id<FLReadStream>) stream didReadBytes:(unsigned long) amountRead;

@end