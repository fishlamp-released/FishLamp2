//
//  FLWizardHeaderViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLPanelViewController.h"

@interface FLWizardHeaderViewController : FLCompatibleViewController<FLPanelHeader> {
@private
    IBOutlet NSTextField* _titleView;
    IBOutlet NSView* _logoView;
    IBOutlet NSButton* _logoutButton;
    IBOutlet NSTextField* _welcomeText;
}

@property (readonly, strong, nonatomic) NSTextField* promptTextField;

- (void) setPrompt:(NSString*) title animationDuration:(CGFloat) animationDuration;
- (void) setWelcomeText:(NSString*) welcomeText;

@end
