//
//  FLWizardWindowController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLWizardViewController.h"

@interface FLWizardWindowController : NSWindowController {
@private
    FLWizardViewController* _wizardViewController;
    NSArray* _wizardClasses;
}

@property (readonly, strong, nonatomic) FLWizardViewController* wizardViewController;

+ (id) wizardWindowController;
+ (id) wizardWindowController:(NSArray*) wizardClassArray;
- (id) initWithWizardClasses:(NSArray*) wizardClassArray;

@end
