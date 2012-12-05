//
//  FLWizardViewController.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLClickablePathViewController.h"

@protocol FLWizardViewControllerDelegate;

@interface FLWizardViewController : NSViewController<FLClickablePathViewControllerDelegate> {
@private
    NSMutableArray* _viewStack;
    NSButton* _nextButton;
    NSButton* _previousButton;
    NSButton* _cancelButton;
    
    id<FLWizardViewControllerDelegate> _delegate;
}

@property (readwrite, strong, nonatomic) IBOutlet NSButton* nextButton;
@property (readwrite, strong, nonatomic) IBOutlet NSButton* previousButton;
@property (readwrite, strong, nonatomic) IBOutlet NSButton* cancelButton;
@property (readonly, strong, nonatomic) NSViewController* visibleViewController;
@property (readwrite, assign, nonatomic) IBOutlet id<FLWizardViewControllerDelegate> delegate;

- (NSViewController*) popViewControllerAnimated:(BOOL) animated;
- (void) pushViewController:(NSViewController*) viewController animated:(BOOL) animated;

@end

@protocol FLWizardViewControllerDelegate <NSObject>

@end