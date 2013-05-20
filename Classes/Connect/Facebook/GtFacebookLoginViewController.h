//
//  GtFacebookLoginViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWebViewController.h"
#import "GtFacebookMgr.h"

@protocol GtFacebookLoginViewControllerDelegate;

@interface GtFacebookLoginViewController : GtWebViewController {
}

@property (readwrite, assign, nonatomic) id<GtFacebookLoginViewControllerDelegate> facebookLoginViewControllerDelegate;

- (void) beginLoadingURL:(NSURL*) url delegate:(id<GtFacebookLoginViewControllerDelegate>) delegate;

@end

@protocol GtFacebookLoginViewControllerDelegate <GtWebViewControllerDelegate>

- (void) facebookLoginViewControllerDelegate:(GtFacebookLoginViewController*) controller didAuthenticate:(GtFacebookNetworkSession*) session;
- (void) facebookLoginViewControllerDelegate:(GtFacebookLoginViewController*) controller didFail:(NSError*) error;

@end