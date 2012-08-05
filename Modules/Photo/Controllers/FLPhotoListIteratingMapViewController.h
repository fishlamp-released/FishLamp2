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
	id<FLPhotoListIteratingMapViewControllerDelegate> m_delegate;
	UIButton* m_prevButton;
	UIButton* m_nextButton;
}
@property (readwrite, assign, nonatomic) id<FLPhotoListIteratingMapViewControllerDelegate> delegate;
@end

@protocol FLPhotoListIteratingMapViewControllerDelegate
- (void) photoListIteratingMapViewControllerShowPreviousPhoto:(FLPhotoListIteratingMapViewController*) controller;
- (void) photoListIteratingMapViewControllerShowNextPhoto:(FLPhotoListIteratingMapViewController*) controller;
@end