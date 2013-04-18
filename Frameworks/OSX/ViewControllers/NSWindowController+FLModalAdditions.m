//
//  NSWindowController+FLModalAdditions.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSWindowController+FLModalAdditions.h"

@interface NSWindow (FLModalAdditionsMore)
@property (readwrite, strong, nonatomic) NSWindowController* modalWindowController;
@end


@implementation NSWindow (FLModalAdditions)
FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, modalWindowController, setModalWindowController, NSWindowController*);

- (void) closeModalWindowController {
    [self.modalWindowController closeIfModalInWindow:self];
}

@end

@implementation NSWindowController (FLModalAdditions)

FLSynthesizeAssociatedProperty(FLAssociationPolicyAssignNonatomic, modalInWindow, setModalInWindow, NSWindow*);
FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, modalSession, setModalSession, NSValue*);
FLSynthesizeAssociatedProperty(FLAssociationPolicyAssignNonatomic, previousFirstResponderForModal, setPreviousFirstResponderForModal, id);

- (IBAction) closeIfModalInWindow:(id) sender {
    if(self.modalInWindow) {
        [[NSApplication sharedApplication] endSheet:self.window];
    }
    
    [self.window makeFirstResponder:self.previousFirstResponderForModal];
}


- (void)sheetDidEnd:(NSAlert*)alert 
         returnCode:(NSInteger)returnCode 
        contextInfo:(void*)contextInfo {

    [NSApp endModalSession:[[self modalSession] pointerValue]];
    [self.window orderOut:self.window];
    
    self.modalInWindow.modalWindowController = nil;
    self.modalInWindow = nil;
    self.modalSession = nil;
}



- (void) showModallyInWindow:(NSWindow*) window 
           withDefaultButton:(NSButton*) button {
    
    self.modalInWindow = window;
    self.previousFirstResponderForModal = self.window.firstResponder;
    
    window.modalWindowController = self;

    [[NSApplication sharedApplication] beginSheet:self.window  
                                   modalForWindow:window
                                   modalDelegate:self 
                                   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
                                      contextInfo:nil];
                                      
    NSModalSession modalSession = [NSApp beginModalSessionForWindow:self.window];
    self.modalSession = [NSValue valueWithPointer:modalSession];
    
    [NSApp runModalSession:modalSession];
    [window makeFirstResponder:window];
    
    if(button) {
        [self.window setDefaultButtonCell:[button cell]];
    }
}
@end