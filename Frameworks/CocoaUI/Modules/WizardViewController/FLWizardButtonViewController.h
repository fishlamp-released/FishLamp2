//
//  FLWizardButtonViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FLWizardButtonViewController : NSViewController {
@private
    IBOutlet NSButton* _nextButton;
    IBOutlet NSButton* _backButton;
    IBOutlet NSButton* _otherButton;

}

@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* backButton;
@property (readonly, strong, nonatomic) NSButton* otherButton;

@end
