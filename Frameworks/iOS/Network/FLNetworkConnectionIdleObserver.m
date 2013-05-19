//
//  FLNetworkTimeoutObserver.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
//
//#import "FLNetworkConnectionIdleObserver.h"
//
//#import "FLAlert.h"
//#import "FLWarningNotificationAlert.h"
//
//@interface FLNetworkConnectionIdleObserver ()
//@property (readwrite, copy, nonatomic) FLNetworkTimeoutObserverFormatMessage onFormatWarningString;
//@property (readwrite, strong, nonatomic) UIViewController* alertViewController;
//@end
//
//@implementation FLNetworkConnectionIdleObserver 
//
//@synthesize onCreateAlert = _onCreateAlert;
//@synthesize alertViewController = _alertViewController;
//@synthesize warningTimespan = _warningTimespan; 
//@synthesize onFormatWarningString = _onFormatWarningString; 
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        self.warningTimespan = FLNetworkTimeoutObserverDefaultWarningTimespan;
//
//        self.onCreateAlert = ^(FLNetworkConnectionIdleObserver* observer) {
//            return [FLWarningNotificationAlert warningNotificationAlert];
//        };
//
//        self.onFormatWarningString = ^(FLNetworkConnectionIdleObserver* observer,
//                                       FLNetworkConnection* connection,
//                                       NSTimeInterval lastActivity,
//                                       NSTimeInterval idleDuration) {
//            return [NSString stringWithFormat:FLNetworkTimeoutObserverDefaultMessage, idleDuration];
//        };
//    }
//    return self;   
//}
//
//- (void) observerWasRemovedFromNetworkConnection:(FLNetworkConnection*) connection {
//    [self performBlockOnMainThread:^{
//        if(_alertViewController) {
//            [self hideWarning];
//        }
//    }];
//}
//
//- (void) networkConnectionFinished:(FLNetworkConnection*) connection {
//    [self performBlockOnMainThread:^{
//        if(_alertViewController) {
//            [self hideWarning];
//        }
//    }];
//}
//
//- (void) networkConnection:(FLNetworkConnection*) connection
//                 idleSince:(NSTimeInterval) lastActivityTimeStamp
//              idleDuration:(NSTimeInterval) idleDuration {
//    
//    [self performBlockOnMainThread:^{
//        if(idleDuration > self.warningTimespan) {
//            if(!_alertViewController) {
//                [self showWarning];
//            }
//            
//            FLAssertIsNotNil(self.onFormatWarningString);
//            FLAssertIsNotNil(self.alertViewController);
//            self.alertViewController.title = self.onFormatWarningString(self, connection, idleDuration, lastActivityTimeStamp);
//        }
//        else if(_alertViewController) {
//            [self hideWarning];
//        }
//    }];
//}
//
//
//- (void) showWarning {
//    if(!_alertViewController) {
//        FLAssertIsNotNil(self.onCreateAlert);
//        self.alertViewController = self.onCreateAlert(self);
//        FLAssertIsNotNil(self.alertViewController);
//        [self.alertViewController showViewControllerAnimated:YES];
//    }
//}
//
//- (void) hideWarning {
//
//    if(_alertViewController) {
//
//        [self performBlockOnMainThread:^{
//            if(_alertViewController) {
//                [_alertViewController hideViewController:YES];
//                FLReleaseWithNil(_alertViewController);
//            }
//        }];
//
//    }
//
//}
//
//- (void) dealloc {
//    [self hideWarning];
//
//#if FL_MRC 
//    FLRelease(_onFormatWarningString);
//    FLRelease(_onCreateAlert);
//    FLRelease(_alertViewController);
//    FLSuperDealloc();
//#endif
//}
//
//
//@end
