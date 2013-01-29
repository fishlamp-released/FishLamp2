//
//  ZFLoginWizardPanel.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 1/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFLoginWizardPanel.h"
#import "FLLocalNotification.h"

#define	RESET_URL		@"https://secure.zenfolio.com/zf/resetPassword.aspx"


@interface ZFLoginWizardPanel ()

@end

@implementation ZFLoginWizardPanel

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    
    return self;
}




- (void) loginWizardPanelResetPassword:(FLLoginWizardPanel*) panel {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:RESET_URL]];
}

- (void) loginWizardPanelStartAuthenticating:(FLLoginWizardPanel*) loginPanel {
     
    [self.wizard showProgress:@"Logging into your Zenfolio account…"]; 
     
    FLUserLogin* userLogin = [FLUserLogin userLogin:loginPanel.userName password:loginPanel.password];
    [[self.wizard userContext] setUserLogin:userLogin];
        
//    ZFSyncGroupHierarchyOperation* operation = [ZFSyncGroupHierarchyOperation syncGroupHierarchyOperation:userLogin];    
//    [operation addObserver:self];    

//    [operation startOperationInContext:_downloaderSession 
//                            completion:^(FLResult result) {
    
    
    FLHttpRequestObserver* observer = [FLHttpRequestObserver httpRequestObserver];

    observer.willOpen = ^{
        [self.wizard progressWindow].progressString = @"Downloading Gallery Info…"; 
    };

    observer.didFinish = ^(FLResult result) {
        [self.wizard hideProgress];

        if([result error]) {
            [NSApp requestUserAttention:NSCriticalRequest];
            
            FLLocalNotification* notification = [FLLocalNotification localNotificationWithName:@"Authentication Failed"];
            
            notification.subtitle = @"Please try again";
            [notification deliverNotification];
            
        }
        else {
            [[self.wizard userContext] setRootGroup:result];
            [self.wizard showNextWizardPanelAnimated:YES completion:nil];
        }
    };
    
    FLHttpRequest* request = [ZFHttpRequest loadGroupHierarchyHttpRequest:userLogin.userName];
    FLAssertNotNil_(request);
    
    [request startRequestInContext:[self.wizard userContext] withObserver:observer];
}

- (void) loginWizardPanelCancelAuthentication:(FLLoginWizardPanel*) loginPanel  {
    [[self.wizard userContext] requestCancel];
}

- (BOOL) loginWizardPanelIsAuthenticated:(FLLoginWizardPanel*) loginPanel {
    return [[self.wizard userContext] isContextAuthenticated];
}

- (NSString*) loginWizardPanelPasswordDomain:(FLLoginWizardPanel*) loginPanel {
    return @"www.zenfolio.com";
}

@end