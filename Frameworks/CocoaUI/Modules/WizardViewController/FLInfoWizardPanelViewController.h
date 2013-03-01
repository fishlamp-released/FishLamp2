//
//  FLInfoWizardPanelViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 2/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardPanel.h"

@interface FLInfoWizardPanelViewController : FLWizardPanel {
@private
    IBOutlet NSView* _infoBoxView;
    IBOutlet NSTextField* _textField;
}

@property (readonly, strong, nonatomic) NSView* boxView;
@property (readonly, strong, nonatomic) NSTextField* textField;

@end
