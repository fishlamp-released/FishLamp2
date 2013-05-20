//
//	FLPinEditingController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLViewController.h"
#import "FLPinEditingView.h"

@protocol FLPinEditingViewControllerDelegate;

@interface FLPinEditingViewController : FLViewController<FLPinEditingViewDelegate> {
@private
	__unsafe_unretained id<FLPinEditingViewControllerDelegate> _delegate;
}

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts;

@property (readwrite, assign, nonatomic) id<FLPinEditingViewControllerDelegate> delegate;

@end

@protocol FLPinEditingViewControllerDelegate <NSObject>
- (void) pinEditViewControllerDidCancel:(FLPinEditingViewController*) controller;
@optional
- (void) pinEditViewController:(FLPinEditingViewController*) controller didSetPin:(NSString*) pin;
- (void) pinEditViewControllerUserDidEnterCorrectPin:(FLPinEditingViewController*) controller;
@end