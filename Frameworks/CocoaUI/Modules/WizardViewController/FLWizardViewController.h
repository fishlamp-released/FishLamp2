//
//  FLWizardViewController.h
//  Zenfolio Composer
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLCocoaUIRequired.h"
#import "FLPanelWizard.h"

#import "FLWizardHeaderViewController.h"
#import "FLWizardButtonViewController.h"
#import "FLSpinningProgressView.h"


@interface FLWizardViewController : FLPanelWizard<FLWizardButtonViewControllerDelegate> {
@private
    IBOutlet FLWizardHeaderViewController* _headerViewController;
    IBOutlet FLWizardButtonViewController* _buttonViewController;
    
    IBOutlet FLSpinningProgressView* _progressView;
}

// views
@property (readonly, strong, nonatomic) FLWizardHeaderViewController* headerViewController;
@property (readonly, strong, nonatomic) FLWizardButtonViewController* buttonViewController;

+ (id) wizardViewController;

@end



#endif