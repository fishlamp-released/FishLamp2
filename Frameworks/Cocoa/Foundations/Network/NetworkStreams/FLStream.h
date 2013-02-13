//
//  FLStream.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLTimeoutTimer.h"
#import "FLDispatch.h"

@protocol FLStream <NSObject>
@property (readonly, assign) BOOL isOpen;
- (void) openStreamWithInput:(id) input;
- (void) closeStreamWithResult:(id) result;
- (void) requestCancel;
@end

@protocol FLWriteStream <FLStream>
@property (readonly, assign) unsigned long bytesWritten;
- (void) writeData:(NSData*) data;
- (void) writeBytes:(const uint8_t*) bytes length:(unsigned long) length;
@end

@protocol FLReadStream <FLStream>
@property (readonly, assign) BOOL hasBytesAvailable;
@property (readonly, assign) unsigned long bytesRead;

/** this repeatedly calls readblock until there is no more available bytes, or the STOP is set to YES */
//- (void) readAvailableBytesWithBlock:(void (^)(BOOL* stop)) readblock;

- (NSInteger) readAvailableBytes:(NSMutableData*) data;
@end

@protocol FLStreamRequiredOverrides <NSObject>
- (void) openSelfWithInput:(id) input;
- (void) closeSelfWithResult:(id) result;
- (void) didEncounterError:(NSError*) error;
- (BOOL) isOpen;
@end

@interface FLStream : NSObject<FLStream, FLStreamRequiredOverrides> {
@private
    BOOL _cancelled;;
    FLTimeoutTimer* _timeoutTimer;
    NSTimeInterval _timeoutInterval;
}

@property (readwrite, assign) NSTimeInterval timeoutInterval;
@property (readonly, strong) FLTimeoutTimer* timeoutTimer;
- (void) touchTimestamp;

// requried overrides

@end

//@protocol FLStreamObserver <NSObject>
//- (void) streamWillOpen:(id<FLStream>) stream;
//
//- (void) streamDidOpen:(id<FLStream>) stream;
//
//- (void) stream:(id<FLStream>) stream 
//   willCloseWithResult:(FLResult) result;
//
//- (void) stream:(id<FLStream>) stream 
//    didCloseWithResult:(FLResult) result;
//
//- (void) stream:(id<FLStream>) stream
//      didEncounterError:(NSError*) error;
//
//- (void) streamHasBytesAvailable:(id<FLReadStream>) stream;
//
//- (void) streamDidReadBytes:(id<FLReadStream>) stream;
//
//- (void) streamCanAcceptBytes:(id<FLWriteStream>) stream;
//
//- (void) streamDidWriteBytes:(id<FLWriteStream>) stream;
//@end
