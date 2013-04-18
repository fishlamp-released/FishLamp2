//
//  NSWindowController+FLModalAdditions.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

@interface NSWindowController (FLModalAdditions)
@property (readonly, assign, nonatomic) NSWindow* modalInWindow;

- (void) showModallyInWindow:(NSWindow*) window 
           withDefaultButton:(NSButton*) button;

- (IBAction) closeIfModalInWindow:(id) sender;
@end

@interface NSWindow (FLModalAdditions)
- (void) closeModalWindowController;
@property (readonly, strong, nonatomic) NSWindowController* modalWindowController;
@end