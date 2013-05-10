//
//  NSWindowController+FLModalAdditions.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

@interface NSViewController (FLModalAdditions)

- (void) showModalWindow:(NSWindowController*) window 
       withDefaultButton:(NSButton*) button;


@end

@interface NSWindow (FLModalAdditions)
- (IBAction) closeModalWindow:(id) sender;
@end
