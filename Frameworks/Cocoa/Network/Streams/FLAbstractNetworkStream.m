//
//  FLAbstactNetworkStream.m
//  FLCore
//
//  Created by Mike Fullerton on 11/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAbstractNetworkStream.h"

#import "FLReadStream.h"
#import "FLWriteStream.h"

#define kRunLoopMode NSDefaultRunLoopMode

@interface FLAbstractNetworkStream ()
@property (readwrite, assign) BOOL isOpen;
@property (readwrite, assign) BOOL didClose;
@property (readwrite, strong) FLFinisher* closeFinisher;
@property (readwrite, strong) FLDispatchQueue* dispatchQueue;
@property (readwrite, strong) FLResult result;
@property (readwrite, strong) FLCancellable* cancelHandler;

- (void) openStream;
- (void) closeStream;
@end

@implementation FLAbstractNetworkStream

@synthesize isOpen = _isOpen;
@synthesize didClose = _didClose;
@synthesize result = _result;
@synthesize closeFinisher = _closeFinisher;
@synthesize dispatchQueue = _dispatchQueue;
@synthesize cancelHandler = _cancelHandler;

- (id) init {
    self = [super init];
    if(self) {
        FLAssert_v([self conformsToProtocol:@protocol(FLConcreteNetworkStream)], @"subclasses must implement @protocol FLConcreteNetworkStream")
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_cancelHandler release];
    [_result release];
    [_dispatchQueue release];
    [_closeFinisher release];
    [super dealloc];
}
#endif

- (void) _closeStream {
    if(!self.didClose) {
        self.didClose = YES;
        
        [self postObservation:@selector(networkStreamWillClose:)];
        
        [self closeStream];
        
        [self postObservation:@selector(networkStreamDidClose:)];
        self.isOpen = NO;

        FLResult result = [self.cancelHandler setFinished:self.result];
        if(!result) {
            result = FLSuccessfullResult;
        }
        
        [self.closeFinisher setFinishedWithResult:result];
        self.closeFinisher = nil;
        
        self.cancelHandler = nil;
    }
}

- (void) closeStreamWithResult:(id) result {
    self.result = result;
    [self.dispatchQueue dispatchBlock:^{
        [self _closeStream];
    }];
}    

- (FLFinisher*) openStream:(id<FLDispatcher>) dispatcher 
         streamClosedBlock:(FLResultBlock) streamClosedBlock {

    self.result = nil;
    self.didClose = NO;
    self.isOpen = NO;
    self.dispatchQueue = dispatcher;
    self.closeFinisher = [FLFinisher finisherWithResultBlock:streamClosedBlock];

    self.cancelHandler = [FLCancellable cancelHandler];

    [dispatcher dispatchBlock:^{
        [self postObservation:@selector(networkStreamWillOpen:)];
        [self openStream];
    }];

    return self.closeFinisher;
}

- (void) openStream {
}

- (void) closeStream {
}

- (FLFinisher*) requestCancel:(FLResultBlock) completion {

    FLFinisher* finisher = [self.cancelHandler requestCancel:completion];

    if(self.isOpen) {
        [self closeStreamWithResult:[NSError cancelError]];
    }

    return finisher;
}

@end

@implementation FLAbstractNetworkStream (CFStream)

- (void) handleStreamEvent:(CFStreamEventType) eventType {

//    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if TRACE
    FLDebugLog(@"Read Stream got event %d", eventType);
#endif

    switch (eventType)  {
        case kCFStreamEventOpenCompleted: {
            self.isOpen = YES;
            [self.dispatchQueue dispatchBlock:^{
                [self postObservation:@selector(networkStreamDidOpen:)];
            }];
        }
        break;

        case kCFStreamEventErrorOccurred:
        case kCFStreamEventEndEncountered:{
            [self.dispatchQueue dispatchBlock:^{
                [self _closeStream];
            }];
        }
        break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable:
            [self postObservation:@selector(readStreamHasBytesAvailable:)];
            break;
            
        case kCFStreamEventCanAcceptBytes:
            [self postObservation:@selector(writeStreamCanAcceptBytes:)];
            break;
    }
}

@end
