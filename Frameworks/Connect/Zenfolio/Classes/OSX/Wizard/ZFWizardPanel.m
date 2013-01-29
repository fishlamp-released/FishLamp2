//
//  ZFWizardPanel.m
//  ZenLib
//
//  Created by Mike Fullerton on 1/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFWizardPanel.h"

@interface ZFWizardPanel ()
@property (readwrite, strong, nonatomic) ZFProgressSheet* progressWindow;
@end

@implementation ZFWizardPanel

@synthesize context = _context;
@synthesize progressWindow = _progressWindow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_context release];
    [_progressWindow release];
    
    [super dealloc];
}
#endif

- (void) showModalShield {
}

- (void) hideModalShield {
}

- (void)progressClosed:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
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
        [self.context requestCancel];
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


@end
