//
//  FLWizardHeaderViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FLWizardHeaderViewController : NSViewController {
@private
    IBOutlet NSView* _hostView;
    IBOutlet NSTextField* _titleView;
    IBOutlet NSProgressIndicator* _spinner;
    IBOutlet NSView* _logoView;
}

@property (readonly, strong, nonatomic) NSTextField* titleView;
@property (readonly, strong, nonatomic) NSView* hostView;
@property (readonly, strong, nonatomic) NSProgressIndicator* spinner;

- (void) addPanelView:(NSView*) view;
- (void) removePanelViews;

- (void) setTitle:(NSString*) title;

- (void) showSpinner:(BOOL) show;
@end
