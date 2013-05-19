//
//  NSWindowController+FLModalAdditions.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSWindowController+FLModalAdditions.h"

@implementation NSViewController (FLModalAdditions)

- (FLSheetHandler*) showModalWindow:(NSWindowController*) windowController 
       withDefaultButton:(NSButton*) button {
    
    return [self.view.window showModalWindow:windowController withDefaultButton:button];
}

- (FLSheetHandler*) showModalWindow:(NSWindowController*) windowController {
    
    return [self.view.window showModalWindow:windowController withDefaultButton:nil];
}

@end

@implementation NSWindow (NSModalAdditions)

- (NSButton*) closeModalWindowButton {
    return nil;
}

- (IBAction) closeModalWindow:(id) sender {
    [[NSApplication sharedApplication] endSheet:self];
}

- (FLSheetHandler*) showModalWindow:(NSWindowController*) modalWindow 
            withDefaultButton:(NSButton*) button {
    
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

@property (readwrite, strong, nonatomic) id firstResponder;
@end

@implementation FLSheetHandler 
@synthesize modalSession = _modalSession;
@synthesize modalWindow = _modalWindow;
@synthesize modalWindowController = _modalWindowController;
@synthesize hostWindow = _hostWindow;
@synthesize firstResponder = _firstResponder;
@synthesize appModal = _appModal;
@synthesize defaultButton = _defaultButton;


+ (id) sheetHandler {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_modalWindow release];
    [_modalWindowController release];
    [_hostWindow release];
    [_firstResponder release];
    [super dealloc];
}
#endif

- (void) finish {
    if(_modalSession) {
        [NSApp endModalSession:_modalSession];
    }
    [_modalWindow orderOut:self];
    [_hostWindow makeFirstResponder:_firstResponder];

    self.hostWindow = nil;
    self.modalWindow = nil;
    self.modalWindowController = nil;
    self.modalSession = nil;
    self.firstResponder = nil;
}

- (void) sheetDidEnd:(NSWindow*) sheet 
         returnCode:(NSInteger)returnCode 
        contextInfo:(void*)contextInfo {

    FLSheetHandler* handler = FLAutorelease(FLBridgeTransfer(FLSheetHandler*, contextInfo));
    [handler finish];
}

- (void)keyDown:(NSEvent *)theEvent {

    FLLog(@"got it");
}


- (void) beginSheet {

    if(!self.modalWindow && self.modalWindowController) {
        self.modalWindow = self.modalWindowController.window;
    }

    FLAssertNotNilWithComment(self.hostWindow, @"host window not set");
    FLAssertNotNilWithComment(self.modalWindow, @"modal window or modal window controller not set");

    self.firstResponder = self.hostWindow.firstResponder;
    if(self.appModal) {
        self.modalSession = [NSApp beginModalSessionForWindow:_hostWindow];
        [NSApp runModalSession:self.modalSession];
    }

    [[NSApplication sharedApplication] beginSheet:self.modalWindow
                                   modalForWindow:self.hostWindow
                                    modalDelegate:self 
                                   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
                                      contextInfo:FLBridgeRetain(void*, self)];
    

    if(!self.defaultButton) {
        self.defaultButton = [self.modalWindowController closeModalWindowButton];
    }
    
    if(self.defaultButton) {
        [self.defaultButton setTarget:self.modalWindow];
        [self.defaultButton setAction:@selector(closeModalWindow:)];
//        [hostWindow setDefaultButtonCell:[button cell]];
//        [modalWindow setDefaultButtonCell:[button cell]];
//        [modalWindow makeFirstResponder:button];
    }    
    else {
//        if(self.modalWindowController) {
//            [modalWindow makeFirstResponder:self.modalWindowController];
//        }
    }
    
    self.nextResponder = self.modalWindow;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.modalWindow makeFirstResponder:self];
    });
}

//- (void) beginSheetWithWindowController:(NSWindowController*) modalWindowController modalForWindow:(NSWindow*) hostWindow  withDefaultButton:(NSButton*) button {
//    self.modalWindowController = modalWindowController;
//    [self beginSheetWithWindow:modalWindowController.window modalForWindow:hostWindow withDefaultButton:button];
//}




@end

