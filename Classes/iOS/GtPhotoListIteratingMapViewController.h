//
//	GtPhotoListIteratingMapViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtPhotoMapViewController.h"

@protocol GtPhotoListIteratingMapViewControllerDelegate;

@interface GtPhotoListIteratingMapViewController : GtPhotoMapViewController {
@private
	id<GtPhotoListIteratingMapViewControllerDelegate> m_delegate;
	UIButton* m_prevButton;
	UIButton* m_nextButton;
}
@property (readwrite, assign, nonatomic) id<GtPhotoListIteratingMapViewControllerDelegate> delegate;
@end

@protocol GtPhotoListIteratingMapViewControllerDelegate
- (void) photoListIteratingMapViewControllerShowPreviousPhoto:(GtPhotoListIteratingMapViewController*) controller;
- (void) photoListIteratingMapViewControllerShowNextPhoto:(GtPhotoListIteratingMapViewController*) controller;
@end