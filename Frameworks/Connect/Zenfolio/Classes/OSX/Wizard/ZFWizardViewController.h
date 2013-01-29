//
//  ZFWizardViewController.h
//  ZenLib
//
//  Created by Mike Fullerton on 1/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardViewController.h"
#import "ZFProgressSheet.h"
#import "NSFont+ZFAdditions.h"
#import "NSColor+ZFAdditions.h"


@interface ZFWizardViewController : FLWizardViewController {
@private
    ZFProgressSheet* _progressWindow;
}

@property (readonly, strong, nonatomic) ZFProgressSheet* progressWindow;

- (void) showProgress:(NSString*) title;
- (void) hideProgress;

- (void) showError:(NSString*) error;

@end

