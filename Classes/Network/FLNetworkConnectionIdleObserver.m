//
//  FLNetworkTimeoutObserver.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLNetworkConnectionIdleObserver.h"

#import "FLAlertViewController.h"
#import "FLWarningNotificationViewController.h"

@interface FLNetworkConnectionIdleObserver ()
@property (readwrite, copy, nonatomic) FLNetworkTimeoutObserverFormatMessage onFormatWarningString;
@property (readwrite, strong, nonatomic) UIViewController* alertViewController;
@end

@implementation FLNetworkConnectionIdleObserver 

@synthesize onCreateAlert = _onCreateAlert;
@synthesize alertViewController = _alertViewController;
@synthesize warningTimespan = _warningTimespan; 
@synthesize onFormatWarningString = _onFormatWarningString; 

- (id) init {
    self = [super init];
    if(self) {
        self.warningTimespan = FLNetworkTimeoutObserverDefaultWarningTimespan;

        self.onCreateAlert = ^(FLNetworkConnectionIdleObserver* observer) {
            return [FLWarningNotificationViewController warningNotificationViewController];
        };

        self.onFormatWarningString = ^(FLNetworkConnectionIdleObserver* observer, FLNetworkConnection* connection) {
            return [NSString stringWithFormat:FLNetworkTimeoutObserverDefaultMessage, connection.idleTimespan];
        };
        
        [self observeEvent:FLNetworkEventOnIdle target:self];
        [self observeEvent:FLNetworkEventDidClose target:self];
        [self observeEvent:FLNetworkEventDidStopObserving target:self];
    }
    return self;   
}

- (void) networkConnectionDidStopObserving:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
        if(_alertViewController) {
            [self hideWarning];
        }
    }];
}

- (void) networkConnectionDidClose:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
        if(_alertViewController) {
            [self hideWarning];
        }
    }];
}

- (void) networkConnectionOnIdle:(FLNetworkConnection*) connection {
    [self performBlockOnMainThread:^{
        if(connection.idleTimespan > self.warningTimespan) {
            if(!_alertViewController) {
                [self showWarning];
            }
            
            FLAssertIsNotNil(self.onFormatWarningString);
            FLAssertIsNotNil(self.alertViewController);
            self.alertViewController.title = self.onFormatWarningString(self, connection);
        }
        else if(_alertViewController) {
            [self hideWarning];
        }
    }];
}


- (void) showWarning {
    if(!_alertViewController) {
        FLAssertIsNotNil(self.onCreateAlert);
        self.alertViewController = self.onCreateAlert(self);
        FLAssertIsNotNil(self.alertViewController);
        [self.alertViewController presentViewControllerAnimated:YES];
    }
}

- (void) hideWarning {

    if(_alertViewController) {

        [self performBlockOnMainThread:^{
            if(_alertViewController) {
                [_alertViewController dismissViewControllerAnimated:YES];
                FLReleaseWithNil(_alertViewController);
            }
        }];

    }

}

- (void) dealloc {
    [self hideWarning];

#if FL_DEALLOC 
    [_onFormatWarningString release];
    [_onCreateAlert release];
    [_alertViewController release];
    [super dealloc];
#endif
}


@end
