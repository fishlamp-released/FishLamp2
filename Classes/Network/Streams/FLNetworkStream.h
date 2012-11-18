//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"

#define kRunLoopMode NSDefaultRunLoopMode

typedef void (^FLStreamClosedBlock)(id stream, NSError* error);

@protocol FLNetworkStreamDelegate;

@protocol FLNetworkStream <FLObservable>
@property (readonly, assign) BOOL isOpen;
- (void) openStream:(FLStreamClosedBlock) didCloseBlock;
- (void) closeStream:(NSError*) error;
@property (readonly, strong) NSError* error;

@property (readwrite, assign) id<FLNetworkStreamDelegate> delegate;
@end

@protocol FLNetworkStreamDelegate <FLObservable>
- (void) networkStreamOpenStream:(id<FLNetworkStream>) stream;
- (void) networkStreamCloseStream:(id<FLNetworkStream>) stream withError:(NSError*) error;
@end

@protocol FLNetworkStreamObserver <NSObject>
- (void) networkStreamWillOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamWillClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error;
- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error;
@end

@interface FLNetworkStream : FLObservable<FLNetworkStream, FLNetworkStreamDelegate> {
@private
    __unsafe_unretained id _delegate;
    __unsafe_unretained NSThread* _thread;
    CFRunLoopRef _runLoop;
    BOOL _isOpen;
    BOOL _didClose;
    FLStreamClosedBlock _closeBlock;
    NSMutableArray* _queue;
    BOOL _busy;
}
@property (readonly, assign) NSThread* thread;
@property (readonly, assign) CFRunLoopRef runLoop;

- (void) handleStreamEvent:(CFStreamEventType) eventType;
@end

//@interface FLStreamTask : NSObject
//- (void) performStreamTask:(id) stream;
//@end
//
//@interface FLStreamOpener : NSObject<FLStreamTask> {
//}
//@end
//
//@interface FLStreamCloser : NSObject<FLStreamTask> {
//}
//@end

