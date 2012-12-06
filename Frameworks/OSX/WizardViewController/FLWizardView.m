//
//  FLWizardView.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWizardView.h"

@implementation FLWizardView

@synthesize nextButton = _nextButton;
@synthesize previousButton = _previousButton;
@synthesize cancelButton = _cancelButton;

#if FL_MRC
- (void) dealloc {
    [_nextButton release];
    [_previousButton release];
    [_cancelButton release];
    [super dealloc];
}
#endif


@end
