//
//  FLWizardHeaderViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLCompatibleViewController.h"
#import "FLPanelViewController.h"

@interface FLWizardHeaderViewController : FLCompatibleViewController<FLPanelHeader> {
@private
    IBOutlet NSTextField* _titleView;
    IBOutlet NSProgressIndicator* _spinner;
    IBOutlet NSView* _logoView;
}

@property (readonly, strong, nonatomic) NSTextField* promptTextField;
@property (readonly, strong, nonatomic) NSProgressIndicator* spinner;

- (void) setPrompt:(NSString*) title animationDuration:(CGFloat) animationDuration;

- (void) showSpinner:(BOOL) show;
@end
