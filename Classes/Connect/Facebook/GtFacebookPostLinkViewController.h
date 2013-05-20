//
//  GtFacebookPostLinkViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTextEditViewController.h"
#import "GtUserHeaderView.h"
#import "GtFacebookLink.h"
#import "GtFacebookUserHeader.h"
#import "GtLabel.h"
#import "GtFacebookAuthenticator.h"

@protocol GtFacebookPostLinkViewControllerDelegate;

@interface GtFacebookPostLinkViewController : GtTextEditViewController<GtFacebookAuthenticatorDelegate> {
@private
	GtFacebookUserHeader* m_headerView;
	GtFacebookLink* m_link;
	GtLabel* m_linkLabel;
	id<GtFacebookPostLinkViewControllerDelegate> m_postLinkDelegate;
}

- (id) initWithLink:(GtFacebookLink*) fbLink;

+ (GtFacebookPostLinkViewController*) facebookPostLinkViewController;
+ (GtFacebookPostLinkViewController*) facebookPostLinkViewController:(GtFacebookLink*) fbLink;

//- (void) beginPostingLink:(GtFacebookLink*) link;

- (void) presentInViewController:(GtViewController*) viewController 
	delegate:(id<GtFacebookPostLinkViewControllerDelegate>) delegate;

@end

@protocol GtFacebookPostLinkViewControllerDelegate <NSObject>
- (void) facebookPostLinkViewControllerDidPostLink:(GtFacebookPostLinkViewController*) controller;
- (void) facebookPostLinkViewController:(GtFacebookPostLinkViewController*) controller didFailWithError:(NSError*) error;
- (void) facebookPostLinkViewControllerWasCancelled:(GtFacebookPostLinkViewController*) controller;
@end