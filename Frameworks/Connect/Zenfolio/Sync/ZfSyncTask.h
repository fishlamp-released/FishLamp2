//
//	ZFSyncTask.h
//	MyZen
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FLAction.h"
//#import "FLProgressViewController.h"
//#import "FLWeakReference.h"
//#import "FLAction.h"
//#import "FLOperationContext.h"

//@interface ZFSyncTask : FLAction {
//@private
////	FLOperationContext* _operationContext;
//	BOOL _showErrorIfNoNetwork;
//
////	BOOL _wasCancelled;
////    BOOL _didStart;
////    BOOL _didPrepare;
////    BOOL _didFinish;
////    
////    NSNumber* _actionID;
////	id<FLProgressViewController> _progressController;
////    dispatch_block_t _willBeginCallback;
////    dispatch_block_t _didCompleteCallback;
////    FLActionDescription* _actionDescription;
//}
//
////- (FLAction*) createAction;
//
////@property (readwrite, assign, nonatomic) id delegate;
////@property (readwrite, weak, nonatomic) FLAction* action;
//@property (readwrite, assign, nonatomic) BOOL showErrorIfNoNetwork;
//
//- (id) init;
//
//+ (id) syncTask;
//
////- (void) cancelCallback:(id) sender;
//
////@property (readonly, assign) BOOL wasCancelled; // needs to be atomic.
//
////- (void) requestCancel;
//
//@end

//@protocol ZFSyncTaskObserver <NSObject>
//
//- (void) syncTaskDidFinish:(ZFSyncTask*) task;
//
//- (void) syncTaskWasCancelled:(ZFSyncTask*) task;
////- (void) syncTaskHideProgress:(ZFSyncTask*) task;
//
//- (void) syncTask:(ZFSyncTask*) task
//     finishedWithError:(NSError*) error;
//
//@end