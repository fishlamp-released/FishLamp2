//
//  FLWriteStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

@protocol FLWriteStreamDelegate;

@interface FLWriteStream : FLNetworkStream<FLWriteStream> {
@private
 	CFWriteStreamRef _streamRef;
    BOOL _isOpen;
    __unsafe_unretained id<FLWriteStreamDelegate> _delegate;
}
@property (readonly, assign) CFWriteStreamRef streamRef;
@property (readwrite, assign) id<FLWriteStreamDelegate> delegate;

- (id) initWithWriteStream:(CFWriteStreamRef) streamRef;
         
+ (id) writeStream:(CFWriteStreamRef) streamRef;

- (BOOL) canAcceptBytes;

@end

@protocol FLWriteStreamDelegate <NSObject>
- (void) writeStreamDidOpen:(FLWriteStream*) networkStream;

- (void) writeStream:(FLWriteStream*) networkStream 
    didCloseWithResult:(FLResult) result;

- (void) writeStream:(FLWriteStream*) writeStream
      didEncounterError:(NSError*) error;

- (void) writeStreamCanAcceptBytes:(id<FLWriteStream>) networkStream;

- (void) writeStream:(id<FLWriteStream>) stream didWriteBytes:(unsigned long) amountWritten;

@end