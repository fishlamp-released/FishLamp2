//
//  ZFWizardViewController.m
//  ZenLib
//
//  Created by Mike Fullerton on 1/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFWizardViewController.h"
#import "ZFErrorSheet.h"
#import "FLView.h"

@interface ZFWizardViewController ()
@property (readwrite, strong, nonatomic) ZFProgressSheet* progressWindow;
@end

@implementation ZFWizardViewController

@synthesize progressWindow = _progressWindow;

#if FL_MRC
- (void) dealloc {
    [_progressWindow release];
    [super dealloc];
}
#endif

- (void) loadView {

    [super loadView];

    self.titleTextField.font = [NSFont boldZenfolioFontOfSize:16];
    self.titleTextField.textColor = [NSColor zenfolioOrange];
//    self.backgroundView = [self imageBarView:self.view.bounds];

//    [self.titleEnclosureView addSubview:[self imageBarView:self.view.bounds] positioned:NSWindowBelow relativeTo:nil];

    FLView* whiteView = FLAutorelease([[FLView alloc] initWithFrame:CGRectZero]);
    whiteView.backgroundColor = [NSColor whiteColor];
    self.wizardPanelBackgroundView = whiteView;
    
    self.breadcrumbBar.textFont = [NSFont boldZenfolioFontOfSize:12];
}

- (void) showError:(NSString*) error {
    ZFErrorSheet* errorSheet = [ZFErrorSheet errorSheet];
    [errorSheet setErrorString:error];
    [errorSheet showInWindow:self.view.window completion:^{
    
    }];
}

- (void)progressClosed:(NSWindow *)sheet 
            returnCode:(NSInteger) returnCode 
           contextInfo:(void *)contextInfo {
   self.progressWindow = nil;
   [self hideModalShield];
}

- (void) showProgress:(NSString*) title {
    NSWindow* window = self.view.window; 
     
    self.progressWindow = [ZFProgressSheet progressWindowController];
    self.progressWindow.progressString = title;
    [self.progressWindow.window setFrame:
        FLRectCenterRectInRect(self.view.window.frame, self.progressWindow.window.frame) display:NO];
    
    self.progressWindow.cancelBlock = ^{
        [self.userContext requestCancel];
        [[NSApplication sharedApplication] endSheet:self.progressWindow.window];
        [self.progressWindow close];
        self.progressWindow = nil;
    };

    [[NSApplication sharedApplication] beginSheet:self.progressWindow.window 
                                   modalForWindow:window
                                    modalDelegate:nil //self
                                   didEndSelector:nil //@selector(progressClosed:returnCode:contextInfo:) 
                                      contextInfo:nil];    
}

- (void) hideProgress {
    [[NSApplication sharedApplication] endSheet:self.progressWindow.window];
    [self.progressWindow close];
    self.progressWindow = nil;
}

//            [self.progressWindow setValue:1 total:1];
//            [FLForegroundQueue dispatchBlockWithDelay:0.5 block:^{
//                [[NSApplication sharedApplication] endSheet:self.progressWindow.window];
//                [self.progressWindow close];
//                self.progressWindow = nil;
//            
//            }];

- (void) willStartWizardInWindow:(NSWindow*) window {

    [super willStartWizardInWindow:window];

    self.titleTextField.font = [NSFont boldZenfolioFontOfSize:16];
    self.titleTextField.textColor = [NSColor zenfolioOrange];
//    self.backgroundView = [self imageBarView:self.view.bounds];

//    [self.titleEnclosureView addSubview:[self imageBarView:self.view.bounds] positioned:NSWindowBelow relativeTo:nil];

    FLView* whiteView = FLAutorelease([[FLView alloc] initWithFrame:CGRectZero]);
    whiteView.backgroundColor = [NSColor whiteColor];
    self.wizardPanelBackgroundView = whiteView;
}


//- (void) finishedLoginWithResult:(FLResult) result {
//    
//    [self stopLoginProgress];
//    
//    if([result error]) {
//        NSBeep();
//        if ([[result error] zenfolioErrorCode] == ZFErrorCodeInvalidCredentials ) {
//            NSAlert *alert = FLAutorelease([NSAlert new]);
//            [alert setMessageText:@"Login incorrect"];
//            [alert setInformativeText:@"Please confirm your login information and try again."];
//            [alert runModal];
//        } else {
//            NSAlert *alert = FLAutorelease([NSAlert new]);
//            [alert setMessageText:@"Unexpected Error"];
//            [alert setInformativeText:[[result error] localizedDescription]];
//            [alert runModal];
//
//            //	some other error, don't know how to handle
//            NSLog(@"login error : %@", [[result error] localizedDescription]);
//        }
//    }
//}


@end