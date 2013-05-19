//
//  FLFacebookLoginViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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