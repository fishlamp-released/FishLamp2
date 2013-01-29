//
//  ZFErrorSheet.m
//  ZenLib
//
//  Created by Mike Fullerton on 1/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFErrorSheet.h"

@interface ZFErrorSheet ()

@end

@implementation ZFErrorSheet

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_completion release];
    [super dealloc];
}
#endif

- (IBAction) buttonPressed:(id) sender {
    [self close];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

+ (id) errorSheet {
    return FLAutorelease([[ZFErrorSheet alloc] initWithWindowNibName:@"ZFErrorSheet"]);
}

- (void) setErrorString:(NSString*) error {
    _textField.stringValue = error;
}

- (void) sheetClosed:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
	[[self window] orderOut:nil];
    
    if(_completion) {
        _completion();
    }
}

- (void) showInWindow:(NSWindow*) window completion:(void (^)()) completion {
     
    _completion = [completion copy]; 
     
    [self.window setFrame:
        FLRectCenterRectInRect(window.frame, self.window.frame) display:NO];
    
    [[NSApplication sharedApplication] beginSheet:self.window 
                                   modalForWindow:window
                                    modalDelegate:self
                                   didEndSelector:@selector(sheetClosed:returnCode:contextInfo:) 
                                      contextInfo:nil]; 

}


@end
