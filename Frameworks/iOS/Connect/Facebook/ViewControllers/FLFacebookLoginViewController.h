//
//  FLFacebookLoginViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWebViewController.h"
#import "FLFacebookMgr.h"

@protocol FLFacebookLoginViewControllerDelegate;

@interface FLFacebookLoginViewController : FLWebViewController {
}

@property (readwrite, assign, nonatomic) id<FLFacebookLoginViewControllerDelegate> facebookLoginViewControllerDelegate;

- (void) beginLoadingURL:(NSURL*) url delegate:(id<FLFacebookLoginViewControllerDelegate>) delegate;

@end

@protocol FLFacebookLoginViewControllerDelegate <FLWebViewControllerDelegate>

- (void) facebookLoginViewControllerDelegate:(FLFacebookLoginViewController*) controller didAuthenticate:(FLFacebookNetworkSession*) session;
- (void) facebookLoginViewControllerDelegate:(FLFacebookLoginViewController*) controller didFail:(NSError*) error;

@end