//
//  FLModalShieldViewController.m
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/12/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLModalShieldViewController.h"
#import "FLModalShield.h"

@interface FLModalShieldViewController ()

@end

@implementation FLModalShieldViewController

- (UIView*) createView {
    _shieldView = FLAutorelease([[FLFingerprintView alloc] initWithFrame:CGRectZero]);
    _shieldView.autoresizesSubviews = YES;
    _shieldView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    return _shieldView;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [_sheildView showShieldInViewController:self];
}

- (void) viewWillUnload {
    [super viewWillUnload];
    FLReleaseWithNil(_shieldView);
}   

- (void) dealloc {
    FLRelease(_shieldView);
    FLSuperDealloc();
}

@end
