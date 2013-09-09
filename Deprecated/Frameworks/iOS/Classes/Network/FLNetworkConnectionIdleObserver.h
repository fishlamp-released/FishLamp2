//
//  FLNetworkTimeoutObserver.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
//
//#import <Foundation/Foundation.h>
//
//#import "FLNetworkConnection.h"
//#import "FLNetworkConnectionObserver.h"
//
//#define FLNetworkTimeoutObserverDefaultMessage NSLocalizedString(@"The server hasn't responded for %0.f seconds.", nil)
//#define FLNetworkTimeoutObserverDefaultWarningTimespan 60.0f
//
//@class FLNetworkConnectionIdleObserver;
//
//typedef UIViewController* (^FLNetworkTimeoutObserverCreateAlert)(FLNetworkConnectionIdleObserver* observer);
//typedef NSString* (^FLNetworkTimeoutObserverFormatMessage)(FLNetworkConnectionIdleObserver* observer, FLNetworkConnection* connection, NSTimeInterval lastActivity, NSTimeInterval idleDuration); 
//
//@interface FLNetworkConnectionIdleObserver : NSObject<FLNetworkConnectionObserver> {
//@private
//    UIViewController* _alertViewController;
//    FLNetworkTimeoutObserverCreateAlert _onCreateAlert;
//    FLNetworkTimeoutObserverFormatMessage _onFormatWarningString;
//    NSTimeInterval _warningTimespan;
//}
//
///// onCreateAlert is block in which you should create and return the AlertViewController
//
///// For example:
/////     myAlert.onCreateAlert = ^(FLNetworkTimeoutObserver* observer) { return [FLWarningNotifictionViewController warningNotificationViewController]; };
/////
///// Note: FLWarningNotification by default
//@property (readwrite, copy, nonatomic) FLNetworkTimeoutObserverCreateAlert onCreateAlert; 
//
///// Set the alertViewController. Note that it will be destroyed when hidden.
//
///// Best bet is to set with the onCreateAlert
//@property (readonly, strong, nonatomic) UIViewController* alertViewController;
//
///// How long before the idle time in the connection creates and shows the alert.
//
///// By default this is 30 seconds
//@property (readwrite, assign, nonatomic) NSTimeInterval warningTimespan;
//
//@property (readonly, copy, nonatomic) FLNetworkTimeoutObserverFormatMessage onFormatWarningString;
//
//- (void) showWarning;
//- (void) hideWarning;
//
//@end
//
