//
//  FLCropImageViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewController.h"
#import "FLCropImageView.h"

@protocol FLCropImageViewControllerDelegate;

@interface FLCropImageViewController : FLViewController {
@private
    UIImage* _image;
    FLCropImageView* _imageView;
    __unsafe_unretained id<FLCropImageViewControllerDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLCropImageViewControllerDelegate> delegate;

- (void) setImage:(UIImage*) image;

@end

@protocol FLCropImageViewControllerDelegate <NSObject>
- (void) cropImageViewController:(FLCropImageViewController*) controller didCropImage:(UIImage*) image;
- (void) cropImageViewControllerWasCancelled:(FLCropImageViewController*) controller;
@end