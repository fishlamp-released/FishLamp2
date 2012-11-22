//
//	FLPhotoListIteratingMapViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
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