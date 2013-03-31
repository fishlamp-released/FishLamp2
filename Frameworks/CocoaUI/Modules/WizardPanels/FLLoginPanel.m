//
//  FLLoginPanel.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLLoginPanel.h"
#import "NSObject+Blocks.h"
#import "FLViewController.h"
#import "FLKeychain.h"

@interface FLLoginPanel ()
- (void) applicationWillTerminate:(id)sender;
@property (readwrite, strong, nonatomic) FLUserService* userService;
- (void) updateNextButton;
- (IBAction) resetLogin:(id) sender;
@end

@implementation FLLoginPanel

@synthesize userService = _userService;
@synthesize delegate = _delegate;

- (id) init {
    return [self initWithNibName:@"FLLoginPanel" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", nil);
        self.prompt =  NSLocalizedString(@"Login to your account", nil);
    
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillTerminate:)
                                                     name: NSApplicationWillTerminateNotification
                                                   object: [NSApplication sharedApplication]];
    
        self.panelFillsView = NO;
    }
    
    return self;
}

+ (id) loginPanelWithDelegate:(id<FLLoginPanelDelegate>) delegate {
    FLLoginPanel* panel = FLAutorelease([[[self class] alloc] init]);
    panel.delegate = delegate;
    return panel;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if FL_MRC
    [_userService release];
    [super dealloc];
#endif
}

- (void) loadView {
    [super loadView];
    
    [self view];
    _userNameTextField.nextKeyView = _passwordEntryField;
    _passwordEntryField.nextKeyView = _userNameTextField;
}

- (void) setUserName:(NSString*) userName {
    [_userNameTextField setStringValue:FLEmptyStringOrString(userName)];
}

- (NSString *)userName {
	return [_userNameTextField stringValue];
}

- (void) setPassword:(NSString*) password {
    [_passwordEntryField setStringValue:FLEmptyStringOrString(password)];
}

- (NSString *)password {
	return [_passwordEntryField stringValue];
}

- (BOOL) savePasswordInKeychain {
    return [_savePasswordCheckBox integerValue] == 1;
}

- (void) setSavePasswordInKeychain:(BOOL) saveIt {
    [_savePasswordCheckBox setIntegerValue:saveIt];
}

- (BOOL) canLogin {
	return	self.userService.canAuthenticate;
}

- (void) updateNextButton {
    self.canOpenNextPanel = self.canLogin;
}

#if OSX
- (void)controlTextDidEndEditing:(NSNotification *)note {
	if ( [note object] == _userNameTextField || [note object] == _passwordEntryField ) {
		if ( ![self canLogin] ) {
			return;
		}
		
		NSNumber *reason = [[note userInfo] objectForKey:@"NSTextMovement"];
		if ([reason intValue] == NSReturnTextMovement) {
			//	leave time for text field to clean up repainting
			[[self.buttons nextButton] performSelector:@selector(performClick:) withObject:nil afterDelay:0.1];
		}
	}
}


- (void)controlTextDidChange:(NSNotification *)note {
	if ( [note object] == _userNameTextField ) {
        [self.userService setUserName:_userNameTextField.stringValue];
    }
	if ( [note object] == _passwordEntryField ) {
        [self.userService setPassword:_passwordEntryField.stringValue];
    }
    
    [self updateNextButton];
}

#endif

- (IBAction) resetLogin:(id) sender {
    // this is from the "forgot login" button
    
    [self.delegate loginPanelForgotPasswordButtonWasClicked:self];
}

- (void) updateVisibleCredentials {
    [self setSavePasswordInKeychain:self.userService.rememberPassword];
    [self setUserName:self.userService.userName];
    [self setPassword:self.userService.password];
}

- (void) saveCredentials {  
    [self.userService saveCredentials];
}

- (IBAction) passwordCheckboxToggled:(id) sender {
    self.userService.rememberPassword = [self savePasswordInKeychain];
    [self saveCredentials];
}

- (void) applicationWillTerminate:(id)sender {
    [self saveCredentials];
}
   
- (void) respondToNextButton:(BOOL*) handledIt {
    if(self.userService.canAuthenticate) {
        [self saveCredentials];
        [self.userService openService:self];
    }
    else {
        *handledIt = YES; 
    }
//    if(self.isAuthenticated) {
//        *handledIt = NO;
//    }
//    else {
//        self.buttons.nextButton.enabled = NO;
//        [self startAuthenticating];
//        *handledIt = YES;
//    }
}

- (void) panelDidAppear {
    [super panelDidAppear];
    [self updateNextButton];

    [self performBlockOnMainThread:^{
        if(FLStringIsEmpty(self.userName)) {
            [self.view.window makeFirstResponder:_userNameTextField];
        }
        else {
            [self.view.window makeFirstResponder:_passwordEntryField];
        }
        [self updateNextButton];
    }];
}

//- (BOOL) becomeFirstResponder {
//    [self updateNextButton];
//    return YES;
//}

- (void) panelWillAppear {
    [super panelWillAppear];
    self.userService = [self.delegate loginPanelGetUserService:self];
    [self.userService closeService:self];
    [self.userService loadCredentials];
    [self updateVisibleCredentials];
    [self updateNextButton];
}

- (void) panelWillDisappear {
    [self.view.window makeFirstResponder:self.view.window];
    [super panelWillDisappear];
    [self saveCredentials];
    self.userService = nil;
}

- (void) panelDidDisappear {
    [super panelDidDisappear];
    
    _userNameTextField.stringValue = @"";
    _passwordEntryField.stringValue = @"";
}

@end

#endif