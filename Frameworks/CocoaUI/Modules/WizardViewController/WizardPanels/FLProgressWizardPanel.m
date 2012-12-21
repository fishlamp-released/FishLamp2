//
//  FLProgressWizardPanel.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLProgressWizardPanel.h"
#import "UIViewController+FLAdditions.h"

@interface FLProgressWizardPanel ()

@end

@implementation FLProgressWizardPanel

@synthesize progress = _progress;
@synthesize progressLabel = _progressLabel;
@synthesize progressContainer = _progressContainer;
@synthesize errorContainer = _errorContainer;

#if FL_MRC
- (void) dealloc {
//    [_progress release];
//    [_progressLabel release];
    [super dealloc];
}
#endif

- (id) init {
    return [self initWithDefaultNibName];
}

+ (id) progressWizardPanel {
    return FLAutorelease([[[self class] alloc] initWithDefaultNibName]);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (void) wizardPanelWillAppear {
    [self.progress startAnimation:self];
}

- (NSString*) progressText {
    return _progressLabel.stringValue;
}

- (void) setProgressText:(NSString*) text {
    _progressLabel.stringValue = text;
}

- (NSString*) errorText {
    return _errorLabel.stringValue;
}

- (void) setErrorText:(NSString*) text {
    _errorLabel.stringValue = text;
}

@end
