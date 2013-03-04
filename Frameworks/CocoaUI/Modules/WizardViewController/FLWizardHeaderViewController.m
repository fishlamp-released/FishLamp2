//
//  FLWizardHeaderViewController.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLWizardHeaderViewController.h"

@interface FLWizardHeaderViewController ()

@end

@implementation FLWizardHeaderViewController

@synthesize hostView = _hostView;
@synthesize titleView = _titleView;
@synthesize spinner = _spinner;

- (void)awakeFromNib {
    [super awakeFromNib];

    _spinner.hidden = YES;
    [_logoView sendToBack];
    [_titleView removeFromSuperview];
    [self.view addSubview:_titleView positioned:NSWindowAbove relativeTo:_logoView];
}


- (void) loadView {
    [super loadView];
    [self view];
    
}

- (void) addPanelView:(NSView*) view {
    [_hostView addSubview:view];
}

- (void) removePanelViews {
    for(NSView* view in _hostView.subviews) {
        [view removeFromSuperview];
    }
}


//static NSComparisonResult myCustomViewAboveSiblingViewsComparator( NSView * view1, NSView * view2, void * context )
//{    
//    if ([view1 isKindOfClass:[MyCustomView class]])    
//        return NSOrderedDescending;    
//    else if ([view2 isKindOfClass:[MyCustomView class]])    
//        return NSOrderedAscending;    
//
//    return NSOrderedSame;
//}

- (void) setTitle:(NSString*) title {
    [_logoView sendToBack];
    _titleView.stringValue = title;
    [_titleView bringToFront];
    
    
    
}

- (void) showSpinner:(BOOL) show {
    [_spinner setHidden:!show];
    if(show) {
        [_spinner startAnimation:self];
    }
    else {
        [_spinner stopAnimation:self];
    }
}

@end
