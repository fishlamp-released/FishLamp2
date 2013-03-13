//
//  FLNetworkStream.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@protocol FLNetworkStreamDelegate;

@interface FLNetworkStream : NSObject {
@private
    BOOL _open;
    NSError* _error;
    
    __unsafe_unretained id<FLNetworkStreamDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLNetworkStreamDelegate> delegate;

@property (readonly, assign, getter=isOpen) BOOL open;
@property (readwrite, strong) NSError* error;

// optional overrides
- (void) willOpen;
- (void) didOpen;
- (void) willClose;
- (void) didClose;

// stream events. All of these do nothing by default.
- (void) encounteredOpen;
- (void) encounteredCanAcceptBytes;
- (void) encounteredBytesAvailable;
- (void) encounteredError:(NSError*) error;
- (void) encounteredEnd;


// required overrides
- (NSError*) streamError;
- (void) openStream;
- (void) closeStream;

// for CFStream subclasses

+ (void) handleStreamEvent:(CFStreamEventType) eventType withStream:(FLNetworkStream*) stream;

@end

@protocol FLNetworkStreamDelegate <NSObject>
@optional

- (void) networkStreamWillOpen:(FLNetworkStream*) networkStream;

- (void) networkStreamDidOpen:(FLNetworkStream*) networkStream;

- (void) networkStream:(FLNetworkStream*) networkStream willCloseWithError:(NSError*) error;

- (void) networkStreamDidClose:(FLNetworkStream*) networkStream;

- (void) networkStream:(FLNetworkStream*) networkStream encounteredError:(NSError*) error;

- (void) networkStreamHasBytesAvailable:(FLNetworkStream*) networkStream;

- (void) networkStreamCanAcceptBytes:(FLNetworkStream*) networkStream;

- (void) networkStream:(FLNetworkStream*) networkStream didReadBytes:(NSNumber*) amountRead;

- (void) networkStream:(FLNetworkStream*) networkStream didWriteBytes:(NSNumber*) amountRead;


@end