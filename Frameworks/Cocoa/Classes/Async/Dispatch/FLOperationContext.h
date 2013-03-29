//
//  FLOperationContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLFinisher.h"

@class FLOperation;
@class FLFifoAsyncQueue;

typedef void (^FLOperationVisitor)(id operation, BOOL* stop);

extern NSString* const FLWorkerContextStarting;
extern NSString* const FLWorkerContextFinished;
extern NSString* const FLWorkerContextClosed;
extern NSString* const FLWorkerContextOpened;

@interface FLOperationContext : NSObject {
@private
    NSMutableSet* _operations;
    FLFifoAsyncQueue* _asyncQueue;
    NSUInteger _contextID;
    BOOL _contextOpen;
}
@property (readonly, assign, getter=isContextOpen) BOOL contextOpen; 

@property (readonly, assign) NSUInteger contextID;

+ (id) operationContext;

- (void) openContext;
- (void) closeContext;

- (void) requestCancel;          

- (void) addOperation:(FLOperation*) operation;
- (void) removeOperation:(FLOperation*) operation;

- (void) visitOperations:(FLOperationVisitor) visitor;

// optional overrides
- (void) didStartWorking;
- (void) didStopWorking;
- (void) didAddOperation:(id) object;
- (void) didRemoveOperation:(id) object;

@end

