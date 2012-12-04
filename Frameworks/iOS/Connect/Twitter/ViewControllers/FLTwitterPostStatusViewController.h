//
//  FLTwitterPostStatusViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTextEditViewController.h"
#import "FLTwitterUserHeaderView.h"
#import "FLTwitterStatusUpdate.h"
#import "FLOAuthSession.h"
#import "FLTwitterAuthenticator.h"

@protocol FLTwitterPostStatusViewControllerDelegate;

@interface FLTwitterPostStatusViewController : FLTextEditViewController<FLTwitterAuthenticatorDelegate> {
@private
	FLTwitterUserHeaderView* _headerView;
	FLTwitterStatusUpdate* _statusUpdate;
	NSString* _userGuid;
	id<FLTwitterPostStatusViewControllerDelegate> _postDelegate;
}

@property (readwrite, retain, nonatomic) NSString* userGuid;
@property (readwrite, retain, nonatomic) FLTwitterStatusUpdate* statusUpdate;

- (id) initWithStatusUpdate:(FLTwitterStatusUpdate*) update userGuid:(NSString*) userGuid;

+ (FLTwitterPostStatusViewController*) twitterPostStatusViewController:(FLTwitterStatusUpdate*) update  userGuid:(NSString*) userGuid;

- (void) presentInViewController:(FLViewController*) viewController delegate:(id<FLTwitterPostStatusViewControllerDelegate>) delegate;

@end

@protocol FLTwitterPostStatusViewControllerDelegate <NSObject>
- (void) twitterPostStatusViewController:(FLTwitterPostStatusViewController*) controller didPostStatus:(FLTwitterStatusUpdate*) status;
- (void) twitterPostStatusViewController:(FLTwitterPostStatusViewController*) controller didFail:(NSError*) error;
- (void) twitterPostStatusViewControllerWasCancelled:(FLTwitterPostStatusViewController*) controller;
@end