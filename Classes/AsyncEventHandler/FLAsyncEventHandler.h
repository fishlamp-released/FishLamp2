//
//  FLAsyncEventHandler.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 1/30/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLActionContext.h"
#import "FLActionDescription.h"
#import "FLProgressViewControllerProtocol.h"
#import "FLLinkedList.h"

@class FLAsyncEventHandler;
@class FLAsyncEventResult;

enum {
    FLAsyncEventHintNone                    = 0,
    FLAsyncEventHintLoadedFromServer        = (1 << 1),
    FLAsyncEventHintLoadedFromMemoryCache   = (1 << 2),
    FLAsyncEventHintLoadedFromCache         = (1 << 3)
};

typedef uint32_t FLAsyncEventHint;

typedef void (^FLAsyncEventHandlerBlock)(id handler);
typedef void (^FLAsyncEventResultBlock)(id handler, BOOL success, id result, FLAsyncEventHint hint);

@interface FLAsyncEventHandler : FLActionDescription  {
@private
    id _transactionID;
    id _transactionContext;

    FLAsyncEventHandlerBlock _onStarted;
    FLAsyncEventHandlerBlock _onFinished;
    FLAsyncEventResultBlock _onEvent;

//    BOOL _success;
//    id _result;
//    FLAsyncEventHint _eventHint;
    NSUInteger _eventCount;
    
    FLAsyncEventHandler* _childHandler;
    __weak FLAsyncEventHandler* _parentHandler;
}

@property (readwrite, retain, nonatomic) id transactionID;
@property (readwrite, retain, nonatomic) id transactionContext;

//@property (readonly, assign, nonatomic) BOOL eventSuccess;
//@property (readonly, strong, nonatomic) id eventResult;
//@property (readonly, assign, nonatomic) FLAsyncEventHint eventHint;

@property (readwrite, copy, nonatomic) FLAsyncEventResultBlock onEvent;
@property (readwrite, copy, nonatomic) FLAsyncEventHandlerBlock onStarted;
@property (readwrite, copy, nonatomic) FLAsyncEventHandlerBlock onFinished;

@property (readonly, assign, nonatomic) NSUInteger eventCount;

- (id) initWithTransactionContext:(id) transactionContext;

+ (id) asyncEventHandler;
+ (id) asyncEventHandler:(id) context;

@property (readonly, strong, nonatomic) FLAsyncEventHandler* childHandler;
@property (readonly, weak, nonatomic) FLAsyncEventHandler* parentHandler;

- (void) addChildHandler:(FLAsyncEventHandler*) aHandler;

@end

@interface FLAsyncEventHandler (Internal)
// These are called by code USING the async event handler

- (void) sendStarted;

- (void) sendFinished;

- (void) sendEventWithSuccess:(BOOL) success
                       result:(id) result
                         hint:(FLAsyncEventHint) hint;
    
@end

// optional if implementation is using a FLAction
@interface FLAsyncEventHandler (FLAction)
- (void) configureWithAction:(id<FLAsyncAction>) action;
@end

@interface FLAsyncEventProgressHandler : FLAsyncEventHandler {
@private
    id<FLProgressViewController> _progressController;
    FLAsyncEventHandlerBlock _onShowProgress;
}

+ (FLAsyncEventProgressHandler*) asyncEventProgressHandler;

@property (readwrite, retain, nonatomic) id<FLProgressViewController> progressController;
@property (readwrite, copy, nonatomic) FLAsyncEventHandlerBlock onShowProgress;

@end

//@interface NSObject (FLAsyncEvent) 
//@property (readwrite, strong, nonatomic) id asyncEventUserData;
//@end


//
//// result object for non failed operations
//@interface FLAsyncEventResult : FLLinkedListElement {
//@private 
//    id _eventInput;
//    id _eventOutput;
//    id _eventContext;
//    id _eventDomain;
//    NSError* _eventError;
//    FLAsyncEventHint _eventHint;
//    NSUInteger _eventId;
//}
//@property (readwrite, retain, nonatomic) id eventInput;
//@property (readwrite, retain, nonatomic) id eventOutput;
//@property (readwrite, retain, nonatomic) id eventContext; // can be anything
//@property (readwrite, retain, nonatomic) id eventDomain;
//
//@property (readwrite, assign, nonatomic) NSUInteger eventId;
//// hints are unique ints within the eventDomain (like an NSError)
//@property (readwrite, assign, nonatomic) NSUInteger eventHint;
//@property (readwrite, retain, nonatomic) NSError* error;
//
//- (id) initWithEventDomain:(id) eventDomain;
//
//+ (FLAsyncEventResult*) asyncEventResult;
//+ (FLAsyncEventResult*) asyncEventResult:(id) eventDomain;
//
//- (BOOL) eventOutputIsKindOfClass:(Class) aClass;
//
//@property (readonly, assign, nonatomic) BOOL eventOutputIsArray;
//@property (readonly, assign, nonatomic) BOOL eventOutputIsDictionary;
//@property (readonly, assign, nonatomic) BOOL eventOutputIsSet;
//
//
////- (void) failIfOutputIsNotKindOfClass:(Class) aClass;
////- (void) failIfOutputIsNotArray;
////- (void) failIfOutputIsNotDictionary;
////- (void) failIfOutputIsNotSet;
//
//@end



  