//
//  NSWindowController+FLModalAdditions.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSWindowController+FLModalAdditions.h"
#import "FLResponderChainState.h"

@implementation NSViewController (FLModalAdditions)

- (FLSheetHandler*) showModalWindow:(NSWindowController*) windowController 
       withDefaultButton:(NSButton*) button {
    
    return [self.view.window showModalWindow:windowController withDefaultButton:button];
}

- (FLSheetHandler*) showModalWindow:(NSWindowController*) windowController {
    
    return [self.view.window showModalWindow:windowController withDefaultButton:nil];
}

@end

@implementation NSWindowController (NSModalAdditions)

- (NSButton*) closeModalWindowButton {
    return nil;
}
@end

@implementation NSWindow (NSModalAdditions)

- (IBAction) closeModalWindow:(id) sender {
    [[NSApplication sharedApplication] endSheet:self];
}

- (FLSheetHandler*) showModalWindow:(NSWindowController*) modalWindow 
                  withDefaultButton:(NSButton*) button {

    FLAssertNotNil(modalWindow);

    FLSheetHandler* handler = [FLSheetHandler sheetHandler];
    handler.modalWindowController = modalWindow;
    handler.defaultButton = button;
    handler.hostWindow = self;
    handler.appModal = YES;
    [handler beginSheet];
    return handler;
}

- (FLSheetHandler*) showModalWindow:(NSWindowController*) modalWindow {
    return [self showModalWindow:modalWindow withDefaultButton:nil];
}

@end

@interface FLSheetHandler ()
@property (readwrite, assign, nonatomic) NSModalSession modalSession;
@property (readwrite, strong, nonatomic) FLResponderChainState* responderState;
@end

@implementation FLSheetHandler 
@synthesize modalSession = _modalSession;
@synthesize modalWindow = _modalWindow;
@synthesize modalWindowController = _modalWindowController;
@synthesize hostWindow = _hostWindow;
@synthesize appModal = _appModal;
@synthesize defaultButton = _defaultButton;
@synthesize responderState = _responderState;

+ (id) sheetHandler {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_modalWindow release];
    [_modalWindowController release];
    [_hostWindow release];
    [_defaultButton release];
    [super dealloc];
}
#endif

- (void) finish {
    if(_modalSession) {
        [NSApp endModalSession:_modalSession];
        _modalSession = nil;
    }
    [_modalWindow orderOut:self];


    [_hostWindow makeFirstResponder:nil];

//    [self.responderState restore];

    self.responderState = nil;
    self.hostWindow = nil;
    self.modalWindow = nil;
    self.modalWindowController = nil;
    self.modalSession = nil;
}

- (void) sheetDidEnd:(NSWindow*) sheet 
         returnCode:(NSInteger)returnCode 
        contextInfo:(void*)contextInfo {

    FLSheetHandler* handler = FLAutorelease(FLBridgeTransfer(FLSheetHandler*, contextInfo));
    [handler finish];
}

- (void) beginSheet {

    if(!self.modalWindow && self.modalWindowController) {
        self.modalWindow = self.modalWindowController.window;
    }

    FLAssertNotNilWithComment(self.hostWindow, @"host window not set");
    FLAssertNotNilWithComment(self.modalWindow, @"modal window or modal window controller not set");

//    self.responderState = [FLResponderChainState responderState:_hostWindow];

    [[NSApplication sharedApplication] beginSheet:self.modalWindow
                                   modalForWindow:self.hostWindow
                                    modalDelegate:self 
                                   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
                                      contextInfo:FLBridgeRetain(void*, self)];

    self.modalWindow.nextResponder = self.hostWindow;
    [self.hostWindow makeFirstResponder:[self.modalWindow initialFirstResponder]];

    if(self.appModal) {
        self.modalSession = [NSApp beginModalSessionForWindow:_hostWindow];
        [NSApp runModalSession:self.modalSession];
    }

    if(!self.defaultButton) {
        self.defaultButton = [self.modalWindowController closeModalWindowButton];
    }
    
    if(self.defaultButton) {
        [self.defaultButton setTarget:self.modalWindow];
        [self.defaultButton setAction:@selector(closeModalWindow:)];
    }
}


@end

