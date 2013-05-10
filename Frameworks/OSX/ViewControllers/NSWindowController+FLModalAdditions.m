//
//  NSWindowController+FLModalAdditions.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSWindowController+FLModalAdditions.h"

@interface NSWindow (FLModalAdditionsMore)
//@property (readwrite, strong, nonatomic) NSWindowController* modalWindowController;
//@property (readonly, assign, nonatomic) NSWindow* modalInWindow;
@end


@implementation NSWindow (FLModalAdditions)

//FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, modalWindowController, setModalWindowController, NSWindowController*);

//- (void) closeModalWindowController {
//    [self.modalWindowController.window close];
//    [self.modalWindowController.window orderOut:self];
//}

- (IBAction) closeModalWindow:(id) sender {
    [[NSApplication sharedApplication] endSheet:self];
}
@end

@implementation NSViewController (FLModalAdditions)

FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, modalWindowController, setModalWindowController, NSWindowController*);
FLSynthesizeAssociatedProperty(FLAssociationPolicyAssignNonatomic, previousFirstResponderForModal, setPreviousFirstResponderForModal, id);
FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, modalSession, setModalSession, NSValue*);


//- (IBAction) closeIfModalInWindow:(id) sender {
//    if(self.modalInWindow) {
//        [[NSApplication sharedApplication] endSheet:self.window];
//    }
//    
//}


- (void)sheetDidEnd:(NSAlert*)alert 
         returnCode:(NSInteger)returnCode 
        contextInfo:(void*)contextInfo {

    [NSApp endModalSession:[[self modalSession] pointerValue]];
    [self.modalWindowController.window orderOut:self];
    
    self.modalWindowController = nil;
    self.previousFirstResponderForModal = nil;
    self.modalSession = nil;
    
    [self.view.window makeFirstResponder:self.previousFirstResponderForModal];
}

- (void) showModalWindow:(NSWindowController*) windowController 
       withDefaultButton:(NSButton*) button {
    
    self.modalWindowController = windowController;
    self.previousFirstResponderForModal = self.view.window.firstResponder;
    
    
    [[NSApplication sharedApplication] beginSheet:windowController.window  
                                   modalForWindow:self.view.window
                                   modalDelegate:self 
                                   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) 
                                      contextInfo:nil];
                                      
    NSModalSession modalSession = [NSApp beginModalSessionForWindow:self.view.window];
    self.modalSession = [NSValue valueWithPointer:modalSession];
    
    [NSApp runModalSession:modalSession];
    [self.view.window makeFirstResponder:windowController.window];
    
    if(button) {
        [windowController.window setDefaultButtonCell:[button cell]];
        [self.view.window setDefaultButtonCell:[button cell]];
    }
}



@end