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

- (NSUInteger) readBytes:(uint8_t*) bytes 
               maxLength:(NSUInteger) maxLength;
@end

@protocol FLStreamRequiredOverrides <NSObject>
- (void) openSelfWithInput:(id) input;
- (void) closeSelfWithResult:(id) result;
- (void) didEncounterError:(NSError*) error;
- (BOOL) isOpen;
@end

@interface FLStream : NSObject<FLStream, FLStreamRequiredOverrides> {
@private
    FLTimeoutTimer* _timeoutTimer;
    NSTimeInterval _timeoutInterval;
}

@property (readwrite, assign) NSTimeInterval timeoutInterval;
@property (readonly, strong) FLTimeoutTimer* timeoutTimer;
- (void) touchTimestamp;
@end

