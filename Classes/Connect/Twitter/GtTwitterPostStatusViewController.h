//
//  GtTwitterPostStatusViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTextEditViewController.h"
#import "GtTwitterUserHeaderView.h"
#import "GtTwitterStatusUpdate.h"
#import "GtOAuthSession.h"
#import "GtTwitterAuthenticator.h"

@protocol GtTwitterPostStatusViewControllerDelegate;

@interface GtTwitterPostStatusViewController : GtTextEditViewController<GtTwitterAuthenticatorDelegate> {
@private
	GtTwitterUserHeaderView* m_headerView;
	GtTwitterStatusUpdate* m_statusUpdate;
	NSString* m_userGuid;
	id<GtTwitterPostStatusViewControllerDelegate> m_postDelegate;
}

@property (readwrite, retain, nonatomic) NSString* userGuid;
@property (readwrite, retain, nonatomic) GtTwitterStatusUpdate* statusUpdate;

- (id) initWithStatusUpdate:(GtTwitterStatusUpdate*) update userGuid:(NSString*) userGuid;

+ (GtTwitterPostStatusViewController*) twitterPostStatusViewController:(GtTwitterStatusUpdate*) update  userGuid:(NSString*) userGuid;

- (void) presentInViewController:(GtViewController*) viewController delegate:(id<GtTwitterPostStatusViewControllerDelegate>) delegate;

@end

@protocol GtTwitterPostStatusViewControllerDelegate <NSObject>
- (void) twitterPostStatusViewController:(GtTwitterPostStatusViewController*) controller didPostStatus:(GtTwitterStatusUpdate*) status;
- (void) twitterPostStatusViewController:(GtTwitterPostStatusViewController*) controller didFail:(NSError*) error;
- (void) twitterPostStatusViewControllerWasCancelled:(GtTwitterPostStatusViewController*) controller;
@end