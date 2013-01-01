//
//  FLProgressWizardPanel.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLWizardViewController.h"
#import "FLWizardPanel.h"
#import "FLFlipAnimation.h"
#import "FLView.h"

@interface FLProgressWizardPanelView : FLView {
}
@end

@interface FLProgressWizardPanelProgressView : FLProgressWizardPanelView {
@private
    IBOutlet NSProgressIndicator* _progressIndicator;
    IBOutlet NSTextField* _progressLabel;
}
@property (readonly, strong, nonatomic) NSProgressIndicator* progressIndicator;
@property (readonly, strong, nonatomic) NSTextField* progressLabel;
@property (readwrite, strong, nonatomic) NSString* progressText;
@end

@interface FLProgressWizardPanelTextView : FLProgressWizardPanelView {
@private
    IBOutlet NSTextField* _textLabel;
}
@property (readonly, strong, nonatomic) NSTextField* textField;
@property (readwrite, strong, nonatomic) NSString* textValue;
@end

@interface FLProgressWizardPanel : FLWizardPanel {
@private
    IBOutlet FLProgressWizardPanelProgressView* _progressView1;
    IBOutlet FLProgressWizardPanelProgressView* _progressView2;
    IBOutlet FLProgressWizardPanelTextView* _textView1;
    IBOutlet FLProgressWizardPanelTextView* _textView2;
    
    UIView* _currentView;
}

@property (readonly, strong, nonatomic) FLProgressWizardPanelProgressView* progressView1;
@property (readonly, strong, nonatomic) FLProgressWizardPanelProgressView* progressView2;
@property (readonly, strong, nonatomic) FLProgressWizardPanelTextView* textView1;
@property (readonly, strong, nonatomic) FLProgressWizardPanelTextView* textView2;

+ (id) progressWizardPanel;

- (void) flipToNextViewWithDirection:(FLFlipAnimationDirection) direction 
                            nextView:(UIView*) nextView
                            completion:(void (^)()) completion;

@property (readwrite, strong, nonatomic) UIView* currentView;

- (void) setInitialView:(UIView*) view;

@end


