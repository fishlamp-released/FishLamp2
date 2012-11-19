//
//  FLAbstactNetworkStream.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLNetworkStream.h"
#import "FLObservable.h"
#import "FLSelectorQueue.h"

@interface FLAbstractNetworkStream : FLObservable<FLNetworkStream> {
@private
    __unsafe_unretained NSThread* _thread;
    CFRunLoopRef _runLoop;
    BOOL _isOpen;
    BOOL _didClose;
    FLStreamClosedBlock _closeBlock;
    FLSelectorQueue* _queue;
    BOOL _busy;
}

@property (readonly, assign) NSThread* thread;
@property (readonly, assign) CFRunLoopRef runLoop;

- (void) queueStreamAction:(SEL) action;
@end

@interface FLAbstractNetworkStream (CFStream)
- (void) handleStreamEvent:(CFStreamEventType) eventType;
@end

@protocol FLConcreteNetworkStream <NSObject>
@property (readwrite, strong) NSError* error;
- (void) openNetworkStream;
- (void) closeNetworkStream;
@end
