//
//  FLWizardWindowController.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWizardWindowController.h"

@interface FLWizardWindowController ()
@end

@implementation FLWizardWindowController

@synthesize wizardViewController = _wizardViewController;

- (id) init {
    return [self initWithWizardClasses:nil];
}

- (id) initWithWizardClasses:(NSArray*) wizardClassArray {
    self = [self initWithWindowNibName:@"FLWizardWindowController"];
    if(self) {
        _wizardClasses = retain_(wizardClassArray);
    }
    return self;
}

+ (id) wizardWindowController{
    return autorelease_([[[self class] alloc] init]);
}

+ (id) wizardWindowController:(NSArray*) wizardClassArray {
    return autorelease_([[[self class] alloc] initWithWizardClasses:wizardClassArray]);
}

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
    [_wizardViewController release];
    [super dealloc];
}
#endif

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    _wizardViewController = [[FLWizardViewController alloc] init];
    [self.window setContentView:_wizardViewController.view];
    [self.window setDefaultButtonCell:[_wizardViewController.nextButton cell]];
    
    [_wizardViewController startWizardWithPanelClasses:_wizardClasses];
}

@end
