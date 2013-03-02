//
//  FLRootWizardView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FLWizardViewController;

@interface FLRootWizardView : NSView {
@private
    __unsafe_unretained FLWizardViewController* _wizard;
}
@property (readwrite, assign, nonatomic) FLWizardViewController* wizard;

@end
