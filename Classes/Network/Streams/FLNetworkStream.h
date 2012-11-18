//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRunLoopMode NSDefaultRunLoopMode

typedef void (^FLStreamClosedBlock)(id stream, NSError* error);

@protocol FLNetworkStream <NSObject>

@property (readwrite, assign) id delegate;
@property (readonly, assign) BOOL isOpen;

- (void) openStream:(FLStreamClosedBlock) didCloseBlock;
- (void) closeStream:(NSError*) error;

@end

@interface FLNetworkStream : NSObject<FLNetworkStream> {
@private
    __unsafe_unretained id _delegate;
    __unsafe_unretained NSThread* _thread;
    CFRunLoopRef _runLoop;
    BOOL _isOpen;
    BOOL _didClose;
    FLStreamClosedBlock _closeBlock;
}
@property (readonly, assign) NSThread* thread;
@property (readonly, assign) CFRunLoopRef runLoop;
@property (readonly, strong) NSError* error;

- (void) forwardStreamEventToDelegate:(CFStreamEventType) eventType;

- (void) openSelf;
- (void) closeSelf:(NSError*) error;

- (void) startClosingWithError:(NSError*) error;

@end

@protocol FLNetworkStreamDelegate <NSObject>
- (void) networkStreamWillOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamWillClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error;
- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error;
@end


