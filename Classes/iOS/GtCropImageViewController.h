//
//  GtCropImageViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewController.h"
#import "GtCropImageView.h"

@protocol GtCropImageViewControllerDelegate;

@interface GtCropImageViewController : GtViewController {
@private
    UIImage* m_image;
    GtCropImageView* m_imageView;
    id<GtCropImageViewControllerDelegate> m_delegate;
}

@property (readwrite, assign, nonatomic) id<GtCropImageViewControllerDelegate> delegate;

- (void) setImage:(UIImage*) image;

@end

@protocol GtCropImageViewControllerDelegate <NSObject>
- (void) cropImageViewController:(GtCropImageViewController*) controller didCropImage:(UIImage*) image;
- (void) cropImageViewControllerWasCancelled:(GtCropImageViewController*) controller;
@end