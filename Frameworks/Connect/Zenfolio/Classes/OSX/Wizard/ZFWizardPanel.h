//
//  ZFWizardPanel.h
//  ZenLib
//
//  Created by Mike Fullerton on 1/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardPanel.h"
#import "ZFProgressSheet.h"

@interface ZFWizardPanel : FLWizardPanel {
@private
    ZFProgressSheet* _progressWindow;
    id _context;
}
@property (readwrite, strong, nonatomic) id context;

@end
