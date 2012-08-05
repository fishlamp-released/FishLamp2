//
//  FLAsyncEventHandler.m
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 1/30/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAsyncEventHandler.h"
#import "NSObject+Blocks.h"

@interface FLAsyncEventHandler ()
//@property (readwrite, strong, nonatomic) id eventResult;
@property (readwrite, strong, nonatomic) FLAsyncEventHandler* childHandler;
@property (readwrite, weak, nonatomic) FLAsyncEventHandler* parentHandler;
@end

@implementation FLAsyncEventHandler

@synthesize onStarted = _onStarted;
@synthesize onEvent = _onEvent;
@synthesize onFinished = _onFinished;
@synthesize transactionContext = _transactionContext;
@synthesize transactionID = _transactionID;
//@synthesize eventResult = _eventResult;
@synthesize eventCount = _eventCount;
//@synthesize eventSuccess = _eventSuccess;
@synthesize parentHandler = _parentHandler;
@synthesize childHandler = _childHandler;
//@synthesize eventHint = _eventHint;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (id) initWithTransactionContext:(id) transactionContext {   
    self = [super init];
    if(self) {
        self.transactionContext = transactionContext;
    }

    return self;
}

+ (id) asyncEventHandler {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

+ (id) asyncEventHandler:(id) context {
    return FLReturnAutoreleased([[[self class] alloc] initWithTransactionContext:context]);
}

- (void) dealloc {
    FLRelease(_childHandler);
//    FLRelease(_result);
    FLRelease(_onStarted);
    FLRelease(_onFinished);
    FLRelease(_onEvent);
    FLRelease(_transactionContext);
    FLRelease(_transactionID);
    FLSuperDealloc();
}

- (void) addChildHandler:(FLAsyncEventHandler*) aHandler {
    if(_childHandler) {
        [_childHandler addChildHandler:aHandler];
    }
    else {
        self.childHandler = aHandler;
        aHandler.parentHandler = self;
    }
}

- (void) sendEventWithSuccess:(BOOL) success
                       result:(id) result
                         hint:(FLAsyncEventHint) hint {    
    
    ++_eventCount;
//    self.eventResult = result;
//    _eventHint = hint;
//    _success = success;
    if(_onEvent) {   
        _onEvent(self, success, result, hint);
    }
    if(_childHandler) {
        [_childHandler sendEventWithSuccess:success result:result hint:hint]; 
    }
}
    
- (void) sendFinished {
    if(_onFinished){
        _onFinished(self);
    }
    if(_childHandler) {
        [_childHandler sendFinished]; 
    }
}

- (void) sendStarted {
    if(_onStarted) {
        _onStarted(self);
    }
    if(_childHandler) {
        [_childHandler sendStarted]; 
    }
}

@end

@implementation FLAsyncEventHandler (FLAction)

- (void) configureWithAction:(id<FLAsyncAction>) action {
    action.actionDescription = self;
    self.transactionID = action.actionID;
    
    action.onWillStart = ^(id theAction){
        self.transactionContext = [theAction actionContext];
        [self sendStarted];
    };
        
    action.onFinished = ^(id theAction){     
        [self sendFinished];
        };
}
@end

@implementation FLAsyncEventProgressHandler 

@synthesize onShowProgress = _onShowProgress; 
@synthesize progressController = _progressController;

+ (FLAsyncEventProgressHandler*) asyncEventProgressHandler {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

#if FL_DEALLOC 
- (void) dealloc {
    [_onShowProgress release];
    [_progressController release];
    [super dealloc];
}
#endif

- (void) configureWithAction:(id<FLAsyncAction>) action {
    [super configureWithAction:action];
    
    if(!action.progressController) {
        action.progressController = self.progressController;
    }
}

- (void) _show {
    if(_progressController) {
        [self.progressController showProgress];
    }
    else if (_onShowProgress) {
        _onShowProgress(self);
    }
}

- (void) sendStarted {
    [super sendStarted];
    
    [self performSelectorOnMainThread:@selector(_show) withObject:nil waitUntilDone:NO];
}

- (void) sendFinished {
    [super sendFinished];

    [self performBlockOnMainThread:^{
        if(_progressController) {
            [self.progressController hideProgress];
        }
    }];
    

}

@end


//@implementation FLAsyncEventResult
//
//@synthesize eventId = _eventId;
//@synthesize eventInput = _eventInput;
//@synthesize eventOutput = _eventOutput;
//@synthesize eventContext = _eventContext;
//@synthesize error = _eventError;
//@synthesize eventHint = _eventHint;
//@synthesize eventDomain = _eventDomain;
//
//- (id) initWithEventDomain:(id) eventDomain {
//    self = [super init];
//    if(self) {
//        self.eventDomain = eventDomain;
//    }
//    return self;
//}
//
//+ (FLAsyncEventResult*) asyncEventResult:(id) eventDomain {
//    return FLReturnAutoreleased([[FLAsyncEventResult alloc] initWithEventDomain:eventDomain]);
//}     
//
//+ (FLAsyncEventResult*) asyncEventResult {
//    return FLReturnAutoreleased([[FLAsyncEventResult alloc] init]);
//}     
//
//- (void) dealloc {
//    FLRelease(_eventDomain);
//    FLRelease(_eventInput);
//    FLRelease(_eventOutput);
//    FLRelease(_eventContext);
//    FLRelease(_eventError);
//    FLSuperDealloc();
//}
//
//- (BOOL) eventOutputIsKindOfClass:(Class) aClass {
//    return _eventOutput != nil ? [_eventOutput isKindOfClass:aClass] : NO;
//}
//
//- (BOOL) eventOutputIsArray {
//    return [self eventOutputIsKindOfClass:[NSArray class]];
//}
//
//- (BOOL) eventOutputIsDictionary {
//    return [self eventOutputIsKindOfClass:[NSDictionary class]];
//}
//
//- (BOOL) eventOutputIsSet {
//    return [self eventOutputIsKindOfClass:[NSSet class]];
//}
//
//- (void) failIfOutputIsNotKindOfClass:(Class) aClass
//{
//    if(![self eventOutputIsKindOfClass:aClass]){
//        FLThrowErrorCode(@"FLAsyncEventHandlerErrorDomain", 1, @"Output Object is kind of class %@. Expected class %@", NSStringFromClass([self.eventOutput class]), NSStringFromClass(aClass));
//    }
//}
//
//- (void) failIfOutputIsNotArray {
//    [self failIfOutputIsNotKindOfClass:[NSArray class]];
//}
//
//- (void) failIfOutputIsNotDictionary {
//    [self failIfOutputIsNotKindOfClass:[NSDictionary class]];
//}
//
//- (void) failIfOutputIsNotSet {
//    [self failIfOutputIsNotKindOfClass:[NSSet class]];
//}
//
//@end

//@implementation NSObject (FLAsyncEventHandler)
//
//- (void) performBlockInBackground:(void (^)(id object, FLAsyncEventHandler* handler)) asyncBlock
//                 withEventHandler:(FLAsyncEventHandler*) eventHandler
//{
//    asyncBlock = FLReturnAutoreleased([asyncBlock copy]);
//
//    dispatch_async(
//        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [eventHandler sendStarted];
//            FLAsyncEventResult* eventResult = [FLAsyncEventResult asyncEventResult:[[self class] asyncEventDomain]];
//            @try {
//                if(asyncBlock) {
//                    asyncBlock(self, eventHandler, eventResult);
//                }
//            }
//            @catch(NSException* ex) {
//                eventResult.error = ex.error;
//            }
//            
//            [eventHandler sendEventWithResult:eventResult];
//            [eventHandler sendFinished];
//        });
//
//} 
//
//+ (id) asyncEventDomain {
//    return @"unknown";
//}
//                    
//
//@end
