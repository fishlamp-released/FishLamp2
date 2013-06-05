//
//	FLPhotoListIteratingMapViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLPhotoMapViewController.h"

@protocol FLPhotoListIteratingMapViewControllerDelegate;

@interface FLPhotoListIteratingMapViewController : FLPhotoMapViewController {
@private
	__unsafe_unretained id<FLPhotoListIteratingMapViewControllerDelegate> _delegate;
	UIButton* _prevButton;
	UIButton* _nextButton;
}
@property (readwrite, assign, nonatomic) id<FLPhotoListIteratingMapViewControllerDelegate> delegate;
@end

@protocol FLPhotoListIteratingMapViewControllerDelegate
- (void) photoListIteratingMapViewControllerShowPreviousPhoto:(FLPhotoListIteratingMapViewController*) controller;
- (void) photoListIteratingMapViewControllerShowNextPhoto:(FLPhotoListIteratingMapViewController*) controller;
@end