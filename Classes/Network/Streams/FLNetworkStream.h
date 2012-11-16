//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCancellable.h"

#define kRunLoopMode NSDefaultRunLoopMode

@protocol FLNetworkStream <NSObject, FLCancellable>
@property (readwrite, assign) id delegate;
@property (readonly, assign) BOOL isOpen;

@property (readonly, strong) id output;

- (void) openStream;
- (void) closeStream;
@end

@protocol FLNetworkStreamDelegate <NSObject>
- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream 
                    withResult:(FLFinisher*) result;
@end

@interface FLNetworkStream : NSObject<FLNetworkStream> {
@private
    __unsafe_unretained id _delegate;
    __unsafe_unretained NSThread* _thread;
    CFRunLoopRef _runLoop;
    BOOL _isOpen;
    BOOL _wasCancelled;
    BOOL _didClose;
}
@property (readonly, assign) NSThread* thread;
@property (readonly, assign) CFRunLoopRef runLoop;
@property (readonly, strong) NSError* error;

- (void) forwardStreamEventToDelegate:(CFStreamEventType) eventType;

- (void) openSelf;
- (void) closeSelf;

@end





