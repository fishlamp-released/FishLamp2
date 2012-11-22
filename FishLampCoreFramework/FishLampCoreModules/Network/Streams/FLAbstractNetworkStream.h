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
//#import "FLDispatchQueue.h"

@interface FLAbstractNetworkStream : FLObservable<FLNetworkStream> {
@private
    CFRunLoopRef _runLoop;
    BOOL _isOpen;
    BOOL _didClose;
    FLStreamClosedBlock _closeBlock;
    FLSelectorQueue* _queue;
    BOOL _busy;
    
    FLFinisher* _closeFinisher;
    FLDispatchQueue* _dispatchQueue;
}

@property (readonly, strong) FLDispatchQueue* dispatchQueue;
@end

@interface FLAbstractNetworkStream (CFStream)
- (void) handleStreamEvent:(CFStreamEventType) eventType;
@end

@protocol FLConcreteNetworkStream <NSObject>
@property (readwrite, strong) NSError* error;
- (void) openNetworkStream;
- (void) closeNetworkStream;
@end
