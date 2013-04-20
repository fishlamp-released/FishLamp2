//
//	ZFSyncTask.m
//	MyZen
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "ZFSyncTask.h"

//@interface ZFSyncTask ()
//@property (readwrite, retain, nonatomic) FLOperationContext* actionContext;
//@end
//
//@implementation ZFSyncTask
//
//@synthesize showErrorIfNoNetwork = _showErrorIfNoNetwork;
//@synthesize wasCancelled = _wasCancelled;
//@synthesize identifier = _actionID;
//@synthesize progressController = _progressController;
//@synthesize onPrepare = _willBeginCallback;
//@synthesize willFinishBlock = _didCompleteCallback;
//@synthesize actionDescription = _actionDescription;
//@synthesize actionContext = _operationContext;
//
//@synthesize wasStarted = _didStart;
//@synthesize isFinished = _didFinish;
//@synthesize didPrepare = _didPrepare;
//
//@synthesize delegate = _delegate;
//
//- (BOOL) didFail {
//    return self.error != nil;
//}
//
//- (BOOL) didSucceed {
//    return _didFinish && !_wasCancelled && !self.didFail;
//}
//
//- (FLAction*) createAction {
//	FLAction* action = [FLAction action];
//	action.networkRequired  = _showErrorIfNoNetwork;
//	_action.action = action;
//	return action;
//}
//
//- (FLAction*) action {
//	return (FLAction*) _action.action;
//}
//
//- (void) setAction:(FLAction*) action {
//    _action.action = action;
//}
//
//- (id) init {
//	if((self = [super init])) {
//		_showErrorIfNoNetwork = YES;
//		_action = [[FLActionReference alloc] init];
//	}
//	return self;
//}
//
//- (NSError*) error {
//    return [_action.action error];
//}
//
//+ (id) syncTask {
//	return FLAutorelease([[[self class] alloc] init]);
//}
//
//- (void) requestCancel {
//	[NSObject cancelPreviousPerformRequestsWithTarget:self];
//    [_action.action requestCancel];
//	
//    if([NSThread currentThread] == [NSThread mainThread]) {
//        [self.delegate syncTaskWasCancelled:self];
//    }
//    else {
//        [self performSelectorOnMainThread:@selector(requestCancel) withObject:nil waitUntilDone:YES];
//    }
//}
//
//- (BOOL) willBeginActionInContext:(FLOperationContext*) context {
//
////    if(!self.error && !self.wasCancelled && action.onPrepare){
////        action.onPrepare(action);
////    }
////    
////    if(!action.error && !action.wasCancelled) {
////        [action beginActionInContext:self];
////    }
//
//    return YES;
//}
//
//- (void) beginActionInContext:(FLOperationContext*) context {
//	
//	self.actionContext = context;
//}
//
//- (void) dealloc {
//    
//    FLAction* action = self.action;
//    if(action) {
//        [action requestCancel];
//    }
//    
//    [self.delegate syncTaskDidFinish:self];
//    self.delegate = nil;
//
//    FLRelease(_actionID);
//	FLRelease(_operationContext);
//	FLRelease(_progressController);
//	FLRelease(_action);
//	FLSuperDealloc();
//}
//
//- (void) cancelCallback:(id) sender {
//	[self requestCancel];
//}
//
//@end
//
//@implementation ZFSyncTaskProgressDelegate
//
//- (void) dealloc {
//	FLRelease(_progressController);
//	FLSuperDealloc();
//}
//
//- (void) hideProgress {
//    if(_progressController) {
//        [_progressController hideProgress];
//        FLReleaseWithNil(_progressController);
//    }
//}
//
//- (void) syncTaskDidFinish:(ZFSyncTask*) task {
//
//}
//
//- (void) syncTaskWasCancelled:(ZFSyncTask*) task {
//}
//
//- (void) syncTaskHideProgress:(ZFSyncTask*) task {
//}
//
//- (void) syncTask:(ZFSyncTask*) task
//     finishedWithError:(NSError*) error {
//    
//}
//
//@end
