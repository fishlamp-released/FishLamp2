//
//  FLFacebookPostLinkViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTextEditViewController.h"
#import "FLUserHeaderView.h"
#import "FLFacebookLink.h"
#import "FLFacebookUserHeader.h"
#import "FLLabel.h"
#import "FLFacebookAuthenticator.h"

@protocol FLFacebookPostLinkViewControllerDelegate;

@interface FLFacebookPostLinkViewController : FLTextEditViewController<FLFacebookAuthenticatorDelegate> {
@private
	FLFacebookUserHeader* _headerView;
	FLFacebookLink* _link;
	FLLabel* _linkLabel;
	id<FLFacebookPostLinkViewControllerDelegate> _postLinkDelegate;
}

- (id) initWithLink:(FLFacebookLink*) fbLink;

+ (FLFacebookPostLinkViewController*) facebookPostLinkViewController;
+ (FLFacebookPostLinkViewController*) facebookPostLinkViewController:(FLFacebookLink*) fbLink;

//- (void) beginPostingLink:(FLFacebookLink*) link;

- (void) presentInViewController:(FLViewController*) viewController 
	delegate:(id<FLFacebookPostLinkViewControllerDelegate>) delegate;

@end

@protocol FLFacebookPostLinkViewControllerDelegate <NSObject>
- (void) facebookPostLinkViewControllerDidPostLink:(FLFacebookPostLinkViewController*) controller;
- (void) facebookPostLinkViewController:(FLFacebookPostLinkViewController*) controller didFailWithError:(NSError*) error;
- (void) facebookPostLinkViewControllerWasCancelled:(FLFacebookPostLinkViewController*) controller;
@end