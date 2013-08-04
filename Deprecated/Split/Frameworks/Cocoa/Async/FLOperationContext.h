//
//  FLOperationContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLService.h"
#import "FLFinisher.h"
#import "FLObservable.h"

@class FLOperation;
@class FLFifoAsyncQueue;

typedef void (^FLOperationVisitor)(id operation, BOOL* stop);

extern NSString* const FLWorkerContextStarting;
extern NSString* const FLWorkerContextFinished;
extern NSString* const FLWorkerContextClosed;
extern NSString* const FLWorkerContextOpened;

@interface FLOperationContext : FLObservable {
@private
    NSMutableSet* _operations;
    NSUInteger _contextID;
    BOOL _contextOpen;
}
@property (readonly, assign, getter=isContextOpen) BOOL contextOpen; 

@property (readonly, assign) NSUInteger contextID;

+ (id) operationContext;

- (void) openContext;
- (void) closeContext;

- (void) requestCancel;          

- (void) queueOperation:(FLOperation*) operation;
- (void) removeOperation:(FLOperation*) operation;

- (void) visitOperations:(FLOperationVisitor) visitor;

// optional overrides
- (void) didStartWorking;
- (void) didStopWorking;
- (void) didAddOperation:(FLOperation*) object;
- (void) didRemoveOperation:(FLOperation*) object;

@end

