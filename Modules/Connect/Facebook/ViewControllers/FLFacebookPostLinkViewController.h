//
//  FLFacebookPostLinkViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
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
	FLFacebookUserHeader* m_headerView;
	FLFacebookLink* m_link;
	FLLabel* m_linkLabel;
	id<FLFacebookPostLinkViewControllerDelegate> m_postLinkDelegate;
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