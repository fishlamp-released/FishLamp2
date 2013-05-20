//
//	GtPinEditingController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtViewController.h"
#import "GtPinEditingView.h"

@protocol GtPinEditingViewControllerDelegate;

@interface GtPinEditingViewController : GtViewController<GtPinEditingViewDelegate> {
@private
	id<GtPinEditingViewControllerDelegate> m_delegate;
}

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts;

@property (readwrite, assign, nonatomic) id<GtPinEditingViewControllerDelegate> delegate;

@end

@protocol GtPinEditingViewControllerDelegate <NSObject>
- (void) pinEditViewControllerDidCancel:(GtPinEditingViewController*) controller;
@optional
- (void) pinEditViewController:(GtPinEditingViewController*) controller didSetPin:(NSString*) pin;
- (void) pinEditViewControllerUserDidEnterCorrectPin:(GtPinEditingViewController*) controller;
@end