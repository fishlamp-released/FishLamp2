//
//  FLErrorWindowController.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSWindowController+FLModalAdditions.h"
#import "FLErrorWindowController.h"
#import "NSError+FLTimeout.h"

@interface FLErrorWindowController ()

@end

@implementation FLErrorWindowController
@synthesize okButton = _okButton;

- (id) initWithTitle:(NSString*) title explanation:(NSString*) explanation {	
	self = [super initWithWindowNibName:@"FLErrorWindowController"];
	if(self) {
		_title = FLRetain(title);
        _explanation = FLRetain(explanation);
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_title release];
    [_explanation release];
    [super dealloc];
}
#endif

+ (id) errorWindowController:(NSString*) title explanation:(NSString*) explanation {
    return FLAutorelease([[[self class] alloc] initWithTitle:title explanation:explanation]);
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    _titleField.stringValue = _title;
    if(FLStringIsNotEmpty(_explanation)) {
        [_explanationField.textStorage appendAttributedString:FLAutorelease([[NSAttributedString alloc] initWithString:_explanation]) ];
    }
}


@end

@implementation NSViewController (FLErrorWindowController)

- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error {
    if(![error isCancelError]) {
   
// TODO (MWF): double dispatch this back into the error?
     
        if([error isTimeoutError]) {
            title = NSLocalizedString(@"An operation on the server timed out.", nil);
            caption = NSLocalizedString(@"Please check your connection and try again.", nil);
        }
        
        if(!title) {
            title = NSLocalizedString(@"An error occurred", nil);
        }
        if(!caption) {
            caption = error.localizedDescription;
        }
        
        FLErrorWindowController* controller = [FLErrorWindowController errorWindowController:title explanation:caption];
                       
        [self showModalWindow:controller withDefaultButton:controller.okButton];
    }

}

@end


@implementation NSWindowController (FLErrorWindowController)

- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error {
    if(![error isCancelError]) {
   
// TODO (MWF): double dispatch this back into the error?
     
        if([error isTimeoutError]) {
            title = NSLocalizedString(@"An operation on the server timed out.", nil);
            caption = NSLocalizedString(@"Please check your connection and try again.", nil);
        }
        
        if(!title) {
            title = NSLocalizedString(@"An error occurred", nil);
        }
        if(!caption) {
            caption = error.localizedDescription;
        }
        
        FLErrorWindowController* controller = [FLErrorWindowController errorWindowController:title explanation:caption];
                       
        [self.window showModalWindow:controller withDefaultButton:controller.okButton];
    }

}

@end