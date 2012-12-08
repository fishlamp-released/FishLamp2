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

@interface FLProgressWizardPanel : FLWizardPanel {
@private
    IBOutlet NSProgressIndicator* _progress;
    IBOutlet NSTextField* _progressLabel;
}
@property (readonly, strong, nonatomic) NSProgressIndicator* progress;
@property (readonly, strong, nonatomic) NSTextField* progressLabel;

@property (readwrite, strong, nonatomic) NSString* progressText;

+ (id) progressWizardPanel;

@end
