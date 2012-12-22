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

@interface FLProgressWizardPanel : FLWizardPanel {
@private
    IBOutlet NSProgressIndicator* _progress;
    IBOutlet NSTextField* _progressLabel;
    
    IBOutlet NSView* _progressContainer;
    IBOutlet NSView* _errorContainer;
    
    IBOutlet NSTextField* _errorLabel;
}

@property (readonly, strong, nonatomic) UIView* progressContainer;
@property (readonly, strong, nonatomic) UIView* errorContainer;

@property (readonly, strong, nonatomic) NSProgressIndicator* progress;
@property (readonly, strong, nonatomic) NSTextField* progressLabel;

@property (readwrite, strong, nonatomic) NSString* progressText;
@property (readwrite, strong, nonatomic) NSString* errorText;

+ (id) progressWizardPanel;

- (void) flipViews:(FLFlipAnimationDirection) direction duration:(CGFloat) duration;

@end
